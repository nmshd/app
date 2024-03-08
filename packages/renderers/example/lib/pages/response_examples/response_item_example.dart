import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

class ResponseItemExample extends StatelessWidget {
  const ResponseItemExample({super.key});

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

    final identityAttributeQuery = IdentityAttributeQueryDVO(
      id: 'an id',
      name: 'Identity Attribute',
      isProcessed: false,
      type: 'IdentityAttributeQueryDVO',
      tags: [],
      valueType: 'DisplayName',
      renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      valueHints: const ValueHints(),
    );

    final responseAttribute = OwnRelationshipAttributeDVO(
      id: 'localAttributeId',
      name: 'Local Attribute',
      content: const IdentityAttribute(
        owner: 'owner',
        value: GivenNameAttributeValue(value: 'value'),
      ),
      value: const DisplayNameAttributeValue(value: 'Display Name'),
      valueType: 'DisplayNameAttributeValue',
      owner: 'Ower',
      isDraft: false,
      isValid: true,
      createdAt: '2023-09-27T11:41:36.933Z',
      peer: 'Peer',
      requestReference: 'reference',
      confidentiality: 'protected',
      isTechnical: false,
      key: 'Key',
      renderHints: RenderHints(
        technicalType: RenderHintsTechnicalType.String,
        editType: RenderHintsEditType.InputLike,
      ),
      valueHints: const ValueHints(),
    );

    final readAttributeAcceptResponseItem = ReadAttributeAcceptResponseItemDVO(
      id: 'responseId',
      name: 'Response',
      type: 'ReadAttributeAcceptResponseItemDVO',
      attributeId: 'readAttributeId',
      attribute: responseAttribute,
    );

    final createAttributeAcceptResponseItem = CreateAttributeAcceptResponseItemDVO(
      id: 'responseId',
      name: 'Response',
      type: 'CreateAttributeAcceptResponseItemDVO',
      attributeId: 'createAttributeId',
      attribute: responseAttribute,
    );

    final proposeAttributeAcceptResponseItem = ProposeAttributeAcceptResponseItemDVO(
      id: 'responseId',
      name: 'Response',
      type: 'ProposeAttributeAcceptResponseItemDVO',
      attributeId: 'proposeAttributeId',
      attribute: responseAttribute,
    );

    final shareAttributeAcceptResponseItem = ShareAttributeAcceptResponseItemDVO(
      id: 'responseId',
      name: 'Response',
      type: 'ShareAttributeAcceptResponseItemDVO',
      attributeId: 'shareAttributeId',
      attribute: responseAttribute,
    );

    final registerAttributeAcceptResponseItem = RegisterAttributeListenerAcceptResponseItemDVO(
        id: 'responseId',
        name: 'Response',
        type: 'RegisterAttributeAcceptResponseItemDVO',
        listener: LocalAttributeListenerDVO(
          id: 'listenerId',
          name: 'Listener',
          type: 'LocalAttributeListenerDVO',
          query: identityAttributeQuery,
          peer: identityDvo,
        ),
        listenerId: 'ListenerId');

    final readAttributeRequestItemDVO = ReadAttributeRequestItemDVO(
      id: 'id',
      name: 'name',
      mustBeAccepted: false,
      isDecidable: false,
      query: identityAttributeQuery,
    );

    final proposeAttributeRequestItemDVO = ProposeAttributeRequestItemDVO(
      id: 'id',
      name: 'name',
      mustBeAccepted: false,
      isDecidable: false,
      proposedValueOverruled: true,
      query: identityAttributeQuery,
      attribute: DraftIdentityAttributeDVO(
        id: 'id',
        name: 'name',
        type: 'type',
        content: const IdentityAttribute(
          owner: 'owner',
          value: GivenNameAttributeValue(value: 'value'),
        ),
        owner: identityDvo,
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        valueHints: const ValueHints(),
        valueType: 'valueType',
        isOwn: false,
        isDraft: false,
        value: const GivenNameAttributeValue(value: 'value'),
        tags: ['tags'],
      ),
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
        owner: identityDvo,
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
        owner: identityDvo,
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

    final registerAttributeListenerRequestItemDVO = RegisterAttributeListenerRequestItemDVO(
      id: 'id',
      name: 'name',
      mustBeAccepted: false,
      isDecidable: false,
      query: identityAttributeQuery,
    );

    final LocalRequestDVO localRequest = LocalRequestDVO(
      id: 'a id',
      name: 'a name',
      type: 'LocalRequestDVO',
      isOwn: false,
      createdAt: '2023-09-27T11:41:36.933Z',
      status: LocalRequestStatus.ManualDecisionRequired,
      statusText: 'a statusText',
      directionText: 'a directionText',
      sourceTypeText: 'a sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [
        createAttributeRequestItemDVO,
        proposeAttributeRequestItemDVO,
        registerAttributeListenerRequestItemDVO,
        readAttributeRequestItemDVO,
        shareAttributeRequestItemDVO,
      ],
      response: LocalResponseDVO(
        id: 'responseId',
        name: 'Response Name',
        type: 'LocalResponseDVO',
        createdAt: '2023-09-27T11:41:36.933Z',
        content: ResponseDVO(
          id: 'contentId',
          name: 'Content',
          type: 'ResponseDVO',
          items: [
            createAttributeAcceptResponseItem,
            proposeAttributeAcceptResponseItem,
            registerAttributeAcceptResponseItem,
            readAttributeAcceptResponseItem,
            shareAttributeAcceptResponseItem,
          ],
          result: ResponseResult.Accepted,
        ),
      ),
      content: RequestDVO(
        id: 'REQyB8AzanfTmT3afh8e',
        name: 'Request REQyB8AzanfTmT3afh8e',
        type: 'RequestDVO',
        items: [
          createAttributeRequestItemDVO,
          proposeAttributeRequestItemDVO,
          registerAttributeListenerRequestItemDVO,
          readAttributeRequestItemDVO,
          shareAttributeRequestItemDVO,
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
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
            Expanded(
              child: RequestRenderer(
                request: localRequest,
                currentAddress: 'a current address',
                chooseFile: () async => null,
                expandFileReference: (_) async => throw Exception('Not implemented'),
                openFileDetails: (_) async => throw Exception('Not implemented'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
