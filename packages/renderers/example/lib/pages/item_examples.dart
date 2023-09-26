import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

class ItemExamples extends StatelessWidget {
  const ItemExamples({super.key});

  @override
  Widget build(BuildContext context) {
    const identityDvo =
        IdentityDVO(id: 'id', name: 'name', type: 'type', realm: 'realm', initials: 'initials', isSelf: false, hasRelationship: false);

    final readAttributeRequestItemDVO = ReadAttributeRequestItemDVO(
      id: 'id',
      name: 'name',
      mustBeAccepted: false,
      isDecidable: false,
      query: IdentityAttributeQueryDVO(
        id: 'id',
        name: 'name',
        type: 'ProposeAttributeRequestItemDVO',
        valueType: 'valueType',
        isProcessed: false,
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        valueHints: const ValueHints(),
      ),
    );

    final proposeAttributeRequestItemDVO = ProposeAttributeRequestItemDVO(
      id: 'id',
      name: 'name',
      mustBeAccepted: false,
      isDecidable: false,
      query: IdentityAttributeQueryDVO(
        id: 'id',
        name: 'name',
        type: 'ProposeAttributeRequestItemDVO',
        valueType: 'valueType',
        isProcessed: false,
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: 'id',
        name: 'name',
        type: 'type',
        content: const IdentityAttribute(
          owner: 'owner',
          value: GivenNameAttributeValue(value: 'value'),
        ),
        owner: const IdentityDVO(
          id: 'id',
          name: 'name',
          type: 'type',
          realm: 'realm',
          initials: 'initials',
          isSelf: false,
          hasRelationship: false,
        ),
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        valueHints: const ValueHints(),
        valueType: 'valueType',
        isOwn: false,
        isDraft: false,
        value: const GivenNameAttributeValue(value: 'value'),
        tags: ['tags'],
      ),
    );

    const authenticationRequestItemDVO = AuthenticationRequestItemDVO(
      id: 'id',
      name: 'name',
      mustBeAccepted: false,
      isDecidable: false,
    );

    final createAttributeRequestItemDVO = CreateAttributeRequestItemDVO(
      id: 'id',
      name: 'name',
      mustBeAccepted: false,
      isDecidable: false,
      attribute: DraftIdentityAttributeDVO(
        id: 'id',
        name: 'name',
        type: 'type',
        content: const IdentityAttribute(
          owner: 'owner',
          value: GivenNameAttributeValue(value: 'value'),
        ),
        owner: const IdentityDVO(
          id: 'id',
          name: 'name',
          type: 'type',
          realm: 'realm',
          initials: 'initials',
          isSelf: false,
          hasRelationship: false,
        ),
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        valueHints: const ValueHints(),
        valueType: 'valueType',
        isOwn: false,
        isDraft: false,
        value: const GivenNameAttributeValue(value: 'value'),
        tags: ['tags'],
      ),
    );

    final shareAttributeRequestItemDVO = ShareAttributeRequestItemDVO(
      id: 'id',
      name: 'name',
      mustBeAccepted: false,
      isDecidable: false,
      attribute: DraftIdentityAttributeDVO(
        id: 'id',
        name: 'name',
        type: 'type',
        content: const IdentityAttribute(
          owner: 'owner',
          value: GivenNameAttributeValue(value: 'value'),
        ),
        owner: const IdentityDVO(
          id: 'id',
          name: 'name',
          type: 'type',
          realm: 'realm',
          initials: 'initials',
          isSelf: false,
          hasRelationship: false,
        ),
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        valueHints: const ValueHints(),
        valueType: 'valueType',
        isOwn: false,
        isDraft: false,
        value: const GivenNameAttributeValue(value: 'value'),
        tags: ['tags'],
      ),
      sourceAttributeId: 'sourceAttributeId',
    );

    const consentRequestItemDVO = ConsentRequestItemDVO(
      id: 'id',
      name: 'name',
      mustBeAccepted: false,
      isDecidable: false,
      consent: 'consent',
    );

    final registerAttributeListenerRequestItemDVO = RegisterAttributeListenerRequestItemDVO(
      id: 'id',
      name: 'name',
      mustBeAccepted: false,
      isDecidable: false,
      query: IdentityAttributeQueryDVO(
        id: 'id',
        name: 'name',
        type: 'ProposeAttributeRequestItemDVO',
        valueType: 'valueType',
        isProcessed: false,
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        valueHints: const ValueHints(),
      ),
    );

    final readAttributeRequestItem = LocalRequestDVO(
      id: 'id',
      name: 'name',
      type: 'ProposeAttributeRequestItemDVO',
      isOwn: false,
      createdAt: 'createdAt',
      content: RequestDVO(
        id: '',
        name: '',
        type: 'ProposeAttributeRequestItemDVO',
        items: [readAttributeRequestItemDVO],
      ),
      status: LocalRequestStatus.Completed,
      statusText: 'statusText',
      directionText: 'directionText',
      sourceTypeText: 'sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [readAttributeRequestItemDVO],
    );

    final proposeAttributeRequestItem = LocalRequestDVO(
      id: 'id',
      name: 'name',
      type: 'ProposeAttributeRequestItemDVO',
      isOwn: false,
      createdAt: 'createdAt',
      content: RequestDVO(
        id: '',
        name: '',
        type: 'ProposeAttributeRequestItemDVO',
        items: [proposeAttributeRequestItemDVO],
      ),
      status: LocalRequestStatus.Completed,
      statusText: 'statusText',
      directionText: 'directionText',
      sourceTypeText: 'sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [proposeAttributeRequestItemDVO],
    );

    final createAttributeRequestItem = LocalRequestDVO(
      id: 'id',
      name: 'name',
      type: 'ProposeAttributeRequestItemDVO',
      isOwn: false,
      createdAt: 'createdAt',
      content: RequestDVO(
        id: '',
        name: '',
        type: 'ProposeAttributeRequestItemDVO',
        items: [createAttributeRequestItemDVO],
      ),
      status: LocalRequestStatus.Completed,
      statusText: 'statusText',
      directionText: 'directionText',
      sourceTypeText: 'sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [createAttributeRequestItemDVO],
    );

    final shareAttributeRequestItem = LocalRequestDVO(
      id: 'id',
      name: 'name',
      type: 'ProposeAttributeRequestItemDVO',
      isOwn: false,
      createdAt: 'createdAt',
      content: RequestDVO(
        id: '',
        name: '',
        type: 'ProposeAttributeRequestItemDVO',
        items: [shareAttributeRequestItemDVO],
      ),
      status: LocalRequestStatus.Completed,
      statusText: 'statusText',
      directionText: 'directionText',
      sourceTypeText: 'sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [shareAttributeRequestItemDVO],
    );

    const authenticationRequestItem = LocalRequestDVO(
      id: 'id',
      name: 'name',
      type: 'ProposeAttributeRequestItemDVO',
      isOwn: false,
      createdAt: 'createdAt',
      content: RequestDVO(
        id: '',
        name: '',
        type: 'ProposeAttributeRequestItemDVO',
        items: [authenticationRequestItemDVO],
      ),
      status: LocalRequestStatus.Completed,
      statusText: 'statusText',
      directionText: 'directionText',
      sourceTypeText: 'sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [authenticationRequestItemDVO],
    );

    const consentRequestItem = LocalRequestDVO(
      id: 'id',
      name: 'name',
      type: 'ProposeAttributeRequestItemDVO',
      isOwn: false,
      createdAt: 'createdAt',
      content: RequestDVO(
        id: '',
        name: '',
        type: 'ProposeAttributeRequestItemDVO',
        items: [consentRequestItemDVO],
      ),
      status: LocalRequestStatus.Completed,
      statusText: 'statusText',
      directionText: 'directionText',
      sourceTypeText: 'sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [consentRequestItemDVO],
    );

    final registerAttributeListenerRequestItem = LocalRequestDVO(
      id: 'id',
      name: 'name',
      type: 'ProposeAttributeRequestItemDVO',
      isOwn: false,
      createdAt: 'createdAt',
      content: RequestDVO(
        id: '',
        name: '',
        type: 'ProposeAttributeRequestItemDVO',
        items: [registerAttributeListenerRequestItemDVO],
      ),
      status: LocalRequestStatus.Completed,
      statusText: 'statusText',
      directionText: 'directionText',
      sourceTypeText: 'sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [registerAttributeListenerRequestItemDVO],
    );

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                RequestRenderer(request: readAttributeRequestItem),
                RequestRenderer(request: proposeAttributeRequestItem),
                RequestRenderer(request: createAttributeRequestItem),
                RequestRenderer(request: shareAttributeRequestItem),
                const RequestRenderer(request: authenticationRequestItem),
                const RequestRenderer(request: consentRequestItem),
                RequestRenderer(request: registerAttributeListenerRequestItem),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
