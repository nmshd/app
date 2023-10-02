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

    final requestItem = CreateAttributeRequestItemDVO(
      id: '1',
      name: 'Create 1',
      mustBeAccepted: true,
      isDecidable: false,
      attribute: DraftRelationshipAttributeDVO(
          id: '',
          name: 'Art der Hochschulzulassung',
          type: 'DraftRelationshipAttributeDVO',
          content: const RelationshipAttribute(
            owner: 'id17VhbFbFMg1xQC784SEwsbEGXxGKtcB67V',
            value: ConsentAttributeValue(consent: 'My Consent Example 2'),
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
          value: const ConsentAttributeValue(consent: 'My Consent Example'),
          key: 'Schule.Hochschulzulassung.Typ',
          isTechnical: true,
          confidentiality: 'protected'),
    );

    final consentAttributeValue = LocalRequestDVO(
      id: 'a id',
      name: 'a name',
      type: 'LocalRequestDVO',
      isOwn: false,
      createdAt: '2023-09-27T11:41:36.933Z',
      content: RequestDVO(
        id: 'REQyB8AzanfTmT3afh8e',
        name: 'Request REQyB8AzanfTmT3afh8e',
        type: 'RequestDVO',
        items: [requestItem],
      ),
      status: LocalRequestStatus.Decided,
      statusText: 'a statusText',
      directionText: 'a directionText',
      sourceTypeText: 'a sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [requestItem],
    );

    return RequestRenderer(request: consentAttributeValue);
  }
}
