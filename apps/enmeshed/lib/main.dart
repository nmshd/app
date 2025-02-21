import 'dart:async';
import 'dart:io';

import 'package:croppy/croppy.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:feature_flags/feature_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vector_graphics/vector_graphics.dart';

import '/themes/themes.dart';
import 'account/account.dart';
import 'core/core.dart';
import 'drawer/drawer.dart';
import 'error_screen.dart';
import 'generated/l10n/app_localizations.dart';
import 'onboarding/onboarding.dart';
import 'profiles/profiles.dart';
import 'splash_screen.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  timeago.setLocaleMessages('de', timeago.DeMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());

  runApp(const EnmeshedApp());
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final _mailboxFilterController = MailboxFilterController();
final _contactsFilterController = ContactsFilterController();

final ValueNotifier<SuggestionsBuilder?> _suggestionsBuilder = ValueNotifier(null);

final _router = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(parentNavigatorKey: _rootNavigatorKey, path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(skipIntroduction: state.uri.queryParameters['skipIntroduction'] == 'true'),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/device-onboarding',
      builder: (context, state) => DeviceOnboardingScreen(deviceSharedSecret: state.extra! as DeviceSharedSecret),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/profiles',
      builder: (context, state) => ProfilesScreen(selectedAccountReference: state.uri.queryParameters['selectedAccountReference']),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/select-profile-popup',
      pageBuilder:
          (context, state) => DialogPage(
            builder: (context) {
              final extra = state.extra! as ({List<LocalAccountDTO> possibleAccounts, String? title, String? description});

              return SelectProfileDialog(possibleAccounts: extra.possibleAccounts, title: extra.title, description: extra.description);
            },
          ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/enter-password-popup',
      pageBuilder:
          (context, state) => ModalPage(
            isScrollControlled: true,
            builder: (context) {
              final extra = state.extra! as ({UIBridgePasswordType passwordType, int? pinLength, int? attempt});
              return EnterPasswordModal(passwordType: extra.passwordType, pinLength: extra.pinLength, attempt: extra.attempt ?? 1);
            },
          ),
    ),
    GoRoute(parentNavigatorKey: _rootNavigatorKey, path: '/scan', builder: (context, state) => const ScanScreen()),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/legal-notice',
      builder: (context, state) => LegalTextScreen(filePath: 'assets/texts/legal_notice.md', title: context.l10n.legalNotice),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/data-protection',
      builder: (context, state) => LegalTextScreen(filePath: 'assets/texts/privacy.md', title: context.l10n.dataProtection),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/imprint',
      builder: (context, state) => LegalTextScreen(filePath: 'assets/texts/imprint.md', title: context.l10n.imprint),
    ),
    GoRoute(parentNavigatorKey: _rootNavigatorKey, path: '/debug', builder: (context, state) => const DebugScreen()),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/error-dialog',
      pageBuilder: (context, state) {
        final errorDetails = state.extra! as ErrorDetails;
        return DialogPage(builder: (context) => ErrorDialog(code: errorDetails.errorCode, onButtonPressed: errorDetails.onButtonPressed));
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/error',
      builder: (context, state) => ErrorScreen(backboneNotAvailable: state.uri.queryParameters['backboneNotAvailable'] == 'true'),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/account/:accountId',
      redirect: (_, state) => state.fullPath == '/account/:accountId' ? '${state.matchedLocation}/home' : null,
      routes: [
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: 'devices',
          builder: (context, state) => DevicesScreen(accountId: state.pathParameters['accountId']!),
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: ':deviceId',
              builder:
                  (context, state) => DeviceDetailScreen(accountId: state.pathParameters['accountId']!, deviceId: state.pathParameters['deviceId']!),
            ),
          ],
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: 'scan',
          builder: (context, state) => ScanScreen(accountId: state.pathParameters['accountId']),
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: 'instructions/${ScannerType.addContact}',
          builder: (context, state) {
            final accountId = state.pathParameters['accountId']!;

            return InstructionsScreen(
              accountId: accountId,
              deactivateHint: () => upsertHintsSetting(accountId: accountId, key: 'hints.${ScannerType.addContact}', value: false),
              onContinue:
                  (context) =>
                      context
                        ..pop()
                        ..push('/account/$accountId/scan'),
              title: context.l10n.instructions_addContact_title,
              subtitle: context.l10n.instructions_addContact_subtitle,
              informationTitle: context.l10n.instructions_addContact_information,
              informationDescription: context.l10n.instructions_addContact_informationDetails,
              illustration: const VectorGraphic(loader: AssetBytesLoader('assets/svg/connect_with_contact.svg'), height: 104),
              instructions: [
                context.l10n.instructions_addContact_scanQrCode,
                context.l10n.instructions_addContact_requestedData,
                context.l10n.instructions_addContact_chooseData,
                context.l10n.instructions_addContact_afterConfirmation,
              ],
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: 'instructions/${ScannerType.loadProfile}',
          builder: (context, state) {
            final accountId = state.pathParameters['accountId']!;

            return InstructionsScreen(
              accountId: accountId,
              deactivateHint: () => upsertHintsSetting(accountId: accountId, key: 'hints.${ScannerType.loadProfile}', value: false),
              onContinue:
                  (context) =>
                      context
                        ..pop()
                        ..push('/scan'),
              title: context.l10n.instructions_loadProfile_title,
              subtitle: context.l10n.instructions_loadProfile_subtitle,
              informationTitle: context.l10n.instructions_loadProfile_information,
              informationDescription: context.l10n.instructions_loadProfile_informationDetails,
              illustration: const VectorGraphic(loader: AssetBytesLoader('assets/svg/instructions_load_existing_profile.svg'), height: 104),
              instructions: [
                context.l10n.instructions_loadProfile_getDevice,
                context.l10n.instructions_loadProfile_createNewDevice,
                context.l10n.instructions_loadProfile_displayedQRCode,
                context.l10n.instructions_loadProfile_scanQRCode,
                context.l10n.instructions_loadProfile_confirmation,
              ],
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: 'create-identity-recovery-kit',
          builder: (context, state) {
            final accountId = state.pathParameters['accountId']!;

            return InstructionsScreen(
              showNumberedExplanation: false,
              accountId: accountId,
              onContinue: (context) => showCreateRecoveryKitModal(context: context, accountId: accountId),
              title: context.l10n.identityRecovery_instructions_title,
              subtitle: context.l10n.identityRecovery_instructions_subtitle,
              informationTitle: context.l10n.identityRecovery_instructions_information,
              informationDescription: context.l10n.identityRecovery_instructions_informationDescription,
              illustration: const VectorGraphic(loader: AssetBytesLoader('assets/svg/create_recovery_kit.svg'), height: 160),
              buttonContinueText: context.l10n.next,
              instructions: [
                context.l10n.identityRecovery_instructions_secure,
                context.l10n.identityRecovery_instructions_setup,
                context.l10n.identityRecovery_instructions_usage,
                context.l10n.identityRecovery_instructions_kitCreation,
              ],
            );
          },
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          parentNavigatorKey: _rootNavigatorKey,
          builder:
              (context, state, child) => AccountScreen(
                key: ValueKey(state.pathParameters['accountId']),
                suggestionsBuilder: _suggestionsBuilder,
                accountId: state.pathParameters['accountId']!,
                location: state.fullPath!,
                mailboxFilterController: _mailboxFilterController,
                contactsFilterController: _contactsFilterController,
                child: child,
              ),
          routes: [
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: 'home',
              pageBuilder:
                  (context, state) => NoTransitionPage<void>(key: state.pageKey, child: HomeView(accountId: state.pathParameters['accountId']!)),
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: 'contacts',
              pageBuilder:
                  (context, state) => NoTransitionPage<void>(
                    key: state.pageKey,
                    child: ContactsView(
                      accountId: state.pathParameters['accountId']!,
                      setSuggestionsBuilder: (s) => _suggestionsBuilder.value = s,
                      contactsFilterController: _contactsFilterController,
                    ),
                  ),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: ':contactId',
                  builder:
                      (context, state) =>
                          ContactDetailScreen(accountId: state.pathParameters['accountId']!, contactId: state.pathParameters['contactId']!),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: 'exchangedData',
                      builder:
                          (context, state) => ContactExchangedAttributesScreen(
                            accountId: state.pathParameters['accountId']!,
                            contactId: state.pathParameters['contactId']!,
                            showSharedAttributes: state.uri.queryParameters['showSharedAttributes'] == 'true',
                          ),
                    ),
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: 'shared-files',
                      builder:
                          (context, state) => ContactSharedFilesScreen(
                            accountId: state.pathParameters['accountId']!,
                            contactId: state.pathParameters['contactId']!,
                            sharedFiles: state.extra is Set<FileDVO> ? state.extra! as Set<FileDVO> : null,
                          ),
                    ),
                  ],
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'contact-request/:requestId',
                  builder:
                      (context, state) => RequestScreen(
                        accountId: state.pathParameters['accountId']!,
                        requestId: state.pathParameters['requestId']!,
                        isIncoming: true,
                        requestDVO: state.extra is LocalRequestDVO ? state.extra! as LocalRequestDVO : null,
                      ),
                ),
              ],
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: 'my-data',
              pageBuilder:
                  (context, state) => NoTransitionPage<void>(key: state.pageKey, child: MyDataView(accountId: state.pathParameters['accountId']!)),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'files',
                  builder:
                      (context, state) => FilesScreen(
                        accountId: state.pathParameters['accountId']!,
                        initialCreation: state.uri.queryParameters['initialCreation'] == 'true',
                      ),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: ':fileId',
                      builder: (context, state) {
                        final fileRecord = state.extra! as FileRecord;
                        return FileDetailScreen(
                          accountId: state.pathParameters['accountId']!,
                          fileId: state.pathParameters['fileId']!,
                          preLoadedFile: fileRecord.file,
                          fileReferenceAttribute: fileRecord.fileReferenceAttribute,
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'all-data',
                  builder: (context, state) => AllDataScreen(accountId: state.pathParameters['accountId']!),
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'details/:attributeId',
                  builder:
                      (context, state) =>
                          AttributeDetailScreen(accountId: state.pathParameters['accountId']!, attributeId: state.pathParameters['attributeId']!),
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'personal-data',
                  builder:
                      (context, state) => FilteredDataScreen(
                        accountId: state.pathParameters['accountId']!,
                        title: context.l10n.myData_personalData,
                        description: context.l10n.myData_personalData_description,
                        valueTypes: personalDataInitialAttributeTypes,
                      ),
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'address-data',
                  builder:
                      (context, state) => FilteredDataScreen(
                        accountId: state.pathParameters['accountId']!,
                        title: context.l10n.myData_addressData,
                        description: context.l10n.myData_addressData_description,
                        valueTypes: addressDataInitialAttributeTypes,
                        emphasizeAttributeHeadings: true,
                      ),
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'initial-personalData-creation',
                  builder:
                      (context, state) => MyDataInitialCreationScreen(
                        accountId: state.pathParameters['accountId']!,
                        title: context.l10n.myData_initialCreation_personalData,
                        description: context.l10n.myData_initialCreation_personalData_description,
                        valueTypes: personalDataInitialAttributeTypes,
                        onAttributesCreated: () => context.go('/account/${state.pathParameters['accountId']!}/my-data/personal-data'),
                      ),
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'initial-communicationData-creation',
                  builder:
                      (context, state) => MyDataInitialCreationScreen(
                        accountId: state.pathParameters['accountId']!,
                        title: context.l10n.myData_initialCreation_communicationData,
                        description: context.l10n.myData_initialCreation_communicationData_description,
                        valueTypes: communcationDataInitialAttributeTypes,
                        onAttributesCreated: () => context.go('/account/${state.pathParameters['accountId']!}/my-data/communication-data'),
                      ),
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'initial-addressData-creation',
                  builder: (context, state) => MyDataInitialAddressCreationScreen(accountId: state.pathParameters['accountId']!),
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'communication-data',
                  builder:
                      (context, state) => FilteredDataScreen(
                        accountId: state.pathParameters['accountId']!,
                        title: context.l10n.myData_communicationData,
                        description: context.l10n.myData_communicationData_description,
                        valueTypes: communcationDataInitialAttributeTypes,
                      ),
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'data-details/:valueType',
                  builder:
                      (context, state) =>
                          DataDetailsScreen(accountId: state.pathParameters['accountId']!, valueType: state.pathParameters['valueType']!),
                ),
              ],
            ),
            GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: 'mailbox',
              pageBuilder:
                  (context, state) => NoTransitionPage<void>(
                    key: state.pageKey,
                    child: MailboxView(
                      accountId: state.pathParameters['accountId']!,
                      mailboxFilterController: _mailboxFilterController,
                      setSuggestionsBuilder: (s) => _suggestionsBuilder.value = s,
                      filteredContactId: state.extra is String ? state.extra! as String : null,
                    ),
                  ),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'send',
                  builder:
                      (context, state) => SendMailScreen(
                        contact: state.extra != null ? state.extra! as IdentityDVO : null,
                        accountId: state.pathParameters['accountId']!,
                      ),
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: ':messageId',
                  builder:
                      (context, state) =>
                          MessageDetailScreen(messageId: state.pathParameters['messageId']!, accountId: state.pathParameters['accountId']!),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

class EnmeshedApp extends StatelessWidget {
  const EnmeshedApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
        systemNavigationBarIconBrightness: Theme.of(context).brightness.opposite,
        statusBarBrightness: Theme.of(context).brightness,
        statusBarIconBrightness: Theme.of(context).brightness.opposite,
      ),
      child: Features(
        child: MaterialApp.router(
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
          // dark mode is disabled until we have a proper dark theme
          themeMode: ThemeMode.light,
          theme: ThemeData(
            colorScheme: lightColorScheme,
            extensions: [lightCustomColors],
            navigationBarTheme: lightNavigationBarTheme,
            appBarTheme: lightAppBarTheme,
            textTheme: textTheme,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            extensions: [darkCustomColors],
            navigationBarTheme: darkNavigationBarTheme,
            appBarTheme: darkAppBarTheme,
            textTheme: textTheme,
          ),
          localizationsDelegates: [
            CroppyLocalizations.delegate,
            FlutterI18nDelegate(
              translationLoader: FileTranslationLoader(basePath: 'assets/i18n'),
              missingTranslationHandler: (key, locale) {
                GetIt.I.get<Logger>().e('Missing Key: $key, locale: $locale');
              },
            ),
            ...AppLocalizations.localizationsDelegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
