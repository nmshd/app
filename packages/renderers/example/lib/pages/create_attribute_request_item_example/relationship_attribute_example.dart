import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

class RelationshipAttributeExample extends StatelessWidget {
  const RelationshipAttributeExample({super.key});

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

    const consentAttributeValue = ConsentAttributeValue(consent: 'My Consent Example 2');
    const proprietaryBooleanAttributeValue = ProprietaryBooleanAttributeValue(title: 'ProprietaryBoolean Title', value: true);
    const proprietaryFloatAttributeValue = ProprietaryFloatAttributeValue(title: 'ProprietaryFloat Title', value: 4.2);
    const proprietaryIntegerAttributeValue = ProprietaryIntegerAttributeValue(title: 'ProprietaryInteger Title', value: 4);
    const proprietaryJSONAttributeValue = ProprietaryJSONAttributeValue(title: 'ProprietaryJSON Title', value: {'jsonKey': 'jsonValue'});
    const proprietaryXMLAttributeValue = ProprietaryXMLAttributeValue(title: 'ProprietaryXML Title', value: '<XML Example>');

    const countryAttributeValue = ProprietaryCountryAttributeValue(
      title: 'ProprietaryCountry Title',
      value: 'DE',
    );
    const emailAttributeValue = ProprietaryEMailAddressAttributeValue(
      title: 'ProprietaryEMailAddress Title',
      value: 'email@example.com',
    );
    const fileAttributeValue = ProprietaryFileReferenceAttributeValue(
      title: 'ProprietaryFileReference Title',
      value: 'File',
      description: 'File description',
    );
    const hexColorAttributeValue = ProprietaryHEXColorAttributeValue(
      title: 'ProprietaryHEXColor Title',
      value: '#0000FF',
    );
    const languageAttributeValue = ProprietaryLanguageAttributeValue(
      title: 'ProprietaryLanguage Title',
      value: 'de',
    );
    const phoneNumberAttributeValue = ProprietaryPhoneNumberAttributeValue(
      title: 'ProprietaryPhoneNumber Title',
      value: '1234',
    );
    const stringAttributeValue = ProprietaryStringAttributeValue(
      title: 'ProprietaryString Title',
      value: 'String',
    );
    const urlAttributeValue = ProprietaryURLAttributeValue(
      title: 'ProprietaryURL Title',
      value: 'http://example.com',
    );

    createRequestItem({required RelationshipAttributeValue value}) => CreateAttributeRequestItemDVO(
          id: '1',
          name: 'Create 1',
          mustBeAccepted: true,
          isDecidable: false,
          attribute: DraftRelationshipAttributeDVO(
              id: '',
              name: 'Art der Hochschulzulassung',
              type: 'DraftRelationshipAttributeDVO',
              content: RelationshipAttribute(
                owner: 'id17VhbFbFMg1xQC784SEwsbEGXxGKtcB67V',
                value: value,
                key: 'Schule.Hochschulzulassung.Typ',
                confidentiality: RelationshipAttributeConfidentiality.protected,
              ),
              owner: identityDvo,
              renderHints: RenderHints(
                technicalType: RenderHintsTechnicalType.String,
                editType: RenderHintsEditType.InputLike,
              ),
              valueHints: const ValueHints(),
              valueType: 'Consent',
              isOwn: true,
              isDraft: true,
              value: value,
              key: 'Schule.Hochschulzulassung.Typ',
              isTechnical: true,
              confidentiality: 'protected'),
        );

    final localRequest = LocalRequestDVO(
      id: 'a id',
      name: 'a name',
      type: 'LocalRequestDVO',
      isOwn: false,
      createdAt: '2023-09-27T11:41:36.933Z',
      content: RequestDVO(
        id: 'REQyB8AzanfTmT3afh8e',
        name: 'Request REQyB8AzanfTmT3afh8e',
        type: 'RequestDVO',
        items: [
          createRequestItem(value: consentAttributeValue),
          createRequestItem(value: proprietaryBooleanAttributeValue),
          createRequestItem(value: proprietaryFloatAttributeValue),
          createRequestItem(value: proprietaryIntegerAttributeValue),
          createRequestItem(value: proprietaryJSONAttributeValue),
          createRequestItem(value: proprietaryXMLAttributeValue),
          createRequestItem(value: countryAttributeValue),
          createRequestItem(value: emailAttributeValue),
          createRequestItem(value: fileAttributeValue),
          createRequestItem(value: hexColorAttributeValue),
          createRequestItem(value: languageAttributeValue),
          createRequestItem(value: phoneNumberAttributeValue),
          createRequestItem(value: stringAttributeValue),
          createRequestItem(value: urlAttributeValue),
        ],
      ),
      status: LocalRequestStatus.Decided,
      statusText: 'a statusText',
      directionText: 'a directionText',
      sourceTypeText: 'a sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [
        createRequestItem(value: consentAttributeValue),
        createRequestItem(value: proprietaryBooleanAttributeValue),
        createRequestItem(value: proprietaryFloatAttributeValue),
        createRequestItem(value: proprietaryIntegerAttributeValue),
        createRequestItem(value: proprietaryJSONAttributeValue),
        createRequestItem(value: proprietaryXMLAttributeValue),
        createRequestItem(value: countryAttributeValue),
        createRequestItem(value: emailAttributeValue),
        createRequestItem(value: fileAttributeValue),
        createRequestItem(value: hexColorAttributeValue),
        createRequestItem(value: languageAttributeValue),
        createRequestItem(value: phoneNumberAttributeValue),
        createRequestItem(value: stringAttributeValue),
        createRequestItem(value: urlAttributeValue),
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: RequestRenderer(request: localRequest),
    );
  }
}
