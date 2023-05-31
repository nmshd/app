import 'dart:math' as math;

import 'package:enmeshed/screens/account_screen.dart';
import 'package:enmeshed/views/views.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/widgets.dart';

class AccountCreationScreen extends StatelessWidget {
  const AccountCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallerSide = math.min(size.height, size.width);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
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
    );
  }

  void _createNewIdentityPressed(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (_) => CreateNewIdentity(
          onAccountCreated: (account) async {
            await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);

            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => AccountScreen(initialAccount: account)),
                (_) => false,
              );
            }
          },
        ),
      );

  void _onboardingPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (_) => ScannerView(onSubmit: onSubmit)));

  void onSubmit({required String content, required VoidCallback pause, required VoidCallback resume, required BuildContext context}) async {
    pause();

    GetIt.I.get<Logger>().v('Scanned code: $content');

    if (!content.startsWith('nmshd://')) {
      resume();
      _showWrongTokenMessage(context);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              Material(child: Text(AppLocalizations.of(context)!.onboarding_processingCode)),
            ],
          ),
        ),
      ),
    );

    final truncatedReference = content.replaceAll('nmshd://qr#', '').replaceAll('nmshd://tr#', '');

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    final token = await runtime.anonymousServices.tokens.loadPeerTokenByTruncatedReference(truncatedReference);
    if (token.isError) {
      GetIt.I.get<Logger>().e(token.error.message);
      resume();
      if (context.mounted) {
        Navigator.pop(context);
        _showWrongTokenMessage(context);
      }
      return;
    }

    if (token.value.content is! TokenContentDeviceSharedSecret) {
      resume();
      if (context.mounted) {
        Navigator.pop(context);
        _showWrongTokenMessage(context);
      }
      return;
    }

    final account = await runtime.accountServices.onboardAccount((token.value.content as TokenContentDeviceSharedSecret).sharedSecret);
    await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => AccountScreen(initialAccount: account)),
        (_) => false,
      );
    }
  }

  void _showWrongTokenMessage(BuildContext context) {
    const duration = Duration(seconds: 2);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context)!.onboarding_invalidCode),
      duration: duration,
    ));
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
