import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:push/push.dart';
import 'package:win32_registry/win32_registry.dart';

import 'core/core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();
    _init(GoRouter.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Hero(
              tag: 'logo',
              child: TenTapDetector(
                onTenTap: () => context.push('/debug'),
                child: Image.asset(switch (Theme.of(context).brightness) {
                  Brightness.light => 'assets/pictures/enmeshed_logo_light_cut.png',
                  Brightness.dark => 'assets/pictures/enmeshed_logo_dark_cut.png',
                }),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 50), child: LinearProgressIndicator()),
        ],
      ),
    );
  }

  Future<void> _init(GoRouter router) async {
    if (GetIt.I.isRegistered<EnmeshedRuntime>()) await GetIt.I.unregister<EnmeshedRuntime>();

    final logger = GetIt.I.get<Logger>();

    // TODO(jkoenig134): we should probably ask for permission when we need it
    final cameraStatus = await Permission.camera.request();
    if (!cameraStatus.isGranted) {
      logger.w('Camera permission is (permanently) denied');
    }

    if (Platform.isAndroid && kDebugMode) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }

    final runtime = EnmeshedRuntime(
      logger: logger,
      runtimeConfig: (
        applicationId: 'eu.enmeshed.app',
        baseUrl: const String.fromEnvironment('app_baseUrl'),
        clientId: const String.fromEnvironment('app_clientId'),
        clientSecret: const String.fromEnvironment('app_clientSecret'),
        useAppleSandbox: const bool.fromEnvironment('app_useAppleSandbox'),
        databaseFolder: './database',
        deciderModuleConfig: null,
        androidNotificationColor: null,
      ),
      getPushTokenCallback: () async =>
          Push.instance.token.timeout(const Duration(seconds: 5)).catchError((_) => 'timed out', test: (e) => e is TimeoutException),
    );

    final result = await runtime.run();
    if (result.isError) return router.go('/error');

    GetIt.I.registerSingleton(runtime, dispose: (r) => r.dispose());

    await setupPush(runtime);

    final status = await Permission.notification.request();
    if (!status.isGranted) {
      logger.w('Notification permission is (permanently) denied');
    }

    if (mounted) await runtime.registerUIBridge(AppUIBridge(logger: logger, router: router, localizations: context.l10n));

    await _registerWindowsSchemeForDebugMode('nmshd-dev');

    final appLinks = AppLinks();
    appLinks.uriLinkStream.listen((link) => _processUri(link, router));

    final accounts = await runtime.accountServices.getAccounts();
    final accountsNotInDeletion = await runtime.accountServices.getAccountsNotInDeletion();
    if (accounts.isEmpty) {
      router.go('/onboarding');
    } else if (accountsNotInDeletion.isEmpty) {
      router.go('/onboarding?skipIntroduction=true');
    } else {
      accountsNotInDeletion.sort((a, b) => b.lastAccessedAt?.compareTo(a.lastAccessedAt ?? '') ?? 0);

      final account = accountsNotInDeletion.first;

      await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);

      router.go('/account/${account.id}');
    }

    final initialAppLink = await appLinks.getInitialLink();
    await _processUri(initialAppLink, router);
  }

  Future<void> _processUri(Uri? uri, GoRouter router) async {
    if (uri == null) return;

    final uriString = uri.toString().replaceAll('nmshd-dev://', 'nmshd://').replaceAll('qr/#', 'qr#').replaceAll('enmeshed://', 'https://');
    GetIt.I.get<Logger>().i("Processing URL '$uriString'");

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    final accountsNotInDeletion = await runtime.accountServices.getAccountsNotInDeletion();
    if (accountsNotInDeletion.isEmpty) {
      router.go('/onboarding', extra: uriString);
      return;
    }

    final result = await runtime.stringProcessor.processURL(url: uriString);
    if (result.isError) {
      GetIt.I.get<Logger>().e("Processing URL '$uriString' failed with code '${result.error.code}' and message '${result.error.message}'");
      unawaited(router.push('/error-dialog', extra: result.error.code));
    }
  }
}

Future<void> _registerWindowsSchemeForDebugMode(String scheme) async {
  if (!Platform.isWindows || !kDebugMode) return;

  final appPath = Platform.resolvedExecutable;

  final protocolRegKey = 'Software\\Classes\\$scheme';
  const protocolRegValue = RegistryValue.string('URL Protocol', '');
  const protocolCmdRegKey = r'shell\open\command';
  final protocolCmdRegValue = RegistryValue.string('', '"$appPath" "%1"');

  Registry.currentUser.createKey(protocolRegKey)
    ..createValue(protocolRegValue)
    ..createKey(protocolCmdRegKey).createValue(protocolCmdRegValue);
}
