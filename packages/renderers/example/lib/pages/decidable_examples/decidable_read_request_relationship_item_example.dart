import 'dart:convert';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

class DecidableReadRequestRelationshipItemExample extends StatefulWidget {
  final bool isWithResults;

  const DecidableReadRequestRelationshipItemExample({super.key, required this.isWithResults});

  @override
  State<DecidableReadRequestRelationshipItemExample> createState() => _DecidableReadRequestRelationshipItemExampleState();
}

class _DecidableReadRequestRelationshipItemExampleState extends State<DecidableReadRequestRelationshipItemExample> {
  Map<String, dynamic>? consentJsonExample;
  Map<String, dynamic>? proprietaryBooleanJsonExample;
  Map<String, dynamic>? proprietaryCountryJsonExample;
  Map<String, dynamic>? proprietaryEMailJsonExample;
  Map<String, dynamic>? proprietaryFileReferenceJsonExample;
  Map<String, dynamic>? proprietaryFloatJsonExample;
  Map<String, dynamic>? proprietaryHEXColorJsonExample;
  Map<String, dynamic>? proprietaryIntegerJsonExample;
  Map<String, dynamic>? proprietaryLanguageJsonExample;
  Map<String, dynamic>? proprietaryPhoneNumberJsonExample;
  Map<String, dynamic>? proprietaryStringJsonExample;
  Map<String, dynamic>? proprietaryURLJsonExample;
  Map<String, dynamic>? proprietaryXMLJsonExample;

  @override
  void initState() {
    loadJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (consentJsonExample == null ||
        proprietaryBooleanJsonExample == null ||
        proprietaryCountryJsonExample == null ||
        proprietaryEMailJsonExample == null ||
        proprietaryFileReferenceJsonExample == null ||
        proprietaryFloatJsonExample == null ||
        proprietaryHEXColorJsonExample == null ||
        proprietaryIntegerJsonExample == null ||
        proprietaryLanguageJsonExample == null ||
        proprietaryPhoneNumberJsonExample == null ||
        proprietaryStringJsonExample == null ||
        proprietaryURLJsonExample == null ||
        proprietaryXMLJsonExample == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final localRequestConsent = LocalRequestDVO.fromJson(consentJsonExample!);
    final localRequestProprietaryBoolean = LocalRequestDVO.fromJson(proprietaryBooleanJsonExample!);
    final localRequestProprietaryCountry = LocalRequestDVO.fromJson(proprietaryCountryJsonExample!);
    final localRequestProprietaryEMail = LocalRequestDVO.fromJson(proprietaryEMailJsonExample!);
    final localRequestProprietaryFileReference = LocalRequestDVO.fromJson(proprietaryFileReferenceJsonExample!);
    final localRequestProprietaryFloat = LocalRequestDVO.fromJson(proprietaryFloatJsonExample!);
    final localRequestProprietaryHEXColor = LocalRequestDVO.fromJson(proprietaryHEXColorJsonExample!);
    final localRequestProprietaryInteger = LocalRequestDVO.fromJson(proprietaryIntegerJsonExample!);
    final localRequestProprietaryLanguage = LocalRequestDVO.fromJson(proprietaryLanguageJsonExample!);
    final localRequestProprietaryPhoneNumber = LocalRequestDVO.fromJson(proprietaryPhoneNumberJsonExample!);
    final localRequestProprietaryString = LocalRequestDVO.fromJson(proprietaryStringJsonExample!);
    final localRequestProprietaryURL = LocalRequestDVO.fromJson(proprietaryURLJsonExample!);
    final localRequestProprietaryXML = LocalRequestDVO.fromJson(proprietaryXMLJsonExample!);

    const identityDvo = IdentityDVO(
      id: 'id1KotS3HXFnTGKgo1s8tUaKQzmhnjkjddUo',
      name: 'Gymnasium Hugendubel',
      type: 'IdentityDVO',
      realm: 'id1',
      initials: 'GH',
      isSelf: false,
      hasRelationship: true,
    );

    final localRequest = LocalRequestDVO(
      id: 'REQuHfz2PcAAVHlMzzkf',
      name: 'i18n://dvo.localRequest.Message.incoming.ManualDecisionRequired.name',
      description: 'i18n://dvo.localRequest.Message.incoming.ManualDecisionRequired.description',
      type: 'LocalRequestDVO',
      date: '2023-10-13T12:24:27.187Z',
      isOwn: false,
      createdAt: '2023-10-13T12:24:27.187Z',
      content: RequestDVO(
        id: 'REQuHfz2PcAAVHlMzzkf',
        name: 'Request REQuHfz2PcAAVHlMzzkf',
        type: 'RequestDVO',
        items: [
          localRequestConsent.content.items.first,
          localRequestProprietaryBoolean.content.items.first,
          localRequestProprietaryCountry.content.items.first,
          localRequestProprietaryEMail.content.items.first,
          localRequestProprietaryFileReference.items.first,
          localRequestProprietaryFloat.content.items.first,
          localRequestProprietaryHEXColor.content.items.first,
          localRequestProprietaryInteger.content.items.first,
          localRequestProprietaryLanguage.content.items.first,
          localRequestProprietaryPhoneNumber.content.items.first,
          localRequestProprietaryString.content.items.first,
          localRequestProprietaryURL.content.items.first,
          localRequestProprietaryXML.content.items.first,
        ],
      ),
      status: LocalRequestStatus.ManualDecisionRequired,
      statusText: 'i18n://dvo.localRequest.status.ManualDecisionRequired',
      directionText: 'i18n://dvo.localRequest.direction.incoming',
      sourceTypeText: 'i18n://dvo.localRequest.sourceType.Message',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: true,
      items: [
        localRequestConsent.content.items.first,
        localRequestProprietaryBoolean.content.items.first,
        localRequestProprietaryCountry.content.items.first,
        localRequestProprietaryEMail.content.items.first,
        localRequestProprietaryFileReference.items.first,
        localRequestProprietaryFloat.content.items.first,
        localRequestProprietaryHEXColor.content.items.first,
        localRequestProprietaryInteger.content.items.first,
        localRequestProprietaryLanguage.content.items.first,
        localRequestProprietaryPhoneNumber.content.items.first,
        localRequestProprietaryString.content.items.first,
        localRequestProprietaryURL.content.items.first,
        localRequestProprietaryXML.content.items.first,
      ],
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Title:', style: TextStyle(fontWeight: FontWeight.bold)),
                TranslatedText(localRequest.name),
                const SizedBox(height: 8),
                if (localRequest.description != null) ...[
                  const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
                  TranslatedText(localRequest.description!),
                  const SizedBox(height: 8),
                ],
                const Text('Request ID:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(localRequest.id),
                const SizedBox(height: 8),
                const Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
                TranslatedText(localRequest.statusText),
                const SizedBox(height: 8),
                const Text('Created by:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(localRequest.createdBy.name),
                const SizedBox(height: 8),
                const Text('Created at:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(DateFormat('yMd', Localizations.localeOf(context).languageCode).format(DateTime.parse(localRequest.createdAt))),
                const Divider(),
                RequestRenderer(request: localRequest, currentAddress: 'a current address'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadJsonData() async {
    final jsonDataConsent = await rootBundle.loadString('assets/DecidableReadRequestRelationshipConsentItem.json');
    final jsonDataProprietaryBoolean = await rootBundle.loadString('assets/DecidableReadRequestRelationshipProprietaryBooleanItem.json');
    final jsonDataProprietaryCountry = await rootBundle.loadString('assets/DecidableReadRequestRelationshipProprietaryCountryItem.json');
    final jsonDataProprietaryEMail = await rootBundle.loadString('assets/DecidableReadRequestRelationshipProprietaryEMailItem.json');
    final jsonDataProprietaryFileReference = await rootBundle.loadString('assets/DecidableReadRequestRelationshipProprietaryFileReferenceItem.json');
    final jsonDataProprietaryFloat = await rootBundle.loadString('assets/DecidableReadRequestRelationshipProprietaryFloatItem.json');
    final jsonDataProprietaryHEXColor = await rootBundle.loadString('assets/DecidableReadRequestRelationshipProprietaryHEXColorItem.json');
    final jsonDataProprietaryInteger = await rootBundle.loadString('assets/DecidableReadRequestRelationshipProprietaryIntegerItem.json');
    final jsonDataProprietaryLanguage = await rootBundle.loadString('assets/DecidableReadRequestRelationshipProprietaryLanguageItem.json');
    final jsonDataProprietaryPhoneNumber = await rootBundle.loadString('assets/DecidableReadRequestRelationshipProprietaryPhoneNumberItem.json');
    final jsonDataProprietaryString = await rootBundle.loadString('assets/DecidableReadRequestRelationshipProprietaryStringItem.json');
    final jsonDataProprietaryURL = await rootBundle.loadString('assets/DecidableReadRequestRelationshipProprietaryURLItem.json');
    final jsonDataProprietaryXML = await rootBundle.loadString('assets/DecidableReadRequestRelationshipProprietaryXMLItem.json');

    setState(() {
      consentJsonExample = jsonDecode(jsonDataConsent);
      proprietaryBooleanJsonExample = jsonDecode(jsonDataProprietaryBoolean);
      proprietaryCountryJsonExample = jsonDecode(jsonDataProprietaryCountry);
      proprietaryEMailJsonExample = jsonDecode(jsonDataProprietaryEMail);
      proprietaryFileReferenceJsonExample = jsonDecode(jsonDataProprietaryFileReference);
      proprietaryFloatJsonExample = jsonDecode(jsonDataProprietaryFloat);
      proprietaryHEXColorJsonExample = jsonDecode(jsonDataProprietaryHEXColor);
      proprietaryIntegerJsonExample = jsonDecode(jsonDataProprietaryInteger);
      proprietaryLanguageJsonExample = jsonDecode(jsonDataProprietaryLanguage);
      proprietaryPhoneNumberJsonExample = jsonDecode(jsonDataProprietaryPhoneNumber);
      proprietaryStringJsonExample = jsonDecode(jsonDataProprietaryString);
      proprietaryURLJsonExample = jsonDecode(jsonDataProprietaryURL);
      proprietaryXMLJsonExample = jsonDecode(jsonDataProprietaryXML);
    });
  }
}
