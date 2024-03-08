import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

class CanAcceptCheckboxExample extends StatelessWidget {
  const CanAcceptCheckboxExample({super.key});

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

    final identityAttributeQuery = ProcessedIdentityAttributeQueryDVO(
      id: 'an id',
      name: 'Identity Attribute Name',
      tags: [],
      results: [],
      valueType: 'DisplayName',
      renderHints: RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      valueHints: const ValueHints(),
    );

    final draftIdentityAttributeDVOTrue = DraftIdentityAttributeDVO(
      id: '',
      name: 'Art der Hochschulzulassung',
      type: 'DraftIdentityAttributeDVO',
      content: const IdentityAttribute(
        owner: 'id17VhbFbFMg1xQC784SEwsbEGXxGKtcB67V',
        value: DisplayNameAttributeValue(value: 'Must Be Accepted: True'),
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
      value: const DisplayNameAttributeValue(value: 'Must Be Accepted: True'),
      tags: [],
    );

    final draftIdentityAttributeDVOFalse = DraftIdentityAttributeDVO(
      id: '',
      name: 'Art der Hochschulzulassung',
      type: 'DraftIdentityAttributeDVO',
      content: const IdentityAttribute(
        owner: 'id17VhbFbFMg1xQC784SEwsbEGXxGKtcB67V',
        value: DisplayNameAttributeValue(value: 'Must Be Accepted: False'),
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
      value: const DisplayNameAttributeValue(value: 'Must Be Accepted: False'),
      tags: [],
    );

    final mustBeAcceptedTrue = DecidableProposeAttributeRequestItemDVO(
      id: 'Id',
      name: 'Name',
      mustBeAccepted: true,
      query: identityAttributeQuery,
      attribute: draftIdentityAttributeDVOTrue,
      requireManualDecision: true,
    );
    final mustBeAcceptedFalse = DecidableProposeAttributeRequestItemDVO(
      id: 'Id',
      name: 'Name',
      mustBeAccepted: false,
      query: identityAttributeQuery,
      attribute: draftIdentityAttributeDVOFalse,
      requireManualDecision: false,
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
        items: [mustBeAcceptedFalse, mustBeAcceptedTrue],
      ),
      status: LocalRequestStatus.DecisionRequired,
      statusText: 'a statusText',
      directionText: 'a directionText',
      sourceTypeText: 'a sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [mustBeAcceptedFalse, mustBeAcceptedTrue],
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
                chooseFile: () async => null,
                expandFileReference: (_) async => throw Exception('Not implemented'),
                request: localRequest,
                currentAddress: 'a currentAddress',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
