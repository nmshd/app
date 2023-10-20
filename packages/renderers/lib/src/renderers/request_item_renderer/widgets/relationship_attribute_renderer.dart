import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/src/renderers/request_item_renderer/widgets/identity_attribute_renderer.dart';

import '../../widgets/custom_list_tile.dart';

class DraftRelationshipAttributeRenderer extends StatelessWidget {
  final DraftRelationshipAttributeDVO attribute;

  const DraftRelationshipAttributeRenderer({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return switch (attribute.content) {
      final IdentityAttribute attribute => IdentityAttributeRenderer(attribute: attribute),
      final RelationshipAttribute attribute => RelationshipAttributeRenderer(attribute: attribute),
      _ => throw Exception('Unknown AbstractAttribute: ${attribute.content.runtimeType}')
    };
  }
}

class RelationshipAttributeRenderer extends StatelessWidget {
  final RelationshipAttribute attribute;

  const RelationshipAttributeRenderer({super.key, required this.attribute});
  @override
  Widget build(BuildContext context) {
    return switch (attribute.value) {
      final ConsentAttributeValue value => _ConsentAttributeValueRenderer(value: value),
      final ProprietaryBooleanAttributeValue value => _ProprietaryBooleanAttributeValueRenderer(value: value),
      final ProprietaryFloatAttributeValue value => _ProprietaryFloatAttributeValueRenderer(value: value),
      final ProprietaryIntegerAttributeValue value => _ProprietaryIntegerAttributeValueRenderer(value: value),
      final ProprietaryJSONAttributeValue value => _ProprietaryJSONAttributeValueRenderer(value: value),
      final ProprietaryXMLAttributeValue value => _ProprietaryXMLAttributeValueRenderer(value: value),
      _ => _ProprietaryAttributeValueRenderer(attribute: attribute),
    };
  }
}

class _ConsentAttributeValueRenderer extends StatelessWidget {
  final ConsentAttributeValue value;

  const _ConsentAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(title: '', value: value.consent);
  }
}

class _ProprietaryBooleanAttributeValueRenderer extends StatelessWidget {
  final ProprietaryBooleanAttributeValue value;

  const _ProprietaryBooleanAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(title: value.title, value: value.value.toString());
  }
}

class _ProprietaryFloatAttributeValueRenderer extends StatelessWidget {
  final ProprietaryFloatAttributeValue value;

  const _ProprietaryFloatAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(title: value.title, value: value.value.toString());
  }
}

class _ProprietaryIntegerAttributeValueRenderer extends StatelessWidget {
  final ProprietaryIntegerAttributeValue value;

  const _ProprietaryIntegerAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(title: value.title, value: value.value.toString());
  }
}

class _ProprietaryJSONAttributeValueRenderer extends StatelessWidget {
  final ProprietaryJSONAttributeValue value;

  const _ProprietaryJSONAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(title: value.title, value: value.value.toString());
  }
}

class _ProprietaryXMLAttributeValueRenderer extends StatelessWidget {
  final ProprietaryXMLAttributeValue value;

  const _ProprietaryXMLAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(title: value.title, value: value.value);
  }
}

class _ProprietaryAttributeValueRenderer extends StatelessWidget {
  final RelationshipAttribute attribute;

  const _ProprietaryAttributeValueRenderer({required this.attribute});

  @override
  Widget build(BuildContext context) {
    return switch (attribute.value) {
      final ProprietaryCountryAttributeValue value => CustomListTile(title: value.title, value: value.value),
      final ProprietaryEMailAddressAttributeValue value => CustomListTile(title: value.title, value: value.value),
      final ProprietaryFileReferenceAttributeValue value => CustomListTile(title: value.title, value: value.value),
      final ProprietaryHEXColorAttributeValue value => CustomListTile(title: value.title, value: value.value),
      final ProprietaryLanguageAttributeValue value => CustomListTile(title: value.title, value: value.value),
      final ProprietaryPhoneNumberAttributeValue value => CustomListTile(title: value.title, value: value.value),
      final ProprietaryStringAttributeValue value => CustomListTile(title: value.title, value: value.value),
      final ProprietaryURLAttributeValue value => CustomListTile(title: value.title, value: value.value),
      _ => throw Exception('Unknown AbstractAttributeValue: ${attribute.value.runtimeType}'),
    };
  }
}
