import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

class RelationshipAttributeRendererExample extends StatelessWidget {
  const RelationshipAttributeRendererExample({super.key});

  @override
  Widget build(BuildContext context) {
    final listOfAttributeValues = <AttributeValue>[];

    listOfAttributeValues.add(const ConsentAttributeValue(consent: 'My Consent Example 2'));
    listOfAttributeValues.add(const ProprietaryBooleanAttributeValue(title: 'ProprietaryBoolean Title', value: true));
    listOfAttributeValues.add(const ProprietaryFloatAttributeValue(title: 'ProprietaryFloat Title', value: 4.2));
    listOfAttributeValues.add(const ProprietaryIntegerAttributeValue(title: 'ProprietaryInteger Title', value: 4));
    listOfAttributeValues.add(const ProprietaryJSONAttributeValue(title: 'ProprietaryJSON Title', value: {'jsonKey': 'jsonValue'}));
    listOfAttributeValues.add(const ProprietaryXMLAttributeValue(title: 'ProprietaryXML Title', value: '<XML Example>'));

    listOfAttributeValues.add(const ProprietaryCountryAttributeValue(title: 'ProprietaryCountry Title', value: 'DE'));
    listOfAttributeValues.add(const ProprietaryEMailAddressAttributeValue(title: 'ProprietaryEMailAddress Title', value: 'email@example.com'));
    listOfAttributeValues.add(const ProprietaryFileReferenceAttributeValue(
      title: 'ProprietaryFileReference Title',
      value: 'File',
      description: 'File description',
    ));
    listOfAttributeValues.add(const ProprietaryHEXColorAttributeValue(title: 'ProprietaryHEXColor Title', value: '#0000FF'));
    listOfAttributeValues.add(const ProprietaryLanguageAttributeValue(title: 'ProprietaryLanguage Title', value: 'de'));
    listOfAttributeValues.add(const ProprietaryPhoneNumberAttributeValue(title: 'ProprietaryPhoneNumber Title', value: '1234'));
    listOfAttributeValues.add(const ProprietaryStringAttributeValue(title: 'ProprietaryString Title', value: 'String'));
    listOfAttributeValues.add(const ProprietaryURLAttributeValue(title: 'ProprietaryURL Title', value: 'http://example.com'));

    final List<RepositoryAttributeDVO> listOfAttributes = [];
    for (final attributeValue in listOfAttributeValues) {
      listOfAttributes.add(RepositoryAttributeDVO(
        id: 'id',
        name: 'name',
        content: RelationshipAttribute(
          key: 'key',
          confidentiality: RelationshipAttributeConfidentiality.public,
          owner: 'owner',
          value: attributeValue as RelationshipAttributeValue,
        ),
        owner: '',
        tags: [],
        value: attributeValue,
        valueType: 'valueType',
        renderHints: RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex, propertyHints: {
          'role': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
          'organization': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
          'unit': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
        }),
        valueHints: const ValueHints(),
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
          return AttributeRenderer.localAttribute(attribute: attribute);
        },
      ),
    );
  }
}
