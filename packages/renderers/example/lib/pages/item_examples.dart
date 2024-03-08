import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

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
        type: 'IdentityAttributeQueryDVO',
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
      proposedValueOverruled: true,
      query: RelationshipAttributeQueryDVO(
        id: 'id',
        name: 'name',
        type: 'RelationshipAttributeQueryDVO',
        valueType: 'valueType',
        isProcessed: false,
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        valueHints: const ValueHints(),
        key: 'key',
        owner: identityDvo,
        attributeCreationHints: const RelationshipAttributeCreationHints(
          title: 'title',
          valueType: 'valueType',
          confidentiality: 'confidentiality',
        ),
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

    const registerAttributeListenerRequestItemDVO = RegisterAttributeListenerRequestItemDVO(
      id: 'id',
      name: 'name',
      mustBeAccepted: false,
      isDecidable: false,
      query: ThirdPartyRelationshipAttributeQueryDVO(
        id: 'id',
        name: 'name',
        type: 'ThirdPartyRelationshipAttributeQueryDVO',
        isProcessed: false,
        key: 'key',
        owner: identityDvo,
        thirdParty: [],
      ),
    );

    final readAttributeRequestItem = LocalRequestDVO(
      id: 'id',
      name: 'name',
      type: 'ProposeAttributeRequestItemDVO',
      isOwn: false,
      createdAt: '2023-09-27T11:41:36.933Z',
      content: RequestDVO(
        id: '',
        name: '',
        type: 'ProposeAttributeRequestItemDVO',
        items: [
          readAttributeRequestItemDVO,
          proposeAttributeRequestItemDVO,
          authenticationRequestItemDVO,
          createAttributeRequestItemDVO,
          shareAttributeRequestItemDVO,
          consentRequestItemDVO,
          registerAttributeListenerRequestItemDVO,
        ],
      ),
      status: LocalRequestStatus.Completed,
      statusText: 'statusText',
      directionText: 'directionText',
      sourceTypeText: 'sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [
        readAttributeRequestItemDVO,
        proposeAttributeRequestItemDVO,
        authenticationRequestItemDVO,
        createAttributeRequestItemDVO,
        shareAttributeRequestItemDVO,
        consentRequestItemDVO,
        registerAttributeListenerRequestItemDVO,
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Title:', style: TextStyle(fontWeight: FontWeight.bold)),
            TranslatedText(readAttributeRequestItem.name),
            const SizedBox(height: 8),
            if (readAttributeRequestItem.description != null) ...[
              const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
              TranslatedText(readAttributeRequestItem.description!),
              const SizedBox(height: 8),
            ],
            const Text('Request ID:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(readAttributeRequestItem.id),
            const SizedBox(height: 8),
            const Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
            TranslatedText(readAttributeRequestItem.statusText),
            const SizedBox(height: 8),
            const Text('Created by:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(readAttributeRequestItem.createdBy.name),
            const SizedBox(height: 8),
            const Text('Created at:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(DateFormat('yMd', Localizations.localeOf(context).languageCode).format(DateTime.parse(readAttributeRequestItem.createdAt))),
            const Divider(),
            Expanded(
              child: RequestRenderer(
                request: readAttributeRequestItem,
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
