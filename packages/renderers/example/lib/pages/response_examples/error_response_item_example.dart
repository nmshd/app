import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

class ErrorResponseItemExample extends StatelessWidget {
  const ErrorResponseItemExample({super.key});

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

    const errorResponseItem = ErrorResponseItemDVO(
      id: 'an id',
      name: 'name',
      type: 'ErrorResponseItemDVO',
      code: 'ErrorCode',
      message: 'An Error has occurred.',
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
      ],
      response: const LocalResponseDVO(
        id: 'responseId',
        name: 'Response Name',
        type: 'LocalResponseDVO',
        createdAt: '2023-09-27T11:41:36.933Z',
        content: ResponseDVO(
          id: 'contentId',
          name: 'Content',
          type: 'ResponseDVO',
          items: [errorResponseItem],
          result: ResponseResult.Accepted,
        ),
      ),
      content: RequestDVO(
        id: 'REQyB8AzanfTmT3afh8e',
        name: 'Request REQyB8AzanfTmT3afh8e',
        type: 'RequestDVO',
        items: [
          createAttributeRequestItemDVO,
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
            Expanded(child: RequestRenderer(request: localRequest, currentAddress: 'a current address')),
          ],
        ),
      ),
    );
  }
}
