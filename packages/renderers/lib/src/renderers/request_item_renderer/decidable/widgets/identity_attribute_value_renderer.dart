import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../../../../renderers.dart';
import '../../../widgets/complex_attribute_list_tile.dart';
import '../../../widgets/custom_list_tile.dart';

class IdentityAttributeValueRenderer extends StatelessWidget {
  final List<IdentityAttributeDVO> results;
  final IdentityAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const IdentityAttributeValueRenderer({super.key, required this.value, required this.results, required this.controller, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      final AffiliationAttributeValue value => _AffiliationAttributeValueRenderer(value: value),
      final BirthDateAttributeValue value => _BirthDateAttributeValueRenderer(value: value),
      final BirthPlaceAttributeValue value => _BirthPlaceAttributeValueRenderer(value: value),
      final DeliveryBoxAddressAttributeValue value => _DeliveryBoxAddressAttributeValueRenderer(value: value),
      final PersonNameAttributeValue value => _PersonNameAttributeValueRenderer(value: value),
      final PostOfficeBoxAddressAttributeValue value => _PostOfficeBoxAddressAttributeValueRenderer(
          value: value,
          results: results,
          controller: controller,
          onEdit: onEdit,
        ),
      final StreetAddressAttributeValue value => _StreetAddressAttributeValueRenderer(value: value),
      final SchematizedXMLAttributeValue value =>
        _SchematizedXMLAttributeValueRenderer(value: value, results: results, controller: controller, onEdit: onEdit),
      final StatementAttributeValue value => _StatementAttributeValueRenderer(value: value, results: results, controller: controller, onEdit: onEdit),
      _ => _StringIdentityAttributeRenderer(value: value, results: results, controller: controller, onEdit: onEdit),
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
        const Text('Affiliation'),
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
        const Text('BirthDate'),
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
        const Text('BirthPlace'),
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
        const Text('DeliveryBoxAddress'),
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
        const Text('PersonName'),
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
  final List<IdentityAttributeDVO> results;
  final PostOfficeBoxAddressAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _PostOfficeBoxAddressAttributeValueRenderer({required this.value, required this.results, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ComplexAttributeListTile(
      titles: value.state != null
          ? ['Empfänger', 'Postfach', 'Postleitzahl', 'Stadt', 'Land', 'Bundesland']
          : ['Empfänger', 'Postfach', 'Postleitzahl', 'Stadt', 'Land'],
      subTitles: value.state != null
          ? [value.recipient, value.boxId, value.zipCode, value.city, value.country, value.state!]
          : [value.recipient, value.boxId, value.zipCode, value.city, value.country],
      trailing: IconButton(onPressed: () => onEdit!(), icon: const Icon(Icons.edit, color: Colors.blue)),
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
        const Text('StreetAddress'),
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
  final List<IdentityAttributeDVO> results;
  final SchematizedXMLAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _SchematizedXMLAttributeValueRenderer({required this.value, required this.results, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('SchematizedXML'),
        Text(value.value),
        if (value.schemaURL != null) Text(value.schemaURL!),
      ],
    );
  }
}

// TODO properly implement this asap when the class is implemented
class _StatementAttributeValueRenderer extends StatelessWidget {
  final List<IdentityAttributeDVO> results;
  final StatementAttributeValue value;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const _StatementAttributeValueRenderer({required this.value, required this.results, required this.controller, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: results.first.name,
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
