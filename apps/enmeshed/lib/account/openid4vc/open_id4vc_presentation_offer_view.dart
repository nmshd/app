import 'dart:convert';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable because offerToAccept is set in constructor
class OpenId4VcPresentationOfferView extends StatefulWidget {
  String offerToAccept;
  final String accountId;

  OpenId4VcPresentationOfferView({required this.offerToAccept, required this.accountId, super.key});

  @override
  State<OpenId4VcPresentationOfferView> createState() => _OpenId4VcPresentationOfferViewState();
}

class _OpenId4VcPresentationOfferViewState extends State<OpenId4VcPresentationOfferView> {
  late String verifierName;
  late String verifierLogo;
  late bool canBeFulfilled;
  late Map<String, Map<String, String>> dataToBePresentedByCredential = {};
  late Map<String, Color> _claims = {};

  @override
  void initState() {
    super.initState();
    loadBackgroundColors();

    var parsedJson = const JsonDecoder().convert(widget.offerToAccept) as Map<String, dynamic>;
    verifierName = parsedJson['authorizationRequestPayload']['client_metadata']['client_name'] as String? ?? 'Unknown Client';
    verifierLogo = parsedJson['authorizationRequestPayload']['client_metadata']['logo_uri'] as String? ?? '';
    canBeFulfilled = false;
    if (parsedJson['presentationExchange'] != null) {
      canBeFulfilled = parsedJson['presentationExchange']['credentialsForRequest']['areRequirementsSatisfied'] as bool;
      var requirementsList = parsedJson['presentationExchange']['credentialsForRequest']['requirements'] as List<dynamic>;
      for (var req in requirementsList) {
        var credentialDisplayId = req['submissionEntry'][0]['inputDescriptorId'] as String;
        dataToBePresentedByCredential[credentialDisplayId] = {};
        if (req['submissionEntry'][0]['verifiableCredentials'].length == 0) {
          // no credential available for this input descriptor
          continue;
        }
        var actualCredentialId = req['submissionEntry'][0]['verifiableCredentials'][0]['credentialRecord']['id'] as String;

        var disclosedPayload = req['submissionEntry'][0]['verifiableCredentials'][0]['disclosedPayload'] as Map<String, dynamic>;
        for (var key in disclosedPayload.keys) {
          if (disclosedPayload[key] is String) {
            dataToBePresentedByCredential[credentialDisplayId]![key] = disclosedPayload[key] as String;
            continue;
          }
          if (disclosedPayload[key] is int) {
            dataToBePresentedByCredential[credentialDisplayId]![key] = (disclosedPayload[key] as int).toString();
            continue;
          }
          dataToBePresentedByCredential[credentialDisplayId]![key] = const JsonEncoder().convert([disclosedPayload[key]]);
        }
      }
    } else if (parsedJson['dcql'] != null) {
      canBeFulfilled = parsedJson['dcql']['queryResult']["canBeSatisfied"] as bool;
      //should always be null as dcql is currently not working
    }
  }

  Future<void> loadBackgroundColors() async {
    final preferences = await SharedPreferences.getInstance();
    final storedClaims = preferences.getStringList('storedClaims') ?? [];
    for (final raw in storedClaims) {
      try {
        final map = json.decode(raw);
        _claims[map['id'] as String] = Color(int.parse((map['offerBackgroundColor'] as String).replaceFirst('#', '0xff')));
      } catch (_) {
        print('Error decoding stored claim: $raw');
      }
    }
    setState(() {});
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image from URL
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          verifierLogo,
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
                              'Requesting Entity:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              verifierName,
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
              //i want a small either green or red background box - indicating if the presentation can be fullfilled
              // it should have some text like "you have all the required credentials" or "you are missing some required credentials"
              Card(
                color: canBeFulfilled ? Colors.green[100] : Colors.red[100],
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        canBeFulfilled ? Icons.check_circle : Icons.error,
                        color: canBeFulfilled ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          canBeFulfilled ? 'You have all the required credentials.' : 'You are missing some required credentials.',
                          style: TextStyle(
                            color: canBeFulfilled ? Colors.green[800] : Colors.red[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // add a card showing the data to be presented
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dataToBePresentedByCredential.length,
                itemBuilder: (context, index) {
                  final credentialId = dataToBePresentedByCredential.keys.elementAt(index);
                  final dataMap = dataToBePresentedByCredential[credentialId]!;
                  return Card(
                    color: _claims[credentialId] ?? Theme.of(context).colorScheme.primaryContainer,
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            credentialId,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...dataMap.entries.map(
                            (entry) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${entry.key}: ',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: Text(entry.value),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
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
                  if (canBeFulfilled)
                    OutlinedButton(
                      onPressed: () async {
                        final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
                        final result = await session.consumptionServices.openId4Vc.acceptFetchedCredentialPresentation(widget.offerToAccept);
                        if (context.mounted) {
                          context.pushReplacement(
                            '/account/${widget.accountId}/verifiable-credentials/accepted-presentation',
                            extra: result.value,
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
    );
  }
}
