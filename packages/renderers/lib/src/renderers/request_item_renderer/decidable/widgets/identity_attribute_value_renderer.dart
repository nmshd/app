import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../../../../renderers.dart';
import '../../../widgets/complex_attribute_list_tile.dart';
import '../../../widgets/custom_list_tile.dart';

class IdentityAttributeValueRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final IdentityAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const IdentityAttributeValueRenderer({super.key, required this.value, required this.query, required this.controller, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      final AffiliationAttributeValue value => _AffiliationAttributeValueRenderer(value: value, query: query, controller: controller, onEdit: onEdit),
      final BirthDateAttributeValue value => _BirthDateAttributeValueRenderer(value: value, query: query, controller: controller, onEdit: onEdit),
      final BirthPlaceAttributeValue value => _BirthPlaceAttributeValueRenderer(value: value, query: query, controller: controller, onEdit: onEdit),
      final DeliveryBoxAddressAttributeValue value => _DeliveryBoxAddressAttributeValueRenderer(
          value: value,
          query: query,
          controller: controller,
          onEdit: onEdit,
        ),
      final PersonNameAttributeValue value => _PersonNameAttributeValueRenderer(value: value, query: query, controller: controller, onEdit: onEdit),
      final PostOfficeBoxAddressAttributeValue value => _PostOfficeBoxAddressAttributeValueRenderer(
          value: value,
          query: query,
          controller: controller,
          onEdit: onEdit,
        ),
      final StreetAddressAttributeValue value => _StreetAddressAttributeValueRenderer(
          value: value,
          query: query,
          controller: controller,
          onEdit: onEdit,
        ),
      final SchematizedXMLAttributeValue value => _SchematizedXMLAttributeValueRenderer(
          value: value,
          query: query,
          controller: controller,
          onEdit: onEdit,
        ),
      final StatementAttributeValue value => _StatementAttributeValueRenderer(value: value, query: query, controller: controller, onEdit: onEdit),
      _ => _StringIdentityAttributeRenderer(value: value, results: query.results, controller: controller, onEdit: onEdit),
    };
  }
}

class _AffiliationAttributeValueRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final AffiliationAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _AffiliationAttributeValueRenderer({required this.value, required this.query, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: query.valueType,
      titles: const [
        'i18n://attributes.values.Affiliation.role.label',
        'i18n://attributes.values.Affiliation.organization.label',
        'i18n://attributes.values.Affiliation.unit.label',
      ],
      subTitles: [value.role, value.organization, value.unit],
      trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
    );
  }
}

class _BirthDateAttributeValueRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final BirthDateAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _BirthDateAttributeValueRenderer({required this.value, required this.query, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: query.valueType,
      titles: const [
        'i18n://attributes.values.BirthDate.day.label',
        'i18n://attributes.values.BirthDate.month.label',
        'i18n://attributes.values.BirthDate.year.label',
      ],
      subTitles: [value.day.toString(), value.month.toString(), value.year.toString()],
      trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
    );
  }
}

class _BirthPlaceAttributeValueRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final BirthPlaceAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _BirthPlaceAttributeValueRenderer({required this.value, required this.query, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: query.valueType,
      titles: const [
        'i18n://attributes.values.BirthPlace.city.label',
        'i18n://attributes.values.BirthPlace.country.label',
        'i18n://attributes.values.BirthPlace.state.label',
      ],
      subTitles: [value.city, value.country, value.state],
      trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
    );
  }
}

class _DeliveryBoxAddressAttributeValueRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final DeliveryBoxAddressAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _DeliveryBoxAddressAttributeValueRenderer({required this.value, required this.query, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: query.valueType,
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
      subTitles: [value.recipient, value.deliveryBoxId, value.userId, value.zipCode, value.city, value.country, value.phoneNumber, value.state],
      trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
    );
  }
}

class _PersonNameAttributeValueRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final PersonNameAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _PersonNameAttributeValueRenderer({required this.value, required this.query, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: query.valueType,
      titles: const [
        'i18n://attributes.values.PersonName.givenName.label',
        'i18n://attributes.values.PersonName.middleName.label',
        'i18n://attributes.values.PersonName.surname.label',
        'i18n://attributes.values.PersonName.honorificSuffix.label',
        'i18n://attributes.values.PersonName.honorificPrefix.label',
      ],
      subTitles: [value.givenName, value.middleName, value.surname, value.honorificSuffix, value.honorificPrefix],
      trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
    );
  }
}

class _PostOfficeBoxAddressAttributeValueRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final PostOfficeBoxAddressAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _PostOfficeBoxAddressAttributeValueRenderer({required this.value, required this.query, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: query.valueType,
      titles: const [
        'i18n://attributes.values.PostOfficeBoxAddress.recipient.label',
        'i18n://attributes.values.PostOfficeBoxAddress.boxId.label',
        'i18n://attributes.values.PostOfficeBoxAddress.zipCode.label',
        'i18n://attributes.values.PostOfficeBoxAddress.city.label',
        'i18n://attributes.values.PostOfficeBoxAddress.country.label',
        'i18n://attributes.values.PostOfficeBoxAddress.state.label',
      ],
      subTitles: [value.recipient, value.boxId, value.zipCode, value.city, value.country, value.state],
      trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
    );
  }
}

class _StreetAddressAttributeValueRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final StreetAddressAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _StreetAddressAttributeValueRenderer({required this.value, required this.query, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      title: query.valueType,
      titles: const [
        'i18n://attributes.values.StreetAddress.recipient.label',
        'i18n://attributes.values.StreetAddress.street.label',
        'i18n://attributes.values.StreetAddress.houseNo.label',
        'i18n://attributes.values.StreetAddress.zipCode.label',
        'i18n://attributes.values.StreetAddress.city.label',
        'i18n://attributes.values.StreetAddress.country.label',
        'i18n://attributes.values.StreetAddress.state.label',
      ],
      subTitles: [value.recipient, value.street, value.houseNumber, value.zipCode, value.city, value.country, value.state],
      trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
    );
  }
}

class _SchematizedXMLAttributeValueRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final SchematizedXMLAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _SchematizedXMLAttributeValueRenderer({required this.value, required this.query, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: query.results.first.name,
      subTitle: value.value,
      trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
    );
  }
}

// TODO properly implement this asap when the class is implemented
class _StatementAttributeValueRenderer extends StatelessWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final StatementAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _StatementAttributeValueRenderer({required this.value, required this.query, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: query.results.first.name,
      subTitle: value.json.toString(),
      trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
    );
  }
}

class _StringIdentityAttributeRenderer extends StatelessWidget {
  final List<IdentityAttributeDVO> results;
  final IdentityAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _StringIdentityAttributeRenderer({required this.results, required this.value, required this.controller, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      final AffiliationOrganizationAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final AffiliationRoleAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final AffiliationUnitAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final BirthCityAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final BirthNameAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final BirthStateAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final CityAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final DisplayNameAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final IdentityFileReferenceAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final GivenNameAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final HonorificPrefixAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final HonorificSuffixAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final HouseNumberAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final JobTitleAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final MiddleNameAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final PhoneNumberAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final PseudonymAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final StateAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final StreetAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final SurnameAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final ZipCodeAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final BirthDayAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value.toString(),
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final BirthMonthAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value.toString(),
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final BirthYearAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value.toString(),
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final CitizenshipAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final CommunicationLanguageAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final CountryAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final EMailAddressAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final FaxNumberAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final NationalityAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final SexAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      final WebsiteAttributeValue value => CustomListTile(
          title: results.first.name,
          subTitle: value.value,
          trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
        ),
      _ => throw Exception('Unknown AbstractAttributeValue: ${value.runtimeType}'),
    };
  }
}
