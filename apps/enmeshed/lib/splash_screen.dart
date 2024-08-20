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
import 'package:renderers/renderers.dart';

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
              child: Image.asset(switch (Theme.of(context).brightness) {
                Brightness.light => 'assets/pictures/enmeshed_logo_light_cut.png',
                Brightness.dark => 'assets/pictures/enmeshed_logo_dark_cut.png',
              }),
            ),
          ),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: LinearProgressIndicator(),
          ),
        ],
      ),
    );
  }

  Future<void> _init(GoRouter router) async {
    await GetIt.I.reset();

    // TODO(jkoenig134): we should probably ask for permission when we need it
    await Permission.camera.request();

    if (Platform.isAndroid && kDebugMode) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }

    final logger = Logger(printer: SimplePrinter(colors: false));
    GetIt.I.registerSingleton(logger);
    GetIt.I.registerSingleton<AbstractUrlLauncher>(UrlLauncher());

    final runtime = EnmeshedRuntime(
      logger: logger,
      runtimeConfig: (
        applicationId: 'eu.enmeshed.app',
        baseUrl: const String.fromEnvironment('app_baseUrl'),
        clientId: const String.fromEnvironment('app_clientId'),
        clientSecret: const String.fromEnvironment('app_clientSecret'),
        useAppleSandbox: const bool.fromEnvironment('app_useAppleSandbox'),
        databaseFolder: './database',
      ),
    );
    GetIt.I.registerSingletonAsync<EnmeshedRuntime>(() async => runtime.run());
    await GetIt.I.allReady();

    await setupPush(runtime);

    // TODO(jkoenig134): we should handle this permission using the permission_handler package (always shows that the permission is permanently denied on the ios sim)
    final isAccepted = await Push.instance.requestPermission();
    if (!isAccepted) {
      logger.w('Notification permission is (permanently) denied');
    }

    // TODO(jkoenig134): maybe this isn't the best place for this as the app couldn't be ready yet
    await runtime.triggerAppReadyEvent();

    await runtime.registerUIBridge(AppUIBridge(logger: logger, router: router));

    final appLinks = AppLinks();
    appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) GetIt.I.get<EnmeshedRuntime>().stringProcessor.processURL(url: uri.toString());
    });

    final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();
    final accountsNotInDeletion = await getAccountsNotInDeletion();
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

    final initialAppLink = await appLinks.getInitialAppLink();
    if (initialAppLink != null) {
      await GetIt.I.get<EnmeshedRuntime>().stringProcessor.processURL(url: initialAppLink.toString());
    }
  }
}
