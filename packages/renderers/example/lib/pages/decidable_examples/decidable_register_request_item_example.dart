import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

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

    final identityAttributeQuery = IdentityAttributeQueryDVO(
      id: 'an id',
      name: 'a Name',
      isProcessed: false,
      type: 'IdentityAttributeQueryDVO',
      tags: [],
      valueType: 'DisplayName',
      renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      valueHints: const ValueHints(),
    );

    final relationshipAttributeQuery = RelationshipAttributeQueryDVO(
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
    );
    const thirdPartyRelationshipAttributeQuery = ThirdPartyRelationshipAttributeQueryDVO(
      id: 'id',
      name: 'name',
      type: 'ThirdPartyRelationshipAttribute',
      thirdParty: [identityDvo],
      isProcessed: false,
      key: 'a key',
      owner: identityDvo,
    );

    final decidableRegisterRequestItemIdentity = DecidableRegisterAttributeListenerRequestItemDVO(
      id: '1',
      name: 'Read 1',
      mustBeAccepted: true,
      query: identityAttributeQuery,
    );

    final decidableRegisterRequestItemRelationship = DecidableRegisterAttributeListenerRequestItemDVO(
      id: '1',
      name: 'Read 1',
      mustBeAccepted: true,
      query: relationshipAttributeQuery,
    );

    const decidableRegisterRequestItemThirdParty = DecidableRegisterAttributeListenerRequestItemDVO(
      id: '1',
      name: 'Read 1',
      mustBeAccepted: true,
      query: thirdPartyRelationshipAttributeQuery,
    );

    final LocalRequestDVO localRequest = LocalRequestDVO(
      id: 'a id',
      name: 'a name',
      type: 'LocalRequestDVO',
      isOwn: false,
      createdAt: '2023-09-27T11:41:36.933Z',
      content: RequestDVO(
        id: 'REQyB8AzanfTmT3afh8e',
        name: 'Request REQyB8AzanfTmT3afh8e',
        type: 'RequestDVO',
        items: [decidableRegisterRequestItemIdentity, decidableRegisterRequestItemRelationship, decidableRegisterRequestItemThirdParty],
      ),
      status: LocalRequestStatus.ManualDecisionRequired,
      statusText: 'a statusText',
      directionText: 'a directionText',
      sourceTypeText: 'a sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [decidableRegisterRequestItemIdentity, decidableRegisterRequestItemRelationship, decidableRegisterRequestItemThirdParty],
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
            RequestRenderer(request: localRequest),
          ],
        ),
      ),
    );
  }
}
