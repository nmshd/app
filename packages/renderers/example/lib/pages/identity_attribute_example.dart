import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

class IdentityAttributeExample extends StatelessWidget {
  const IdentityAttributeExample({super.key});

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

    const affiliationOrganizationAttributeValue = AffiliationOrganizationAttributeValue(value: 'an affiliation organization');

    createIdentityItem({required IdentityAttributeValue value}) => CreateAttributeRequestItemDVO(
          id: '1',
          name: 'Create 1',
          mustBeAccepted: true,
          isDecidable: false,
          attribute: DraftIdentityAttributeDVO(
            id: '',
            name: 'Art der Hochschulzulassung',
            type: 'DraftIdentityAttributeDVO',
            content: IdentityAttribute(owner: 'id17VhbFbFMg1xQC784SEwsbEGXxGKtcB67V', value: value),
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
            tags: [],
          ),
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
          createIdentityItem(value: affiliationOrganizationAttributeValue),
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
        createIdentityItem(value: affiliationOrganizationAttributeValue),
      ],
    );

    return RequestRenderer(request: localRequest);
  }
}
