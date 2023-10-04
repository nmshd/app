import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

class ReadAttributeRequestItemExample extends StatelessWidget {
  const ReadAttributeRequestItemExample({super.key});

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

    final readIdentityAttributeRequestItemDVO = ReadAttributeRequestItemDVO(
      id: '1',
      name: 'Read 1',
      mustBeAccepted: true,
      isDecidable: true,
      query: IdentityAttributeQueryDVO(
        id: 'id',
        name: 'name',
        type: 'DraftIdentityAttributeDVO',
        valueType: 'DisplayName',
        isProcessed: false,
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        valueHints: const ValueHints(),
      ),
    );

    final readRelationshipAttributeRequestItemDVO = ReadAttributeRequestItemDVO(
      id: '1',
      name: 'Read 1',
      mustBeAccepted: true,
      isDecidable: true,
      query: RelationshipAttributeQueryDVO(
        id: 'id',
        name: 'name',
        type: 'DraftRelationshipAttributeDVO',
        valueType: 'ProprietaryLanguage',
        isProcessed: false,
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        valueHints: const ValueHints(),
        key: 'a key',
        owner: identityDvo,
        attributeCreationHints: const RelationshipAttributeCreationHints(
          title: 'creation hints title',
          valueType: 'creation hints valueType',
          confidentiality: 'public',
        ),
      ),
    );

    const readThirdPartyAttributeRequestItemDVO = ReadAttributeRequestItemDVO(
      id: '1',
      name: 'Read 1',
      mustBeAccepted: true,
      isDecidable: true,
      query: ThirdPartyRelationshipAttributeQueryDVO(
        id: 'id',
        name: 'name',
        type: 'ThirdPartyRelationshipAttribute',
        thirdParty: [identityDvo],
        isProcessed: false,
        key: 'a key',
        owner: identityDvo,
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
        items: [readIdentityAttributeRequestItemDVO, readRelationshipAttributeRequestItemDVO, readThirdPartyAttributeRequestItemDVO],
      ),
      status: LocalRequestStatus.ManualDecisionRequired,
      statusText: 'a statusText',
      directionText: 'a directionText',
      sourceTypeText: 'a sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [readIdentityAttributeRequestItemDVO, readRelationshipAttributeRequestItemDVO, readThirdPartyAttributeRequestItemDVO],
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: RequestRenderer(request: localRequest),
    );
  }
}
