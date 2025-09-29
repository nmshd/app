import 'dart:convert';

import 'package:enmeshed/account/openid4vc/fetched_credential_model.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

enum OfferState { preAuthorized, pin, requiresAuthentication }

// ignore: must_be_immutable removed because offerToAccept is modified when a PIN is added
class OpenId4VcOfferView extends StatefulWidget {
  String offerToAccept;
  final String accountId;

  OpenId4VcOfferView({required this.offerToAccept, required this.accountId, super.key});

  @override
  State<OpenId4VcOfferView> createState() => _OpenId4VcOfferViewState();
}

class _OpenId4VcOfferViewState extends State<OpenId4VcOfferView> {
  late String issuer = '';
  late String image = '';
  late String credentialName = '';
  late String credentialSubtitle = '';
  late String offerLogo = '';
  late String offerBackgroundImage = '';
  late String offerBackgroundColor = '#FFFFFF';
  late String offerTextColor = '#000000';
  bool showingPinModal = false;

  late String inputMode;
  late int txCodeLength;

  late OfferState offerState;

  @override
  void initState() {
    super.initState();
    // widget.offerToAccept is a JSON string which contains some information that we want to display
    final parsedJson = const JsonDecoder().convert(widget.offerToAccept) as Map<String, dynamic>;
    final offer = Offer.fromJson(parsedJson, raw: widget.offerToAccept);

    // issuer data
    issuer = offer.metadata.credentialIssuer.display.first.name ?? 'Unknown Issuer';
    image = offer.metadata.credentialIssuer.display.first.logo?.url ?? '';

    // credential offer display data
    final credConfig = offer.offeredCredentialConfigurations.values.first;
    final credDisplay = credConfig.display.first;

    credentialName = credDisplay.name ?? 'Unknown Credential';
    credentialSubtitle = issuer;
    offerLogo = credDisplay.logo?.url ?? (image != '' ? image : '');
    offerBackgroundColor = credDisplay.backgroundColor ?? offerBackgroundColor;
    offerTextColor = credDisplay.textColor ?? offerTextColor;
    offerBackgroundImage = credDisplay.backgroundImage?.url ?? '';

    offerState = OfferState.preAuthorized;
    ((parsedJson['credentialOfferPayload'] as Map<String, dynamic>)['grants'] as Map<String, dynamic>).forEach((
      key,
      value,
    ) {
      if (key == 'urn:ietf:params:oauth:grant-type:pre-authorized_code') {
        offerState = OfferState.preAuthorized;
        if ((value as Map<String, dynamic>)['user_pin_required'] == true) {
          offerState = OfferState.pin;
        }

        if (value['tx_code'] != null) {
          offerState = OfferState.pin;
          final txCode = value['tx_code'] as Map<String, dynamic>;
          inputMode = (txCode['input_mode'] ?? inputMode) as String;
          txCodeLength = (txCode['length'] ?? txCodeLength) as int;
        } else if (key == 'urn:ietf:params:oauth:grant-type:authorization_code') {
          offerState = OfferState.requiresAuthentication;
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(24 + 64 + 32),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 64, 8, 32),
          child: LinearProgressIndicator(
            value: 2 / 3,
            minHeight: 24,
            borderRadius: BorderRadius.circular(2),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image from URL
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 40),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Title and issuer text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Credential Issuer:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  issuer,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Container(
                      decoration: BoxDecoration(
                        image: offerBackgroundImage != ''
                            ? DecorationImage(
                                image: NetworkImage(offerBackgroundImage),
                                fit: BoxFit.cover,
                              )
                            : null,
                        color: Color(int.parse(offerBackgroundColor.replaceFirst('#', '0xff'))),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Card(
                        color: offerBackgroundImage != '' ? Colors.transparent : Color(int.parse(offerBackgroundColor.replaceFirst('#', '0xff'))),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and subtitle
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      credentialName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Color(int.parse(offerTextColor.replaceFirst('#', '0xff'))),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      credentialSubtitle,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(int.parse(offerTextColor.replaceFirst('#', '0xff'))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Logo in the top right corner
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  offerLogo,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 40),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  getInfoBox(offerState),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: _cancel,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          String? pinCode;
                          if (offerState == OfferState.pin) {
                            final router = GoRouter.of(context);
                            const extra = (
                              passwordType: UIBridgePasswordType.pin,
                              attempt: 1,
                              pinLength: 4,
                              passwordLocationIndicator: 0,
                            );
                            pinCode = await router.push('/enter-password-popup', extra: extra);
                            if (pinCode == null) {
                              // User cancelled or did not enter a PIN
                              return;
                            }
                          }

                          final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
                          final offerDataJson = (const JsonDecoder().convert(widget.offerToAccept)) as Map<String, dynamic>;
                          var credentialsToAccept = <String>[];

                          // determine which credentials to pick from the offer for all supported types of offers

                          if (offerDataJson['credentialOfferPayload']['credentials'] != null) {
                            credentialsToAccept = (offerDataJson['credentialOfferPayload']['credentials'] as List).cast<String>();
                          } else if (offerDataJson['credentialOfferPayload']['credential_configuration_ids'] != null) {
                            credentialsToAccept = (offerDataJson['credentialOfferPayload']['credential_configuration_ids'] as List).cast<String>();
                          }
                          
                          final result = await session.consumptionServices.openId4Vc.acceptFetchedCredentialOffer(
                            widget.offerToAccept,
                            pinCode,
                            credentialsToAccept,
                          );
                          final args = {
                            'offerTitle': credentialName,
                            'status': result.value.status,
                            'credentialsText': result.value.data,
                            'offerLogo': offerLogo,
                            'offerBackgroundColor': offerBackgroundColor,
                            'offerTextColor': offerTextColor,
                            'id': result.value.id,
                          };
                          if (context.mounted) {
                            context.pushReplacement(
                              '/account/${widget.accountId}/verifiable-credentials/accepted-credentials',
                              extra: args,
                            );
                          }
                        },
                        child: const Text(
                          'Accept',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getInfoBox(OfferState offerState) {
    switch (offerState) {
      case OfferState.preAuthorized:
        return AuthInfoCard.build(
          title: 'Pre-Authorized',
          description: 'This offer is pre authorized.',
          icon: Icons.verified_user,
          color: Theme.of(context).colorScheme.secondaryContainer,
          textColor: Theme.of(context).colorScheme.onSecondaryContainer,
        );
      case OfferState.pin:
        return AuthInfoCard.build(
          title: 'Pin Required',
          description: 'This offer requires a PIN to proceed.',
          icon: Icons.pin,
          color: Theme.of(context).colorScheme.secondaryContainer,
          textColor: Theme.of(context).colorScheme.onSecondaryContainer,
        );
      case OfferState.requiresAuthentication:
        return AuthInfoCard.build(
          title: 'Authentication Required',
          description: 'This offer requires authentication.',
          icon: Icons.lock,
          color: Theme.of(context).colorScheme.secondaryContainer,
          textColor: Theme.of(context).colorScheme.onSecondaryContainer,
        );
    }
  }
}

extension AuthInfoCard on Card {
  static Widget build({required String title, required String description, required IconData icon, required Color color, required Color textColor}) {
    return Card(
      color: color,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: textColor, size: 36),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
