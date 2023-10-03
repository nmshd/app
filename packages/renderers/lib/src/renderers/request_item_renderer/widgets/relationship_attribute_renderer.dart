import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/src/renderers/request_item_renderer/widgets/identity_attribute_renderer.dart';

class DraftRelationshipAttributeRenderer extends StatelessWidget {
  final DraftRelationshipAttributeDVO attribute;

  const DraftRelationshipAttributeRenderer({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return switch (attribute.content) {
      final IdentityAttribute attribute => IdentityAttributeRenderer(attribute: attribute),
      final RelationshipAttribute attribute => _RelationshipAttributeRenderer(attribute: attribute),
      _ => throw Exception('Unknown AbstractAttribute: ${attribute.content.runtimeType}')
    };
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(value.title), Text(value.value.toString())],
    );
  }
}

class _ProprietaryFloatAttributeValueRenderer extends StatelessWidget {
  final ProprietaryFloatAttributeValue value;

  const _ProprietaryFloatAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(value.title), Text(value.value.toString())],
    );
  }
}

class _ProprietaryIntegerAttributeValueRenderer extends StatelessWidget {
  final ProprietaryIntegerAttributeValue value;

  const _ProprietaryIntegerAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(value.title), Text(value.value.toString())],
    );
  }
}

class _ProprietaryJSONAttributeValueRenderer extends StatelessWidget {
  final ProprietaryJSONAttributeValue value;

  const _ProprietaryJSONAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(value.title), Text(value.value.toString())],
    );
  }
}

class _ProprietaryXMLAttributeValueRenderer extends StatelessWidget {
  final ProprietaryXMLAttributeValue value;

  const _ProprietaryXMLAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(value.title), Text(value.value)],
    );
  }
}

class _ProprietaryAttributeValueRenderer extends StatelessWidget {
  final RelationshipAttribute attribute;

  const _ProprietaryAttributeValueRenderer({required this.attribute});

  @override
  Widget build(BuildContext context) {
    return switch (attribute.value) {
      final ProprietaryCountryAttributeValue value =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value.title), Text(value.value)]),
      final ProprietaryEMailAddressAttributeValue value =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value.title), Text(value.value)]),
      final ProprietaryFileReferenceAttributeValue value =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value.title), Text(value.value)]),
      final ProprietaryHEXColorAttributeValue value =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value.title), Text(value.value)]),
      final ProprietaryLanguageAttributeValue value =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value.title), Text(value.value)]),
      final ProprietaryPhoneNumberAttributeValue value =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value.title), Text(value.value)]),
      final ProprietaryStringAttributeValue value =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value.title), Text(value.value)]),
      final ProprietaryURLAttributeValue value =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value.title), Text(value.value)]),
      _ => throw Exception('Unknown AbstractAttributeValue:'),
    };
  }
}
