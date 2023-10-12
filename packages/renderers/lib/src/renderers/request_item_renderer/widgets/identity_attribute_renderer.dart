import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_list_tile.dart';
import 'relationship_attribute_renderer.dart';

class DraftIdentityAttributeRenderer extends StatelessWidget {
  final DraftIdentityAttributeDVO attribute;

  const DraftIdentityAttributeRenderer({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return switch (attribute.content) {
      final IdentityAttribute attribute => IdentityAttributeRenderer(attribute: attribute),
      final RelationshipAttribute attribute => RelationshipAttributeRenderer(attribute: attribute),
      _ => throw Exception('Unknown AbstractAttribute: ${attribute.content.runtimeType}')
    };
  }
}

class IdentityAttributeRenderer extends StatelessWidget {
  final IdentityAttribute attribute;

  const IdentityAttributeRenderer({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    return switch (attribute.value) {
      final AffiliationAttributeValue value => _AffiliationAttributeValueRenderer(value: value),
      final BirthDateAttributeValue value => _BirthDateAttributeValueRenderer(value: value),
      final BirthPlaceAttributeValue value => _BirthPlaceAttributeValueRenderer(value: value),
      final DeliveryBoxAddressAttributeValue value => _DeliveryBoxAddressAttributeValueRenderer(value: value),
      final PersonNameAttributeValue value => _PersonNameAttributeValueRenderer(value: value),
      final PostOfficeBoxAddressAttributeValue value => _PostOfficeBoxAddressAttributeValueRenderer(value: value),
      final StreetAddressAttributeValue value => _StreetAddressAttributeValueRenderer(value: value),
      final SchematizedXMLAttributeValue value => _SchematizedXMLAttributeValueRenderer(value: value),
      final StatementAttributeValue value => _StatementAttributeValueRenderer(value: value),
      _ => _StringIdentityAttributeRenderer(attribute: attribute),
    };
  }
}

class _AffiliationAttributeValueRenderer extends StatelessWidget {
  final AffiliationAttributeValue value;

  const _AffiliationAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value.toJson()['@type']),
        Text(value.role),
        Text(value.organization),
        Text(value.unit),
      ],
    );
  }
}

class _BirthDateAttributeValueRenderer extends StatelessWidget {
  final BirthDateAttributeValue value;

  const _BirthDateAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value.toJson()['@type']),
        Text(value.day.toString()),
        Text(value.month.toString()),
        Text(value.year.toString()),
      ],
    );
  }
}

class _BirthPlaceAttributeValueRenderer extends StatelessWidget {
  final BirthPlaceAttributeValue value;

  const _BirthPlaceAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value.toJson()['@type']),
        Text(value.city),
        Text(value.country),
        if (value.state != null) Text(value.state!),
      ],
    );
  }
}

class _DeliveryBoxAddressAttributeValueRenderer extends StatelessWidget {
  final DeliveryBoxAddressAttributeValue value;

  const _DeliveryBoxAddressAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value.toJson()['@type']),
        Text(value.recipient),
        Text(value.deliveryBoxId),
        Text(value.userId),
        Text(value.zipCode),
        Text(value.city),
        Text(value.country),
        if (value.phoneNumber != null) Text(value.phoneNumber!),
        if (value.state != null) Text(value.state!),
      ],
    );
  }
}

class _PersonNameAttributeValueRenderer extends StatelessWidget {
  final PersonNameAttributeValue value;

  const _PersonNameAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value.toJson()['@type']),
        Text(value.givenName),
        if (value.middleName != null) Text(value.middleName!),
        Text(value.surname),
        if (value.honorificSuffix != null) Text(value.honorificSuffix!),
        if (value.honorificPrefix != null) Text(value.honorificPrefix!),
      ],
    );
  }
}

class _PostOfficeBoxAddressAttributeValueRenderer extends StatelessWidget {
  final PostOfficeBoxAddressAttributeValue value;

  const _PostOfficeBoxAddressAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value.toJson()['@type']),
        Text(value.recipient),
        Text(value.boxId),
        Text(value.zipCode),
        Text(value.city),
        Text(value.country),
        if (value.state != null) Text(value.state!),
      ],
    );
  }
}

class _StreetAddressAttributeValueRenderer extends StatelessWidget {
  final StreetAddressAttributeValue value;

  const _StreetAddressAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value.toJson()['@type']),
        Text(value.recipient),
        Text(value.street),
        Text(value.houseNumber),
        Text(value.zipCode),
        Text(value.city),
        Text(value.country),
        if (value.state != null) Text(value.state!),
      ],
    );
  }
}

class _SchematizedXMLAttributeValueRenderer extends StatelessWidget {
  final SchematizedXMLAttributeValue value;

  const _SchematizedXMLAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value.toJson()['@type']),
        Text(value.value),
        if (value.schemaURL != null) Text(value.schemaURL!),
      ],
    );
  }
}

// TODO properly implement this asap when the class is implemented
class _StatementAttributeValueRenderer extends StatelessWidget {
  final StatementAttributeValue value;

  const _StatementAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value.toJson()['@type']),
        Text(value.json.toString()),
      ],
    );
  }
}

class _StringIdentityAttributeRenderer extends StatelessWidget {
  final IdentityAttribute attribute;

  const _StringIdentityAttributeRenderer({required this.attribute});

  @override
  Widget build(BuildContext context) {
    return switch (attribute.value) {
      final AffiliationOrganizationAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final AffiliationRoleAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final AffiliationUnitAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final BirthCityAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final BirthNameAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final BirthStateAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final CityAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final DisplayNameAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final IdentityFileReferenceAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final GivenNameAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final HonorificPrefixAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final HonorificSuffixAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final HouseNumberAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final JobTitleAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final MiddleNameAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final PhoneNumberAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final PseudonymAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final StateAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final StreetAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final SurnameAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final ZipCodeAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final BirthDayAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value.toString()),
      final BirthMonthAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value.toString()),
      final BirthYearAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value.toString()),
      final CitizenshipAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final CommunicationLanguageAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final CountryAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final EMailAddressAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final FaxNumberAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final NationalityAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final SexAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      final WebsiteAttributeValue value => CustomListTile(title: attribute.value.toJson()['@type'], subTitle: value.value),
      _ => throw Exception('Unknown AbstractAttributeValue: ${attribute.value.runtimeType}'),
    };
  }
}
