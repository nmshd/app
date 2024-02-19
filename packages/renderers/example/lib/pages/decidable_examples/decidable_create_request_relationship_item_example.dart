import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

class DecidableCreateRequestRelationshipItemExample extends StatelessWidget {
  const DecidableCreateRequestRelationshipItemExample({super.key});

  @override
  Widget build(BuildContext context) {
    const identityDvo = IdentityDVO(
      id: 'id1KotS3HXFnTGKgo1s8tUaKQzmhnjkjddUo',
      name: 'Gymnasium Hugendubel',
      type: 'IdentityDVO',
      realm: 'id1',
      initials: 'GH',
      isSelf: false,
      hasRelationship: true,
    );

    DecidableCreateAttributeRequestItemDVO getCreateItem(
      AttributeValue value,
      RelationshipAttribute relationshipAttribute,
    ) {
      final renderHints = RenderHints(technicalType: RenderHintsTechnicalType.Boolean, editType: RenderHintsEditType.SelectLike);
      return DecidableCreateAttributeRequestItemDVO(
        id: '',
        name: 'i18n://dvo.requestItem.DecidableCreateAttributeRequestItem.name',
        mustBeAccepted: true,
        attribute: DraftRelationshipAttributeDVO(
          id: '',
          name: 'i18n://dvo.attribute.name.Affiliation',
          type: 'DraftIdentityAttributeDVO',
          content: relationshipAttribute,
          owner: identityDvo,
          renderHints: renderHints,
          valueHints: const ValueHints(),
          valueType: 'Affiliation',
          isOwn: true,
          isDraft: true,
          value: value,
          key: 'key',
          confidentiality: 'public',
          isTechnical: false,
        ),
      );
    }

    const consentAttributeValue = ConsentAttributeValue(consent: 'Consent Title', link: 'https://www.js-soft.com');
    const consentIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: consentAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final consentRequestItem = getCreateItem(consentAttributeValue, consentIdentityAttribute);

    const proprietaryBooleanAttributeValue = ProprietaryBooleanAttributeValue(title: 'ProprietaryBoolean Title', value: true);
    const proprietaryBooleanIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: proprietaryBooleanAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final proprietaryBoolenRequestItem = getCreateItem(proprietaryBooleanAttributeValue, proprietaryBooleanIdentityAttribute);

    const proprietaryCountryAttributeValue = ProprietaryCountryAttributeValue(title: 'ProprietaryCountry Title', value: 'Germany');
    const proprietaryCountryIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: proprietaryCountryAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final proprietaryCountryRequestItem = getCreateItem(proprietaryCountryAttributeValue, proprietaryCountryIdentityAttribute);

    const proprietaryEMailAttributeValue = ProprietaryEMailAddressAttributeValue(title: 'ProprietaryEMailAddress Title', value: 'max@mustermann.com');
    const proprietaryEMailIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: proprietaryEMailAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final proprietaryEMailRequestItem = getCreateItem(proprietaryEMailAttributeValue, proprietaryEMailIdentityAttribute);

    const proprietaryFileReferenceAttributeValue = ProprietaryFileReferenceAttributeValue(
      title: 'ProprietaryFileReference Title',
      value: 'a file reference',
    );
    const proprietaryFileReferenceIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: proprietaryFileReferenceAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final proprietaryFileReferenceRequestItem = getCreateItem(proprietaryFileReferenceAttributeValue, proprietaryFileReferenceIdentityAttribute);

    const proprietaryFloatAttributeValue = ProprietaryFloatAttributeValue(title: 'ProprietaryFloat Title', value: 4.2);
    const proprietaryFloatIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: proprietaryFloatAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final proprietaryFloatRequestItem = getCreateItem(proprietaryFloatAttributeValue, proprietaryFloatIdentityAttribute);

    const proprietaryHEXColorAttributeValue = ProprietaryHEXColorAttributeValue(title: 'ProprietaryHEXColor Title', value: '#000000');
    const proprietaryHEXColorIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: proprietaryHEXColorAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final proprietaryHEXColorRequestItem = getCreateItem(proprietaryHEXColorAttributeValue, proprietaryHEXColorIdentityAttribute);

    const proprietaryIntegerAttributeValue = ProprietaryIntegerAttributeValue(title: 'ProprietaryInteger Title', value: 42);
    const proprietaryIntegerIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: proprietaryIntegerAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final proprietaryIntegerRequestItem = getCreateItem(proprietaryIntegerAttributeValue, proprietaryIntegerIdentityAttribute);

    const proprietaryLanguageAttributeValue = ProprietaryLanguageAttributeValue(title: 'ProprietaryLanguage Title', value: 'Deutsch');
    const proprietaryLanguageIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: proprietaryLanguageAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final proprietaryLanguageRequestItem = getCreateItem(proprietaryLanguageAttributeValue, proprietaryLanguageIdentityAttribute);

    const proprietaryPhoneNumberAttributeValue = ProprietaryPhoneNumberAttributeValue(title: 'ProprietaryPhoneNumber Title', value: '+495896742342');
    const proprietaryPhoneNumberIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: proprietaryPhoneNumberAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final proprietaryPhoneNumberRequestItem = getCreateItem(proprietaryPhoneNumberAttributeValue, proprietaryPhoneNumberIdentityAttribute);

    const proprietaryStringAttributeValue = ProprietaryStringAttributeValue(title: 'ProprietaryString Title', value: 'a String');
    const proprietaryStringIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: proprietaryStringAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final proprietaryStringRequestItem = getCreateItem(proprietaryStringAttributeValue, proprietaryStringIdentityAttribute);

    const proprietaryURLAttributeValue = ProprietaryURLAttributeValue(title: 'ProprietaryURL Title', value: 'https://www.js-soft.com/');
    const proprietaryURLIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: proprietaryURLAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final proprietaryURLRequestItem = getCreateItem(proprietaryURLAttributeValue, proprietaryURLIdentityAttribute);

    const proprietaryXMLAttributeValue = ProprietaryXMLAttributeValue(title: 'ProprietaryXML Title', value: '<p>ProprietaryXML Title</p>');
    const proprietaryXMLIdentityAttribute = RelationshipAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: proprietaryXMLAttributeValue,
      key: 'key',
      confidentiality: RelationshipAttributeConfidentiality.public,
    );
    final proprietaryXMLRequestItem = getCreateItem(proprietaryXMLAttributeValue, proprietaryXMLIdentityAttribute);

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
          consentRequestItem,
          proprietaryBoolenRequestItem,
          proprietaryCountryRequestItem,
          proprietaryEMailRequestItem,
          proprietaryFileReferenceRequestItem,
          proprietaryFloatRequestItem,
          proprietaryHEXColorRequestItem,
          proprietaryIntegerRequestItem,
          proprietaryLanguageRequestItem,
          proprietaryPhoneNumberRequestItem,
          proprietaryStringRequestItem,
          proprietaryURLRequestItem,
          proprietaryXMLRequestItem,
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
        consentRequestItem,
        proprietaryBoolenRequestItem,
        proprietaryCountryRequestItem,
        proprietaryEMailRequestItem,
        proprietaryFileReferenceRequestItem,
        proprietaryFloatRequestItem,
        proprietaryHEXColorRequestItem,
        proprietaryIntegerRequestItem,
        proprietaryLanguageRequestItem,
        proprietaryPhoneNumberRequestItem,
        proprietaryStringRequestItem,
        proprietaryURLRequestItem,
        proprietaryXMLRequestItem,
      ],
    );

    return SingleChildScrollView(
      child: Padding(
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
            Expanded(child: RequestRenderer(request: localRequest, currentAddress: 'a current address')),
          ],
        ),
      ),
    );
  }
}
