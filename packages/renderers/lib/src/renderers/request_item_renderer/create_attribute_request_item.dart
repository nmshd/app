import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../request_renderer.dart';

class CreateAttributeRequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final CreateAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const CreateAttributeRequestItemRenderer({super.key, required this.request, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.type, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text.rich(TextSpan(
          text: 'Titel: ',
          children: [TextSpan(text: request.name)],
        )),
        Text.rich(TextSpan(
          text: 'Description: ',
          children: [TextSpan(text: request.description)],
        )),
        Text.rich(TextSpan(
          text: 'Request ID: ',
          children: [TextSpan(text: request.id)],
        )),
        Text.rich(TextSpan(
          text: 'Status: ',
          children: [TextSpan(text: request.statusText)],
        )),
        Text.rich(TextSpan(
          text: 'Created by: ',
          children: [TextSpan(text: request.createdBy.name)],
        )),
        Text.rich(
          TextSpan(
            text: 'Created at: ',
            children: [TextSpan(text: request.createdAt)],
          ),
        ),
        const Divider(),
        switch (item.attribute) {
          final DraftIdentityAttributeDVO dvo => _DraftIdentityAttributeRenderer(attribute: dvo),
          final DraftRelationshipAttributeDVO dvo => _DraftRelationshipAttributeRenderer(attribute: dvo),
        }
        // TODO: children: [TextSpan(text: DateFormat('yMd', Localizations.localeOf(context).languageCode).format(DateTime.parse(request.createdAt)))],
      ],
    );
  }
}

class _DraftIdentityAttributeRenderer extends StatelessWidget {
  final DraftIdentityAttributeDVO attribute;

  const _DraftIdentityAttributeRenderer({required this.attribute});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _DraftRelationshipAttributeRenderer extends StatelessWidget {
  final DraftRelationshipAttributeDVO attribute;

  const _DraftRelationshipAttributeRenderer({required this.attribute});

  @override
  Widget build(BuildContext context) {
    return switch (attribute.content) {
      final IdentityAttribute attribute => _IdentityAttriubteRenderer(attribute: attribute),
      final RelationshipAttribute attribute => _RelationshipAttributeRenderer(attribute: attribute),
      _ => throw Exception('Unknown AbstractAttribute: ${attribute.content.runtimeType}')
    };
  }
}

class _IdentityAttriubteRenderer extends StatelessWidget {
  final IdentityAttribute attribute;

  const _IdentityAttriubteRenderer({required this.attribute});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _RelationshipAttributeRenderer extends StatelessWidget {
  final RelationshipAttribute attribute;

  const _RelationshipAttributeRenderer({required this.attribute});
  @override
  Widget build(BuildContext context) {
    return Text(attribute.toJson().toString());
  }
}
