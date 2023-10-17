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
      title: 'i18n://attributes.values.Affiliation._title',
      titles: const [
        'i18n://attributes.values.Affiliation.role.label',
        'i18n://attributes.values.Affiliation.organization.label',
        'i18n://attributes.values.Affiliation.unit.label',
      ],
      subTitles: [value.role, value.organization, value.unit],
      trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
    );
  }
}

class _BirthDateAttributeValueRenderer extends StatelessWidget {
  final BirthDateAttributeValue value;

  const _BirthDateAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: 'i18n://attributes.values.BirthDate._title',
      titles: const [
        'i18n://attributes.values.BirthDate.day.label',
        'i18n://attributes.values.BirthDate.month.label',
        'i18n://attributes.values.BirthDate.year.label',
      ],
      subTitles: [value.day.toString(), value.month.toString(), value.year.toString()],
      trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
    );
  }
}

class _BirthPlaceAttributeValueRenderer extends StatelessWidget {
  final BirthPlaceAttributeValue value;

  const _BirthPlaceAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: 'i18n://attributes.values.BirthPlace._title',
      titles: const [
        'i18n://attributes.values.BirthPlace.city.label',
        'i18n://attributes.values.BirthPlace.country.label',
        'i18n://attributes.values.BirthPlace.state.label',
      ],
      subTitles: [value.city, value.country, value.state],
      trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
    );
  }
}

class _DeliveryBoxAddressAttributeValueRenderer extends StatelessWidget {
  final DeliveryBoxAddressAttributeValue value;

  const _DeliveryBoxAddressAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: 'i18n://attributes.values.DeliveryBoxAddress._title',
      titles: const [
        'i18n://attributes.values.DeliveryBoxAddress.recipient.label',
        'i18n://attributes.values.DeliveryBoxAddress.userId.label',
        'i18n://attributes.values.DeliveryBoxAddress.deliveryBoxId.label',
        'i18n://attributes.values.DeliveryBoxAddress.zipCode.label',
        'i18n://attributes.values.DeliveryBoxAddress.city.label',
        'i18n://attributes.values.DeliveryBoxAddress.country.label',
        'i18n://attributes.values.DeliveryBoxAddress.phoneNumber.label',
        'i18n://attributes.values.DeliveryBoxAddress.state.label',
      ],
      subTitles: [
        value.recipient,
        value.userId,
        value.deliveryBoxId,
        value.zipCode,
        value.city,
        value.country,
        value.phoneNumber,
        value.state,
      ],
      trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
    );
  }
}

class _PersonNameAttributeValueRenderer extends StatelessWidget {
  final PersonNameAttributeValue value;

  const _PersonNameAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: 'i18n://attributes.values.PersonName._title',
      titles: const [
        'i18n://attributes.values.PersonName.givenName.label',
        'i18n://attributes.values.PersonName.middleName.label',
        'i18n://attributes.values.PersonName.surname.label',
        'i18n://attributes.values.PersonName.honorificSuffix.label',
        'i18n://attributes.values.PersonName.honorificPrefix.label',
      ],
      subTitles: [
        value.givenName,
        value.middleName,
        value.surname,
        value.honorificSuffix,
        value.honorificPrefix,
      ],
      trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
    );
  }
}

class _PostOfficeBoxAddressAttributeValueRenderer extends StatelessWidget {
  final PostOfficeBoxAddressAttributeValue value;

  const _PostOfficeBoxAddressAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: 'i18n://attributes.values.PostOfficeBoxAddress._title',
      titles: const [
        'i18n://attributes.values.PostOfficeBoxAddress.recipient.label',
        'i18n://attributes.values.PostOfficeBoxAddress.boxId.label',
        'i18n://attributes.values.PostOfficeBoxAddress.zipCode.label',
        'i18n://attributes.values.PostOfficeBoxAddress.city.label',
        'i18n://attributes.values.PostOfficeBoxAddress.country.label',
        'i18n://attributes.values.PostOfficeBoxAddress.state.label',
      ],
      subTitles: [
        value.recipient,
        value.boxId,
        value.zipCode,
        value.city,
        value.country,
        value.state,
      ],
      trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
    );
  }
}

class _StreetAddressAttributeValueRenderer extends StatelessWidget {
  final StreetAddressAttributeValue value;

  const _StreetAddressAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: 'i18n://attributes.values.StreetAddress._title',
      titles: const [
        'i18n://attributes.values.StreetAddress.recipient.label',
        'i18n://attributes.values.StreetAddress.street.label',
        'i18n://attributes.values.StreetAddress.houseNo.label',
        'i18n://attributes.values.StreetAddress.zipCode.label',
        'i18n://attributes.values.StreetAddress.city.label',
        'i18n://attributes.values.StreetAddress.country.label',
        'i18n://attributes.values.StreetAddress.state.label',
      ],
      subTitles: [
        value.recipient,
        value.street,
        value.houseNumber,
        value.zipCode,
        value.city,
        value.country,
        value.state,
      ],
      trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
    );
  }
}

class _SchematizedXMLAttributeValueRenderer extends StatelessWidget {
  final SchematizedXMLAttributeValue value;

  const _SchematizedXMLAttributeValueRenderer({required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: 'i18n://dvo.attribute.name.SchematizedXML',
      subTitle: value.value,
      trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
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
      trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
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
          title: 'i18n://dvo.attribute.name.AffiliationOrganization',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final AffiliationRoleAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.AffiliationRole',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final AffiliationUnitAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.AffiliationUnit',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final BirthCityAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.BirthCity',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final BirthNameAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.BirthName',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final BirthStateAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.BirthState',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final CityAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.City',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final DisplayNameAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.DisplayName',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final IdentityFileReferenceAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.IdentityFileReference',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final GivenNameAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.GivenName',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final HonorificPrefixAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.HonorificPrefix',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final HonorificSuffixAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.HonorificSuffix',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final HouseNumberAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.HouseNumber',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final JobTitleAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.JobTitle',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final MiddleNameAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.MiddleName',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final PhoneNumberAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.PhoneNumber',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final PseudonymAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.Pseudonym',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final StateAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.State',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final StreetAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.Street',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final SurnameAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.Surname',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final ZipCodeAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.ZipCode',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final BirthDayAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.BirthDay',
          subTitle: value.value.toString(),
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final BirthMonthAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.BirthMonth',
          subTitle: value.value.toString(),
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final BirthYearAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.BirthYear',
          subTitle: value.value.toString(),
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final CitizenshipAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.Citizenship',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final CommunicationLanguageAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.CommunicationLanguage',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final CountryAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.Country',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final EMailAddressAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.EMailAddress',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final FaxNumberAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.FaxNumber',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final NationalityAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.Nationality',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final SexAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.Sex',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      final WebsiteAttributeValue value => CustomListTile(
          title: 'i18n://dvo.attribute.name.Website',
          subTitle: value.value,
          trailing: const IconButton(onPressed: null, icon: Icon(Icons.info)),
        ),
      _ => throw Exception('Unknown AbstractAttributeValue: ${attribute.value.runtimeType}'),
    };
  }
}
