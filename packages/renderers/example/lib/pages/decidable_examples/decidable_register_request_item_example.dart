import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

class DecidableRegisterRequestItemExample extends StatelessWidget {
  const DecidableRegisterRequestItemExample({super.key});

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

    final decidableRegisterRequestItem = DecidableRegisterAttributeListenerRequestItemDVO(
      id: '1',
      name: 'Read 1',
      mustBeAccepted: true,
      query: IdentityAttributeQueryDVO(
        id: 'an id',
        name: 'a Name',
        isProcessed: false,
        type: 'IdentityAttributeQueryDVO',
        tags: [],
        valueType: 'DisplayName',
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        valueHints: const ValueHints(),
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
        items: [decidableRegisterRequestItem],
      ),
      status: LocalRequestStatus.ManualDecisionRequired,
      statusText: 'a statusText',
      directionText: 'a directionText',
      sourceTypeText: 'a sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [decidableRegisterRequestItem],
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: RequestRenderer(request: localRequest),
    );
  }
}
