import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:request_renderer/request_renderer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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

    final request = RequestDVO(
      id: '',
      name: '',
      type: 'ProposeAttributeRequestItemDVO',
      items: [registerAttributeListenerRequestItemDVO],
    );

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RequestRenderer(request: request),
        ),
      ),
    );
  }
}
