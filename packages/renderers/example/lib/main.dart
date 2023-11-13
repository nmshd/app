import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';

import 'pages/home_screen.dart';
import 'pages/onboarding_screen.dart';
import 'url_launcher.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final logger = Logger(printer: SimplePrinter(colors: false));
  GetIt.I.registerSingleton(logger);
  GetIt.I.registerSingleton<AbstractUrlLauncher>(UrlLauncher());

  final runtime = EnmeshedRuntime(
    logger: logger,
    runtimeConfig: (
      baseUrl: const String.fromEnvironment('app_baseUrl'),
      clientId: const String.fromEnvironment('app_clientId'),
      clientSecret: const String.fromEnvironment('app_clientSecret'),
      applicationId: 'de.bildungsraum.wallet.experimental',
    ),
  );
  GetIt.I.registerSingletonAsync<EnmeshedRuntime>(() async => runtime.run());
  await GetIt.I.allReady();

  final accounts = await GetIt.I.get<EnmeshedRuntime>().accountServices.getAccounts();

  if (accounts.isEmpty) {
    FlutterNativeSplash.remove();
    runApp(const RequestRendererExample(homeWidget: OnboardingScreen()));
    return;
  }

  accounts.sort((a, b) => b.lastAccessedAt?.compareTo(a.lastAccessedAt ?? '') ?? 0);

  final account = accounts.first;
  await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);

  runApp(RequestRendererExample(homeWidget: HomeScreen(initialAccount: account)));
}

class RequestRendererExample extends StatelessWidget {
  final Widget homeWidget;

  const RequestRendererExample({super.key, required this.homeWidget});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      title: 'Request Renderer',
      localizationsDelegates: [
        FlutterI18nDelegate(translationLoader: FileTranslationLoader(basePath: 'assets/i18n')),
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
      ],
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: homeWidget,
    );
  }
}
