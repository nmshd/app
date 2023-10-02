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
    return switch (attribute.value) {
      final ConsentAttributeValue value => _ConsentAttributeValueRenderer(value: value),
      final ProprietaryBooleanAttributeValue value => _ProprietaryBooleanAttributeValueRenderer(value: value),
      final ProprietaryFloatAttributeValue value => _ProprietaryFloatAttributeValueRenderer(value: value),
      final ProprietaryIntegerAttributeValue value => _ProprietaryIntegerAttributeValueRenderer(value: value),
      final ProprietaryJSONAttributeValue value => _ProprietaryJSONAttributeValueRenderer(value: value),
      final ProprietaryXMLAttributeValue value => _ProprietaryXMLAttributeValueRenderer(value: value),
      _ => switch (attribute.value.runtimeType) {
          ProprietaryCountryAttributeValue => _ProprietaryAttributeValueRenderer(attribute: attribute),
          ProprietaryEMailAddressAttributeValue => _ProprietaryAttributeValueRenderer(attribute: attribute),
          ProprietaryFileReferenceAttributeValue => _ProprietaryAttributeValueRenderer(attribute: attribute),
          ProprietaryHEXColorAttributeValue => _ProprietaryAttributeValueRenderer(attribute: attribute),
          ProprietaryLanguageAttributeValue => _ProprietaryAttributeValueRenderer(attribute: attribute),
          ProprietaryPhoneNumberAttributeValue => _ProprietaryAttributeValueRenderer(attribute: attribute),
          ProprietaryStringAttributeValue => _ProprietaryAttributeValueRenderer(attribute: attribute),
          ProprietaryURLAttributeValue => _ProprietaryAttributeValueRenderer(attribute: attribute),
          _ => throw Exception('Unknown AbstractAttributeValue: ${attribute.value.runtimeType}'),
        },
    };
  }
}

class _ConsentAttributeValueRenderer extends StatelessWidget {
  final ConsentAttributeValue value;

  const _ConsentAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(value.consent);
  }
}

class _ProprietaryBooleanAttributeValueRenderer extends StatelessWidget {
  final ProprietaryBooleanAttributeValue value;

  const _ProprietaryBooleanAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(value.value.toString());
  }
}

class _ProprietaryFloatAttributeValueRenderer extends StatelessWidget {
  final ProprietaryFloatAttributeValue value;

  const _ProprietaryFloatAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(value.value.toString());
  }
}

class _ProprietaryIntegerAttributeValueRenderer extends StatelessWidget {
  final ProprietaryIntegerAttributeValue value;

  const _ProprietaryIntegerAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(value.value.toString());
  }
}

class _ProprietaryJSONAttributeValueRenderer extends StatelessWidget {
  final ProprietaryJSONAttributeValue value;

  const _ProprietaryJSONAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(value.value.toString());
  }
}

class _ProprietaryXMLAttributeValueRenderer extends StatelessWidget {
  final ProprietaryXMLAttributeValue value;

  const _ProprietaryXMLAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(value.value);
  }
}

class _ProprietaryAttributeValueRenderer extends StatelessWidget {
  final RelationshipAttribute attribute;

  const _ProprietaryAttributeValueRenderer({required this.attribute});

  @override
  Widget build(BuildContext context) {
    return switch (attribute.value) {
      final ProprietaryCountryAttributeValue value => Text(value.value),
      final ProprietaryEMailAddressAttributeValue value => Text(value.value),
      final ProprietaryFileReferenceAttributeValue value => Text(value.value),
      final ProprietaryHEXColorAttributeValue value => Text(value.value),
      final ProprietaryLanguageAttributeValue value => Text(value.value),
      final ProprietaryPhoneNumberAttributeValue value => Text(value.value),
      final ProprietaryStringAttributeValue value => Text(value.value),
      final ProprietaryURLAttributeValue value => Text(value.value),
      _ => throw Exception('Unknown AbstractAttributeValue:'),
    };
  }
}
