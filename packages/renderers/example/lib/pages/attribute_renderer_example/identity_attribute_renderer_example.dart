import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

class IdentityAttributeRendererExample extends StatelessWidget {
  const IdentityAttributeRendererExample({super.key});

  @override
  Widget build(BuildContext context) {
    final listOfAttributeValues = <AttributeValue>[];
    listOfAttributeValues.add(const AffiliationAttributeValue(role: 'a Role', organization: 'an Organization', unit: 'an Unit'));
    listOfAttributeValues.add(const BirthDateAttributeValue(day: 1, month: 1, year: 2000));
    listOfAttributeValues.add(const BirthPlaceAttributeValue(city: 'Hamburg', country: 'Germany'));
    listOfAttributeValues.add(const SchematizedXMLAttributeValue(value: 'XML'));
    listOfAttributeValues.add(const StatementAttributeValue(json: {'statement': 'value'}));
    listOfAttributeValues.add(const AffiliationOrganizationAttributeValue(value: 'an affiliation organiztion'));
    listOfAttributeValues.add(const AffiliationRoleAttributeValue(value: 'an affiliation role'));
    listOfAttributeValues.add(const AffiliationUnitAttributeValue(value: 'an affiliation unit'));
    listOfAttributeValues.add(const BirthCityAttributeValue(value: 'Heidelberg'));
    listOfAttributeValues.add(const BirthNameAttributeValue(value: 'Mustermann'));
    listOfAttributeValues.add(const BirthStateAttributeValue(value: 'a birth state'));
    listOfAttributeValues.add(const CityAttributeValue(value: 'Mannheim'));
    listOfAttributeValues.add(const DisplayNameAttributeValue(value: 'a display name'));
    listOfAttributeValues.add(const IdentityFileReferenceAttributeValue(value: 'a file reference'));
    listOfAttributeValues.add(const HonorificPrefixAttributeValue(value: 'a honorific prefix'));
    listOfAttributeValues.add(const HonorificSuffixAttributeValue(value: 'a honorific suffix'));
    listOfAttributeValues.add(const HouseNumberAttributeValue(value: '42'));
    listOfAttributeValues.add(const JobTitleAttributeValue(value: 'Software Engineer'));
    listOfAttributeValues.add(const MiddleNameAttributeValue(value: 'a middle name'));
    listOfAttributeValues.add(const PhoneNumberAttributeValue(value: '+498795268415'));
    listOfAttributeValues.add(const PseudonymAttributeValue(value: 'a pseudonym'));
    listOfAttributeValues.add(const StateAttributeValue(value: 'Germany'));
    listOfAttributeValues.add(const StreetAttributeValue(value: 'a street'));
    listOfAttributeValues.add(const SurnameAttributeValue(value: 'Mustermann'));
    listOfAttributeValues.add(const ZipCodeAttributeValue(value: '87629'));
    listOfAttributeValues.add(const BirthDayAttributeValue(value: 25));
    listOfAttributeValues.add(const BirthMonthAttributeValue(value: 12));
    listOfAttributeValues.add(const BirthYearAttributeValue(value: 1990));
    listOfAttributeValues.add(const CitizenshipAttributeValue(value: 'Germany'));
    listOfAttributeValues.add(const CommunicationLanguageAttributeValue(value: 'German'));
    listOfAttributeValues.add(const CountryAttributeValue(value: 'Germany'));
    listOfAttributeValues.add(const EMailAddressAttributeValue(value: 'example@example.com'));
    listOfAttributeValues.add(const FaxNumberAttributeValue(value: '+498795268415'));
    listOfAttributeValues.add(const NationalityAttributeValue(value: 'Germany'));
    listOfAttributeValues.add(const SexAttributeValue(value: 'Male'));
    listOfAttributeValues.add(const WebsiteAttributeValue(value: 'https://example.com'));

    final List<RepositoryAttributeDVO> listOfAttributes = [];
    for (final attributeValue in listOfAttributeValues) {
      listOfAttributes.add(RepositoryAttributeDVO(
        id: 'id',
        name: 'name',
        content: IdentityAttribute(owner: 'owner', value: attributeValue as IdentityAttributeValue),
        owner: '',
        tags: [],
        value: attributeValue,
        valueType: 'valueType',
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex, propertyHints: {
          'role': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
          'organization': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
          'unit': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        }),
        valueHints: const ValueHints(
          propertyHints: {
            'testKey': ValueHints(),
            'testKey2': ValueHints(),
            'testKey3': ValueHints(),
            'testKey4': ValueHints(),
            'country': ValueHints(),
            'state': ValueHints(),
          },
        ),
        isDraft: false,
        isValid: true,
        createdAt: 'createdAt',
        sharedWith: [],
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: listOfAttributes.length,
        itemBuilder: (context, index) {
          final attribute = listOfAttributes[index];
          return AttributeRenderer.localAttribute(
            attribute: attribute,
            expandFileReference: (_) async => throw Exception('Not implemented'),
          );
        },
      ),
    );
  }
}
