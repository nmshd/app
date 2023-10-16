import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/complex_attribute_list_tile.dart';
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
    return ComplexAttributeListTile(
      title: value.toJson()['@type'],
      titles: const ['Rolle', 'Organization', 'Unit'],
      subTitles: [value.role, value.organization, value.unit],
      trailing: const IconButton(
        onPressed: null,
        icon: Icon(Icons.info),
      ),
    );
  }
}

class _BirthDateAttributeValueRenderer extends StatelessWidget {
  final BirthDateAttributeValue value;

  const _BirthDateAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: value.toJson()['@type'],
      titles: const ['Day', 'Month', 'Year'],
      subTitles: [value.day.toString(), value.month.toString(), value.year.toString()],
      trailing: const IconButton(
        onPressed: null,
        icon: Icon(Icons.info),
      ),
    );
  }
}

class _BirthPlaceAttributeValueRenderer extends StatelessWidget {
  final BirthPlaceAttributeValue value;

  const _BirthPlaceAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: value.toJson()['@type'],
      titles: const ['City', 'Organization', 'Unit'],
      subTitles: [value.city, value.country, value.state],
      trailing: const IconButton(
        onPressed: null,
        icon: Icon(Icons.info),
      ),
    );
  }
}

class _DeliveryBoxAddressAttributeValueRenderer extends StatelessWidget {
  final DeliveryBoxAddressAttributeValue value;

  const _DeliveryBoxAddressAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: value.toJson()['@type'],
      titles: const ['Recipient', 'DeliveryBoxId', 'ZipCode', 'City', 'Country', 'PhoneNumber', 'State'],
      subTitles: [
        value.recipient,
        value.deliveryBoxId,
        value.zipCode,
        value.city,
        value.country,
        value.phoneNumber,
        value.state,
      ],
      trailing: const IconButton(
        onPressed: null,
        icon: Icon(Icons.info),
      ),
    );
  }
}

class _PersonNameAttributeValueRenderer extends StatelessWidget {
  final PersonNameAttributeValue value;

  const _PersonNameAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: value.toJson()['@type'],
      titles: const ['givenName', 'middleName', 'surname', 'honorificSuffix', 'honorificPrefix'],
      subTitles: [
        value.givenName,
        value.middleName,
        value.surname,
        value.honorificSuffix,
        value.honorificPrefix,
      ],
      trailing: const IconButton(
        onPressed: null,
        icon: Icon(Icons.info),
      ),
    );
  }
}

class _PostOfficeBoxAddressAttributeValueRenderer extends StatelessWidget {
  final PostOfficeBoxAddressAttributeValue value;

  const _PostOfficeBoxAddressAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: value.toJson()['@type'],
      titles: const ['recipient', 'boxId', 'zipCode', 'city', 'country', 'state'],
      subTitles: [
        value.recipient,
        value.boxId,
        value.zipCode,
        value.city,
        value.country,
        value.state,
      ],
      trailing: const IconButton(
        onPressed: null,
        icon: Icon(Icons.info),
      ),
    );
  }
}

class _StreetAddressAttributeValueRenderer extends StatelessWidget {
  final StreetAddressAttributeValue value;

  const _StreetAddressAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: value.toJson()['@type'],
      titles: const ['recipient', 'street', 'houseNumber', 'zipCode', 'city', 'country', 'state'],
      subTitles: [
        value.recipient,
        value.street,
        value.houseNumber,
        value.zipCode,
        value.city,
        value.country,
        value.state,
      ],
      trailing: const IconButton(
        onPressed: null,
        icon: Icon(Icons.info),
      ),
    );
  }
}

class _SchematizedXMLAttributeValueRenderer extends StatelessWidget {
  final SchematizedXMLAttributeValue value;

  const _SchematizedXMLAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: value.toJson()['@type'],
      subTitle: value.value,
      description: value.schemaURL != null ? Text(value.schemaURL!) : null,
      trailing: const IconButton(
        onPressed: null,
        icon: Icon(Icons.info),
      ),
    );
  }
}

class _StatementAttributeValueRenderer extends StatelessWidget {
  final StatementAttributeValue value;

  const _StatementAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: value.toJson()['@type'],
      subTitle: value.json.toString(),
      trailing: const IconButton(
        onPressed: null,
        icon: Icon(Icons.info),
      ),
    );
  }
}

class _StringIdentityAttributeRenderer extends StatelessWidget {
  final IdentityAttribute attribute;

  const _StringIdentityAttributeRenderer({required this.attribute});

  @override
  Widget build(BuildContext context) {
    return switch (attribute.value) {
      final AffiliationOrganizationAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final AffiliationRoleAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final AffiliationUnitAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final BirthCityAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final BirthNameAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final BirthStateAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final CityAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final DisplayNameAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final IdentityFileReferenceAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final GivenNameAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final HonorificPrefixAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final HonorificSuffixAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final HouseNumberAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final JobTitleAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final MiddleNameAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final PhoneNumberAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final PseudonymAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final StateAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final StreetAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final SurnameAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final ZipCodeAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final BirthDayAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value.toString(),
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final BirthMonthAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value.toString(),
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final BirthYearAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value.toString(),
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final CitizenshipAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final CommunicationLanguageAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final CountryAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final EMailAddressAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final FaxNumberAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final NationalityAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final SexAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      final WebsiteAttributeValue value => CustomListTile(
          title: attribute.value.toJson()['@type'],
          subTitle: value.value,
          trailing: const IconButton(
            onPressed: null,
            icon: Icon(Icons.info),
          ),
        ),
      _ => throw Exception('Unknown AbstractAttributeValue: ${attribute.value.runtimeType}'),
    };
  }
}
