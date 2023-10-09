import 'dart:math' as math;

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'home_screen.dart';
import 'scanner_view/scanner_view.dart';
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
                      OutlinedButton(
                        onPressed: () => _onboardingPressed(context),
                        child: const Text('Connect existing account', textAlign: TextAlign.center),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () => _createNewIdentityPressed(context),
                        child: const Text('Create new account', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
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
                MaterialPageRoute(builder: (BuildContext context) => HomeScreen(initialAccount: account)),
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
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Material(child: Text('Processing Code')),
            ],
          ),
        ),
      ),
    );

    final truncatedReference = content.replaceAll('nmshd://qr#', '').replaceAll('nmshd://tr#', '');

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    final tokenResult = await runtime.anonymousServices.tokens.loadPeerTokenByTruncatedReference(truncatedReference);
    if (tokenResult.isError) {
      GetIt.I.get<Logger>().e(tokenResult.error.message);
      resume();
      if (context.mounted) {
        Navigator.pop(context);
        _showWrongTokenMessage(context);
      }
      return;
    }

    final token = tokenResult.value;

    if (token.content is! TokenContentDeviceSharedSecret) {
      resume();
      if (context.mounted) {
        Navigator.pop(context);
        _showWrongTokenMessage(context);
      }
      return;
    }

    final account = await runtime.accountServices.onboardAccount((token.content as TokenContentDeviceSharedSecret).sharedSecret);
    await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen(initialAccount: account)),
        (_) => false,
      );
    }
  }

  void _showWrongTokenMessage(BuildContext context) {
    const duration = Duration(seconds: 2);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Invalid Code'),
      duration: duration,
    ));
  }
}
