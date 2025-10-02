import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iso_mdoc/iso_mdoc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CredentialType {
  jwt,
  mdoc,
  unknown,
}

class OpenIdCredentialAcceptedView extends StatefulWidget {
  final String credentialId;
  final String offerTitle;
  final String credentialsText;
  final String accountId;
  final String status;
  final String offerLogo;
  final String offerBackgroundColor;
  final String offerTextColor;

  /// Keys to be ignored when rendering the payload list
  final List<String> ignoredKeys;

  const OpenIdCredentialAcceptedView({
    required this.offerTitle,
    required this.status,
    required this.credentialsText,
    required this.accountId,
    required this.offerLogo,
    required this.offerBackgroundColor,
    required this.offerTextColor,
    required this.credentialId,
    this.ignoredKeys = const ['cnf', 'iss', 'iat', '_sd', '_sd_alg'],
    super.key,
  });

  @override
  State<OpenIdCredentialAcceptedView> createState() => _OpenIdCredentialAcceptedViewState();
}

class _OpenIdCredentialAcceptedViewState extends State<OpenIdCredentialAcceptedView> {
  late final TextEditingController _credentialsController;
  late Map<String, dynamic> payload;
  late String storedClaim;
  late CredentialType credentialType = CredentialType.unknown;

  @override
  void initState() {
    super.initState();
    _credentialsController = TextEditingController(text: widget.credentialsText);
    payload = {};
    if (widget.status == 'success') {
      final parsedJson = const JsonDecoder().convert(widget.credentialsText);
      // sometimes there is a 'compactSdJwtVc' directly in the object, sometimes there is a 'base64url' object instead
      if (parsedJson[0]['compactSdJwtVc'] == null) {
        // check if a 'base64Url' object exists indicating that a mdoc was issued
        if (parsedJson[0]['base64Url'] != null) {
          credentialType = CredentialType.mdoc;
          final hexFormatted = hex.encode(base64Url.decode(parsedJson[0]['base64Url'] as String));
          final decodedIssuerSignedObject = IssuerSignedObject.fromCbor(hexFormatted);
          for (final key in decodedIssuerSignedObject.items.keys) {
            final itemList = decodedIssuerSignedObject.items[key]!;
            for (final item in itemList) {
              if (item.dataElementValue is DateTime) {
                payload[item.dataElementIdentifier] = (item.dataElementValue as DateTime).toIso8601String();
                continue;
              }
              payload[item.dataElementIdentifier] = const JsonEncoder().convert(item.dataElementValue);
            }
          }
        }
      } else {
        credentialType = CredentialType.jwt;
        final compactSdJwtVc = parsedJson[0]['compactSdJwtVc'] as String;
        final jwt = JWT.decode(compactSdJwtVc);

        // Ensure payload is cast to Map<String, dynamic>
        if (jwt.payload is Map) {
          payload = Map<String, dynamic>.from(jwt.payload as Map);
        }
      }
      storedClaim = const JsonEncoder().convert({
        'title': widget.offerTitle,
        'issuedAt': DateTime.now().toIso8601String(),
        'credential': payload,
        'offerLogo': widget.offerLogo,
        'offerBackgroundColor': widget.offerBackgroundColor,
        'offerTextColor': widget.offerTextColor,
        'credentialType': credentialType.name,
        'id': widget.credentialId,
      });
    }
  }

  @override
  void dispose() {
    _credentialsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(24 + 64 + 32),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 64, 8, 32),
          child: LinearProgressIndicator(
            value: 1,
            minHeight: 24,
            borderRadius: BorderRadius.circular(2),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.status == 'success' ? 'Credential Accepted' : 'Credential Acceptance Failed',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              if (widget.status == 'success')
                Card(
                  color: Color(int.parse(widget.offerBackgroundColor.replaceFirst('#', '0xff'))),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and list of payload values
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.offerTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Color(int.parse(widget.offerTextColor.replaceFirst('#', '0xff'))),
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Replace subtitle with key-value list from JWT
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: payload.entries
                                    .where((entry) => !widget.ignoredKeys.contains(entry.key))
                                    .map(
                                      (entry) => Text(
                                        '${entry.key}: ${entry.value.toString().length > 50 ? '${entry.value.toString().substring(0, 50)}…' : entry.value.toString()}\n',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(int.parse(widget.offerTextColor.replaceFirst('#', '0xff'))),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        // Logo in the top right corner
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.offerLogo,
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
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      final preferences = await SharedPreferences.getInstance();
                      final storedClaims = (preferences.getStringList('storedClaims') ?? [])..add(storedClaim);
                      await preferences.setStringList('storedClaims', storedClaims);
                      if (context.mounted) {
                        context
                          ..pop()
                          ..pushReplacement('/account/${widget.accountId}/verifiable-credentials');
                      }
                    },
                    child: const Text(
                      'Back to Credentials',
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
