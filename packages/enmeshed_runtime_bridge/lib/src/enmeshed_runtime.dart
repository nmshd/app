import 'dart:async';
import 'dart:ui';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import 'filesystem_adapter.dart';
import 'services/services.dart';
import 'webview_constants.dart' as webview_constants;

class EnmeshedRuntime {
  static String _assetsFolder = 'packages/enmeshed_runtime_bridge/assets';

  bool _isReady = false;
  bool get isReady => _isReady;

  late final HeadlessInAppWebView _headlessWebView;

  final _filesystemAdapter = FilesystemAdapter();

  final VoidCallback? _runtimeReadyCallback;

  late final AccountServices _accountServices;
  AccountServices get accountServices => _accountServices;

  late final AnonymousServices _anonymousServices;
  AnonymousServices get anonymousServices => _anonymousServices;

  late final Session _currentSession;
  Session get currentSession => _currentSession;

  final Logger _logger;
  final _runtimeReadyCompleter = Completer();

  EnmeshedRuntime({
    Logger? logger,
    VoidCallback? runtimeReadyCallback,
  })  : _logger = logger ?? Logger(printer: SimplePrinter(colors: false)),
        _runtimeReadyCallback = runtimeReadyCallback {
    _headlessWebView = HeadlessInAppWebView(
      initialData: webview_constants.initialData,
      onWebViewCreated: (controller) async {
        await addJavaScriptHandlers(controller);
        _logger.i('WebView created');
      },
      onConsoleMessage: (_, consoleMessage) {
        _logger.i('js runtime: ${consoleMessage.message}');
      },
      onLoadStop: (controller, _) async {
        await loadLibs(controller);
      },
    );

    final anonymousEvaluator = Evaluator.anonymous(this);
    _accountServices = AccountServices(anonymousEvaluator);
    _anonymousServices = AnonymousServices(anonymousEvaluator);

    _currentSession = Session(Evaluator.currentSession(this));
  }

  @visibleForTesting
  static void setAssetsFolder(String assetsFolder) => _assetsFolder = assetsFolder;

  Session getSession(String accountReference) => Session(Evaluator.account(this, accountReference));

  Future<void> selectAccount(String accountReference) async {
    final result = await evaluateJavascript('await runtime.selectAccount(accountReference, password)', arguments: {
      'accountReference': accountReference,
      'password': '',
    });
    result.throwOnError();
  }

  Future<void> addJavaScriptHandlers(InAppWebViewController controller) async {
    controller.addJavaScriptHandler(
      handlerName: 'publishEvent',
      callback: (args) async {
        final payload = args[0];
        _logger.i('Event published: $payload');
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'readFile',
      callback: (args) async {
        final path = args[0] as String;
        final storage = args[1] as String;

        try {
          final fileContent = await _filesystemAdapter.readFile(path, storage);
          return {'ok': true, 'content': fileContent};
        } catch (e) {
          _logger.i('Error reading file: $e');
          return {'ok': false, 'content': e.toString()};
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'writeFile',
      callback: (args) async {
        final path = args[0] as String;
        final storage = args[1] as String;
        final data = args[2] as String;
        final append = args[3] as bool;

        try {
          await _filesystemAdapter.writeFile(path, storage, data, append);
          return {'ok': true};
        } catch (e) {
          _logger.i('Error writing file: $e');
          return {'ok': false, 'content': e.toString()};
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'deleteFile',
      callback: (args) async {
        final path = args[0] as String;
        final storage = args[1] as String;

        try {
          await _filesystemAdapter.deleteFile(path, storage);
          return {'ok': true};
        } catch (e) {
          _logger.i('Error deleting file: $e');
          return {'ok': false, 'content': e.toString()};
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'runtimeReady',
      callback: (_) {
        _isReady = true;
        _runtimeReadyCallback?.call();
        _runtimeReadyCompleter.complete();
      },
    );
  }

  Future<void> loadLibs(InAppWebViewController controller) async {
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

  Future<CallAsyncJavaScriptResult> evaluateJavascript(
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

    return resultOrNull;
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
  Future<CallAsyncJavaScriptResult> evaluateJavascript(
    String source, {
    Map<String, dynamic> arguments = const <String, dynamic>{},
  }) async {
    return _runtime.evaluateJavascript('$sessionStorage$source', arguments: arguments);
  }
}

class Session {
  final TransportServices _transportServices;
  TransportServices get transportServices => _transportServices;

  final ConsumptionServices _consumptionServices;
  ConsumptionServices get consumptionServices => _consumptionServices;

  Session(AbstractEvaluator evaluator)
      : _transportServices = TransportServices(evaluator),
        _consumptionServices = ConsumptionServices(evaluator);
}
