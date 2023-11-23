import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import 'data_view_expander.dart';
import 'event_bus.dart';
import 'filesystem_adapter.dart';
import 'javascript_handlers.dart';
import 'services/services.dart';
import 'string_processor.dart';
import 'ui_bridge.dart';
import 'webview_constants.dart' as webview_constants;

typedef RuntimeConfig = ({
  String baseUrl,
  String clientId,
  String clientSecret,
  String applicationId,
  bool useAppleSandbox,
});

class EnmeshedRuntime {
  static String _assetsFolder = 'packages/enmeshed_runtime_bridge/assets';

  bool _isReady = false;
  bool get isReady => _isReady;

  final RuntimeConfig runtimeConfig;

  late final HeadlessInAppWebView _headlessWebView;

  final _filesystemAdapter = FilesystemAdapter();
  final _jsToUIBridge = JsToUIBridge();

  final VoidCallback? _runtimeReadyCallback;

  late final AccountServices _accountServices;
  AccountServices get accountServices => _accountServices;

  late final AnonymousServices _anonymousServices;
  AnonymousServices get anonymousServices => _anonymousServices;

  late final StringProcessor _stringProcessor;
  StringProcessor get stringProcessor {
    assert(_isReady, 'Runtime not ready');

    return _stringProcessor;
  }

  late final Session _currentSession;
  Session get currentSession => _currentSession;

  final Logger _logger;
  final _runtimeReadyCompleter = Completer();

  final EventBus eventBus;

  EnmeshedRuntime({
    Logger? logger,
    VoidCallback? runtimeReadyCallback,
    required this.runtimeConfig,
    EventBus? eventBus,
  })  : _logger = logger ?? Logger(printer: SimplePrinter(colors: false)),
        _runtimeReadyCallback = runtimeReadyCallback,
        eventBus = eventBus ?? EventBus() {
    if (runtimeConfig.baseUrl.isEmpty) throw Exception('Missing runtimeConfig value: baseUrl');
    if (runtimeConfig.clientId.isEmpty) throw Exception('Missing runtimeConfig value: clientId');
    if (runtimeConfig.clientSecret.isEmpty) throw Exception('Missing runtimeConfig value: clientSecret');
    if (runtimeConfig.applicationId.isEmpty) throw Exception('Missing runtimeConfig value: applicationId');

    _headlessWebView = HeadlessInAppWebView(
      initialData: webview_constants.initialData,
      onWebViewCreated: (controller) async {
        _jsToUIBridge.controller = controller;
        await _addJavaScriptHandlers(controller);
        _logger.i('WebView created');
      },
      onConsoleMessage: (_, consoleMessage) {
        _logger.i('js runtime: ${consoleMessage.message}');
      },
      onLoadStop: (controller, _) async {
        await _loadLibs(controller);
      },
    );

    final anonymousEvaluator = Evaluator.anonymous(this);
    _accountServices = AccountServices(anonymousEvaluator);
    _anonymousServices = AnonymousServices(anonymousEvaluator);
    _stringProcessor = StringProcessor(anonymousEvaluator);

    _currentSession = Session(Evaluator.currentSession(this));
  }

  @visibleForTesting
  static void setAssetsFolder(String assetsFolder) => _assetsFolder = assetsFolder;

  Session getSession(String accountReference) => Session(Evaluator.account(this, accountReference));

  Future<void> selectAccount(String accountReference) async {
    final result = await _evaluateJavaScript('await runtime.selectAccount(accountReference, password)', arguments: {
      'accountReference': accountReference,
      'password': '',
    });
    result.throwOnError();
  }

  Future<void> _addJavaScriptHandlers(InAppWebViewController controller) async {
    controller.addJavaScriptHandler(
      handlerName: 'handleRuntimeEvent',
      callback: (args) => handleRuntimeEventCallback(args, eventBus, _logger),
    );

    controller.addFilesystemJavaScriptHandlers(_filesystemAdapter);

    controller.addJavaScriptHandler(
      handlerName: 'runtimeReady',
      callback: (_) {
        _isReady = true;
        _runtimeReadyCallback?.call();
        _runtimeReadyCompleter.complete();
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'getDefaultConfig',
      callback: (_) => {
        'applicationId': runtimeConfig.applicationId,
        if (Platform.isIOS || Platform.isMacOS) 'applePushEnvironment': runtimeConfig.useAppleSandbox ? 'Development' : 'Production',
        'transport': {
          'baseUrl': runtimeConfig.baseUrl,
          'logLevel': 'warn',
          'datawalletEnabled': true,
          'platformClientId': runtimeConfig.clientId,
          'platformClientSecret': runtimeConfig.clientSecret,
        },
        'pushToken': null,
      },
    );

    controller.addDeviceInfoJavaScriptHandler();
    controller.addLocalNotificationsJavaScriptHandlers();
  }

  /// Register the [UIBridge] to communicate with the native UI.
  /// This must be called after the runtime is ready.
  Future<void> registerUIBridge(UIBridge uiBridge) async {
    if (!_isReady) {
      throw Exception('Runtime not ready');
    }

    final isFirstRegistration = !_jsToUIBridge.isRegistered;

    _jsToUIBridge.register(uiBridge);

    if (isFirstRegistration) await _evaluateJavaScript('window.registerUIBridge()');
  }

  Future<void> _loadLibs(InAppWebViewController controller) async {
    await controller.injectJavascriptFileFromAsset(assetFilePath: '$_assetsFolder/loki.js');
    await controller.injectJavascriptFileFromAsset(assetFilePath: '$_assetsFolder/index.js');
  }

  Future<EnmeshedRuntime> run() async {
    await _headlessWebView.run();
    await _runtimeReadyCompleter.future;

    return this;
  }

  Future<void> dispose() async {
    _isReady = false;
    await _headlessWebView.dispose();
  }

  Future<CallAsyncJavaScriptResult> _evaluateJavaScript(
    String source, {
    Map<String, dynamic> arguments = const <String, dynamic>{},
  }) async {
    if (!_isReady) {
      throw Exception('Runtime not ready');
    }

    final resultOrNull = await _headlessWebView.webViewController.callAsyncJavaScript(
      functionBody: source,
      arguments: arguments,
    );

    if (resultOrNull == null) {
      throw Exception('result is null');
    }

    final result = resultOrNull;
    if (result.value is Map<String, dynamic> || result.value is List<Map<String, dynamic>>) return result;

    if (result.value is Map) result.value = _transformValue(result.value as Map);
    if (result.value is List) result.value = _transformList(result.value as List);

    return result;
  }

  Map<String, dynamic> _transformValue(Map value) {
    final transformedValue = Map<String, dynamic>.from(value);
    for (final entry in transformedValue.entries) {
      if (entry.value is Map) {
        transformedValue[entry.key] = _transformValue(entry.value as Map);
      } else if (entry.value is List) {
        transformedValue[entry.key] = _transformList(entry.value as List);
      }
    }

    return transformedValue;
  }

  List<dynamic> _transformList(List value) {
    return value
        .map((e) => switch (e) {
              final Map m => _transformValue(m),
              final List l => _transformList(l),
              _ => e,
            })
        .toList();
  }

  Future<void> setPushToken(String token) async {
    assert(_isReady, 'Runtime not ready');

    final result = await _evaluateJavaScript('await window.setPushToken(token)', arguments: {'token': token});
    result.throwOnError();
  }

  Future<void> triggerRemoteNotificationEvent({
    required Map<String, dynamic> content,
    String? id,
    bool? foreground,
    String? limitedProcessingTime,
  }) async {
    assert(_isReady, 'Runtime not ready');

    final result = await _evaluateJavaScript('await window.triggerRemoteNotificationEvent(notification)', arguments: {
      'notification': {
        'content': content,
        'id': id,
        'foreground': foreground,
        'limitedProcessingTime': limitedProcessingTime,
      }
    });
    result.throwOnError();
  }

  Future<void> triggerAppReadyEvent() async {
    assert(_isReady, 'Runtime not ready');

    final result = await _evaluateJavaScript('await window.triggerAppReadyEvent()');
    result.throwOnError();
  }
}

class Evaluator extends AbstractEvaluator {
  final EnmeshedRuntime _runtime;

  final String? _accountReference;
  final bool _isAnonymous;

  String get sessionEvaluation => (_accountReference == null) ? 'runtime.currentSession' : 'await runtime.getOrCreateSession("$_accountReference")';
  String get sessionStorage => _isAnonymous ? '' : 'const session = $sessionEvaluation;\n';

  Evaluator._(this._runtime, {String? accountReference, bool isAnonymous = false})
      : _accountReference = accountReference,
        _isAnonymous = isAnonymous;

  Evaluator.account(EnmeshedRuntime runtime, String accountReference) : this._(runtime, accountReference: accountReference);
  Evaluator.currentSession(EnmeshedRuntime runtime) : this._(runtime);
  Evaluator.anonymous(EnmeshedRuntime runtime) : this._(runtime, isAnonymous: true);

  @override
  Future<CallAsyncJavaScriptResult> evaluateJavaScript(
    String source, {
    Map<String, dynamic> arguments = const <String, dynamic>{},
  }) async {
    return _runtime._evaluateJavaScript('$sessionStorage$source', arguments: arguments);
  }
}

class Session {
  final TransportServices _transportServices;
  TransportServices get transportServices => _transportServices;

  final ConsumptionServices _consumptionServices;
  ConsumptionServices get consumptionServices => _consumptionServices;

  final DataViewExpander _expander;
  DataViewExpander get expander => _expander;

  Session(AbstractEvaluator evaluator)
      : _transportServices = TransportServices(evaluator),
        _consumptionServices = ConsumptionServices(evaluator),
        _expander = DataViewExpander(evaluator);
}
