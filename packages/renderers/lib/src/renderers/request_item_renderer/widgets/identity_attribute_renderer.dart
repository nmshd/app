import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

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
      children: [
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
      children: [
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
      children: [
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
      children: [
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
      children: [
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
      children: [
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
      children: [
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
      children: [
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
      children: [
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
      final AffiliationOrganizationAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('AffiliationOrganization'), Text(value.value)],
        ),
      final AffiliationRoleAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('AffiliationRole'), Text(value.value)],
        ),
      final AffiliationUnitAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('AffiliationUnit'), Text(value.value)],
        ),
      final BirthCityAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('BirthCity'), Text(value.value)],
        ),
      final BirthNameAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('BirthName'), Text(value.value)],
        ),
      final BirthStateAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('BirthState'), Text(value.value)],
        ),
      final CityAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('City'), Text(value.value)],
        ),
      final DisplayNameAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('DisplayName'), Text(value.value)],
        ),
      final IdentityFileReferenceAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('IdentityFileReference'), Text(value.value)],
        ),
      final GivenNameAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('GivenName'), Text(value.value)],
        ),
      final HonorificPrefixAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('HonorificPrefix'), Text(value.value)],
        ),
      final HonorificSuffixAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('HonorificSuffix'), Text(value.value)],
        ),
      final HouseNumberAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('HouseNumber'), Text(value.value)],
        ),
      final JobTitleAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('JobTitle'), Text(value.value)],
        ),
      final MiddleNameAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('MiddleName'), Text(value.value)],
        ),
      final PhoneNumberAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('PhoneNumber'), Text(value.value)],
        ),
      final PseudonymAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('Pseudonym'), Text(value.value)],
        ),
      final StateAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('State'), Text(value.value)],
        ),
      final StreetAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('Street'), Text(value.value)],
        ),
      final SurnameAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('Surname'), Text(value.value)],
        ),
      final ZipCodeAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('ZipCode'), Text(value.value)],
        ),
      final BirthDayAttributeValue value =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('BirthDay'), Text(value.value.toString())]),
      final BirthMonthAttributeValue value =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('BirthMonth'), Text(value.value.toString())]),
      final BirthYearAttributeValue value =>
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('BirthYear'), Text(value.value.toString())]),
      final CitizenshipAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('Citizenship'), Text(value.value)],
        ),
      final CommunicationLanguageAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('CommunicationLanguage'), Text(value.value)],
        ),
      final CountryAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('Country'), Text(value.value)],
        ),
      final EMailAddressAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('EMailAddress'), Text(value.value)],
        ),
      final FaxNumberAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('FaxNumber'), Text(value.value)],
        ),
      final NationalityAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('Nationality'), Text(value.value)],
        ),
      final SexAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('Sex'), Text(value.value)],
        ),
      final WebsiteAttributeValue value => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('Website'), Text(value.value)],
        ),
      _ => throw Exception('Unknown AbstractAttributeValue: ${attribute.value.runtimeType}'),
    };
  }
}
