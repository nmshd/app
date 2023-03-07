import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'filesystem_adapter.dart';
import 'services/services.dart';
import 'webview_constants.dart' as webview_constants;

class EnmeshedRuntime {
  bool _isReady = false;
  bool get isReady => _isReady;

  late final HeadlessInAppWebView _headlessWebView;

  final _filesystemAdapter = FilesystemAdapter();
  FilesystemAdapter get fs => _filesystemAdapter;

  final VoidCallback runtimeReadyCallback;

  late final AccountServices _accountServices;
  AccountServices get accountServices => _accountServices;

  late final AnonymousServices _anonymousServices;
  AnonymousServices get anonymousServices => _anonymousServices;

  late final Session _currentSession;
  Session get currentSession => _currentSession;

  EnmeshedRuntime(this.runtimeReadyCallback) {
    _headlessWebView = HeadlessInAppWebView(
      initialData: webview_constants.initialData,
      onWebViewCreated: (controller) async {
        await addJavaScriptHandlers(controller);
        print('WebView created');
      },
      onConsoleMessage: (_, consoleMessage) {
        print('js runtime: ${consoleMessage.message}');
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

  Session getSession(String accountReference) => Session(Evaluator.account(this, accountReference));

  Future<void> addJavaScriptHandlers(InAppWebViewController controller) async {
    controller.addJavaScriptHandler(
      handlerName: 'publishEvent',
      callback: (args) async {
        final payload = args[0];
        print('Event published: $payload');
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'readFile',
      callback: (args) async {
        final path = args[0] as String;
        final storage = args[1] as String;

        try {
          final fileContent = await fs.readFile(path, storage);
          return {'ok': true, 'content': fileContent};
        } catch (e) {
          print('Error reading file: $e');
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
          await fs.writeFile(path, storage, data, append);
          return {'ok': true};
        } catch (e) {
          print('Error writing file: $e');
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
          await fs.deleteFile(path, storage);
          return {'ok': true};
        } catch (e) {
          print('Error deleting file: $e');
          return {'ok': false, 'content': e.toString()};
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'runtimeReady',
      callback: (_) => {_isReady = true, runtimeReadyCallback()},
    );
  }

  Future<void> loadLibs(InAppWebViewController controller) async {
    const assetsFolder = 'packages/enmeshed_runtime_bridge/assets';

    await controller.injectJavascriptFileFromAsset(assetFilePath: '$assetsFolder/loki.js');
    await controller.injectJavascriptFileFromAsset(assetFilePath: '$assetsFolder/index.js');

    final loadedLibs = await controller.evaluateJavascript(
      source: '''Object.keys(globalThis).filter(x => x.includes("NMSHD") || x.includes("TS"))''',
    );
    print(loadedLibs);
  }

  Future<void> run() async {
    await _headlessWebView.run();

    print(_isReady);
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
