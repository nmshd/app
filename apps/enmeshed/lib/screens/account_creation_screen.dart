import 'dart:math' as math;

import 'package:enmeshed/screens/account_screen.dart';
import 'package:enmeshed/views/scanner_view.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountCreationScreen extends StatelessWidget {
  const AccountCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallerSide = math.min(size.height, size.width);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: smallerSide / 8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.onboarding_yourIdentity,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 10),
                        Text(AppLocalizations.of(context)!.onboarding_identityNeeded),
                        Text(AppLocalizations.of(context)!.onboarding_existingIdentity),
                        const SizedBox(height: 20),
                        Text(AppLocalizations.of(context)!.onboarding_chooseOption),
                        const SizedBox(height: 50),
                        OutlinedButton(
                          onPressed: () => _onboardingPressed(context),
                          child: Text(
                            AppLocalizations.of(context)!.onboarding_migrateIdentity,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () => _createNewIdentityPressed(context),
                          child: Text(
                            AppLocalizations.of(context)!.onboarding_createIdentity,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  left: 10,
                  right: 10,
                  child: const DataPrivacyNote(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createNewIdentityPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const CreateNewIdentity(),
    );
  }

  void _onboardingPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ScannerView(onDetected: onDetect)),
    );
  }

  void onDetect({required String content, required VoidCallback pause, required VoidCallback resume, required BuildContext context}) {
    pause();

    if (!content.startsWith('nmshd://')) {
      resume();
      return;
    }

    GetIt.I.get<Logger>().i('Scanned code: $content');
    Navigator.pop(context);
  }
}

class CreateNewIdentity extends StatefulWidget {
  const CreateNewIdentity({super.key});

  @override
  State<CreateNewIdentity> createState() => _CreateNewIdentityState();
}

class _CreateNewIdentityState extends State<CreateNewIdentity> {
  bool enabled = true;

  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: MediaQuery.of(context).viewInsets.bottom + 12),
      child: Wrap(
        children: [
          Column(
            children: [
              Text(
                AppLocalizations.of(context)!.onboarding_chooseIdentityName,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const TextField(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(130, 36.0)),
                    onPressed: enabled ? () => Navigator.pop(context) : null,
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(130, 36.0)),
                    onPressed: enabled
                        ? () async {
                            setState(() => enabled = false);

                            final name =
                                controller.text.isEmpty ? '${AppLocalizations.of(context)!.onboarding_defaultIdentityName} 1' : controller.text;
                            final account = await GetIt.I.get<EnmeshedRuntime>().accountServices.createAccount(name: name);

                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => AccountScreen(account.id)),
                                (_) => false,
                              );
                            }
                          }
                        : null,
                    child: Text(AppLocalizations.of(context)!.onboarding_confirmCreate),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DataPrivacyNote extends StatelessWidget {
  const DataPrivacyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 12),
        children: <TextSpan>[
          TextSpan(text: AppLocalizations.of(context)!.onboarding_dataPrivacy_start),
          TextSpan(
            text: AppLocalizations.of(context)!.onboarding_dataPrivacy_link,
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()..onTap = _openDataPrivacy,
          ),
          TextSpan(text: AppLocalizations.of(context)!.onboarding_dataPrivacy_end),
        ],
      ),
    );
  }

  void _openDataPrivacy() async {
    final url = Uri.parse('https://enmeshed.eu/privacy');

    if (!await canLaunchUrl(url)) {
      GetIt.I.get<Logger>().e('Could not launch $url');
      return;
    }

    try {
      await launchUrl(url);
    } catch (e) {
      GetIt.I.get<Logger>().e(e);
    }
  }
}
