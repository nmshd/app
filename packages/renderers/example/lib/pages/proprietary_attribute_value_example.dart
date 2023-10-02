import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

class ProprietaryAttributeValueExample extends StatelessWidget {
  const ProprietaryAttributeValueExample({super.key});

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

    const countryAttributeValue = ProprietaryCountryAttributeValue(
      title: 'Germany',
      value: 'DE',
    );
    const emailAttributeValue = ProprietaryEMailAddressAttributeValue(
      title: 'email@example.com',
      value: 'email@example.com',
    );
    const fileAttributeValue = ProprietaryFileReferenceAttributeValue(
      title: 'FileName',
      value: 'File',
      description: 'File description',
    );
    const hexColorAttributeValue = ProprietaryHEXColorAttributeValue(
      title: 'Blue',
      value: '#0000FF',
    );
    const languageAttributeValue = ProprietaryLanguageAttributeValue(
      title: 'German',
      value: 'de',
    );
    const phoneNumberAttributeValue = ProprietaryPhoneNumberAttributeValue(
      title: '1234',
      value: '1234',
    );
    const stringAttributeValue = ProprietaryStringAttributeValue(
      title: 'String',
      value: 'String',
    );
    const urlAttributeValue = ProprietaryURLAttributeValue(
      title: 'http://example.com',
      value: 'http://example.com',
    );

    createRequestItem({required ProprietaryAttributeValue value}) => CreateAttributeRequestItemDVO(
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

    createRequest({required ProprietaryAttributeValue value}) => LocalRequestDVO(
          id: 'a id',
          name: 'a name',
          type: 'LocalRequestDVO',
          isOwn: false,
          createdAt: '2023-09-27T11:41:36.933Z',
          content: RequestDVO(
            id: 'REQyB8AzanfTmT3afh8e',
            name: 'Request REQyB8AzanfTmT3afh8e',
            type: 'RequestDVO',
            items: [createRequestItem(value: value)],
          ),
          status: LocalRequestStatus.Decided,
          statusText: 'a statusText',
          directionText: 'a directionText',
          sourceTypeText: 'a sourceTypeText',
          createdBy: identityDvo,
          peer: identityDvo,
          decider: identityDvo,
          isDecidable: false,
          items: [createRequestItem(value: value)],
        );

    return SingleChildScrollView(
      child: Column(
        children: [
          RequestRenderer(request: createRequest(value: countryAttributeValue)),
          RequestRenderer(request: createRequest(value: emailAttributeValue)),
          RequestRenderer(request: createRequest(value: fileAttributeValue)),
          RequestRenderer(request: createRequest(value: hexColorAttributeValue)),
          RequestRenderer(request: createRequest(value: languageAttributeValue)),
          RequestRenderer(request: createRequest(value: phoneNumberAttributeValue)),
          RequestRenderer(request: createRequest(value: stringAttributeValue)),
          RequestRenderer(request: createRequest(value: urlAttributeValue)),
        ],
      ),
    );
  }
}
