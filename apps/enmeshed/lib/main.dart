import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import 'screens/account_screen.dart';
import 'screens/onboarding_screen.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Permission.camera.request();

  if (Platform.isAndroid && kDebugMode) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  final logger = Logger(printer: SimplePrinter(colors: false));
  GetIt.I.registerSingleton(logger);

  final runtime = EnmeshedRuntime(logger: logger, runtimeReadyCallback: () => FlutterNativeSplash.remove());
  GetIt.I.registerSingletonAsync<EnmeshedRuntime>(() async => runtime.run());
  await GetIt.I.allReady();

  final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();
  if (accounts.isEmpty) {
    runApp(const EnmeshedApp(home: OnboardingScreen()));
    return;
  }

  accounts.sort((a, b) => b.lastAccessedAt?.compareTo(a.lastAccessedAt ?? '') ?? 0);
  runApp(EnmeshedApp(home: AccountScreen(accounts.first.id)));
}

class EnmeshedApp extends StatelessWidget {
  final Widget home;
  const EnmeshedApp({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: home,
    );
  }
}
