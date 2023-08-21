import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

class Renderer extends StatelessWidget {
  const Renderer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Shared Attributes',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              ValueRenderer(
                renderHints: RenderHints(
                  editType: RenderHintsEditType.InputLike,
                  technicalType: RenderHintsTechnicalType.String,
                ),
                valueHints: const ValueHints(
                  max: 100,
                ),
                initialValue: const DisplayNameAttributeValue(value: 'Gymnasium Hugendubel'),
                fieldName: 'DisplayName',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Requested Attributes',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              ValueRenderer(
                renderHints: RenderHints(
                  editType: RenderHintsEditType.InputLike,
                  technicalType: RenderHintsTechnicalType.String,
                ),
                valueHints: const ValueHints(
                  max: 100,
                ),
                initialValue: const GivenNameAttributeValue(value: 'Barbara'),
                fieldName: 'GivenName',
              ),
              ValueRenderer(
                renderHints: RenderHints(
                  editType: RenderHintsEditType.InputLike,
                  technicalType: RenderHintsTechnicalType.String,
                ),
                valueHints: const ValueHints(
                  max: 100,
                ),
                initialValue: const SurnameAttributeValue(value: 'Elsner'),
                fieldName: 'Surname',
              ),
              ValueRenderer(
                renderHints: RenderHints(editType: RenderHintsEditType.SelectLike, technicalType: RenderHintsTechnicalType.String),
                valueHints: const ValueHints(
                  values: [
                    ValueHintsValue(key: ValueHintsDefaultValueString('AF'), displayName: 'i18n://attributes.values.countries.AF'),
                    ValueHintsValue(key: ValueHintsDefaultValueString('AL'), displayName: 'i18n://attributes.values.countries.AL'),
                    ValueHintsValue(key: ValueHintsDefaultValueString('DE'), displayName: 'i18n://attributes.values.countries.DE'),
                  ],
                  max: 2,
                  min: 2,
                ),
                initialValue: const NationalityAttributeValue(value: 'DE'),
                fieldName: 'Nationality',
              ),
              ValueRenderer(
                renderHints: RenderHints(
                  dataType: RenderHintsDataType.Language,
                  editType: RenderHintsEditType.SelectLike,
                  technicalType: RenderHintsTechnicalType.String,
                ),
                valueHints: const ValueHints(
                  max: 2,
                  min: 2,
                  values: [
                    ValueHintsValue(
                      key: ValueHintsDefaultValueString('aa'),
                      displayName: 'i18n://attributes.values.languages.aa',
                    ),
                    ValueHintsValue(
                      key: ValueHintsDefaultValueString('ab'),
                      displayName: 'i18n://attributes.values.languages.ab',
                    ),
                    ValueHintsValue(
                      key: ValueHintsDefaultValueString('de'),
                      displayName: 'i18n://attributes.values.languages.de',
                    ),
                  ],
                ),
                initialValue: const CommunicationLanguageAttributeValue(value: 'de'),
                fieldName: 'CommunicationLanguage',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueRenderer(
            renderHints: RenderHints(
              editType: RenderHintsEditType.Complex,
              propertyHints: {
                'day': RenderHints(
                  dataType: RenderHintsDataType.Day,
                  editType: RenderHintsEditType.SelectLike,
                  technicalType: RenderHintsTechnicalType.Integer,
                ),
                'month': RenderHints(
                  dataType: RenderHintsDataType.Month,
                  editType: RenderHintsEditType.SelectLike,
                  technicalType: RenderHintsTechnicalType.Integer,
                ),
                'year': RenderHints(
                  dataType: RenderHintsDataType.Year,
                  editType: RenderHintsEditType.SelectLike,
                  technicalType: RenderHintsTechnicalType.Integer,
                ),
              },
              technicalType: RenderHintsTechnicalType.Object,
            ),
            valueHints: const ValueHints(
              propertyHints: {
                'day': ValueHints(
                  max: 31,
                  min: 1,
                ),
                'month': ValueHints(
                  editHelp: 'i18n://yourBirthMonth',
                  max: 12,
                  min: 1,
                ),
                'year': ValueHints(
                  max: 9999,
                  min: 1,
                ),
              },
            ),
            initialValue: const BirthDateAttributeValue(day: 12, month: 8, year: 2022),
            fieldName: 'BirthDate',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueRenderer(
            renderHints: RenderHints(
              dataType: RenderHintsDataType.EMailAddress,
              editType: RenderHintsEditType.InputLike,
              technicalType: RenderHintsTechnicalType.String,
            ),
            valueHints: const ValueHints(
              max: 100,
              min: 3,
              pattern: r'^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$',
            ),
            initialValue: const EMailAddressAttributeValue(value: 'barbara.elsner222@privat.de'),
            fieldName: 'EMailAddress',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueRenderer(
            renderHints: RenderHints(
              editType: RenderHintsEditType.ButtonLike,
              technicalType: RenderHintsTechnicalType.String,
            ),
            valueHints: const ValueHints(
              max: 100,
              values: [
                ValueHintsValue(key: ValueHintsDefaultValueString('intersex'), displayName: 'i18n://attributes.values.sex.intersex'),
                ValueHintsValue(key: ValueHintsDefaultValueString('female'), displayName: 'i18n://attributes.values.sex.female'),
                ValueHintsValue(key: ValueHintsDefaultValueString('male'), displayName: 'i18n://attributes.values.sex.male'),
              ],
            ),
            initialValue: const SexAttributeValue(value: 'female'),
            fieldName: 'Sex',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueRenderer(
            renderHints: RenderHints(
              editType: RenderHintsEditType.Complex,
              propertyHints: {
                'recipient': RenderHints(
                  editType: RenderHintsEditType.InputLike,
                  technicalType: RenderHintsTechnicalType.String,
                ),
                'street': RenderHints(
                  editType: RenderHintsEditType.InputLike,
                  technicalType: RenderHintsTechnicalType.String,
                ),
                'houseNo': RenderHints(
                  editType: RenderHintsEditType.InputLike,
                  technicalType: RenderHintsTechnicalType.String,
                ),
                'zipCode': RenderHints(
                  editType: RenderHintsEditType.InputLike,
                  technicalType: RenderHintsTechnicalType.String,
                ),
                'city': RenderHints(
                  editType: RenderHintsEditType.InputLike,
                  technicalType: RenderHintsTechnicalType.String,
                ),
                'country': RenderHints(
                  dataType: RenderHintsDataType.Country,
                  editType: RenderHintsEditType.SelectLike,
                  technicalType: RenderHintsTechnicalType.String,
                ),
                'state': RenderHints(
                  editType: RenderHintsEditType.InputLike,
                  technicalType: RenderHintsTechnicalType.String,
                ),
              },
              technicalType: RenderHintsTechnicalType.Object,
            ),
            valueHints: const ValueHints(
              propertyHints: {
                'recipient': ValueHints(max: 100),
                'street': ValueHints(max: 100),
                'houseNo': ValueHints(max: 100),
                'zipCode': ValueHints(max: 100),
                'city': ValueHints(max: 100),
                'country': ValueHints(
                  max: 2,
                  min: 2,
                  values: [
                    ValueHintsValue(key: ValueHintsDefaultValueString('AF'), displayName: 'i18n://attributes.values.countries.AF'),
                    ValueHintsValue(key: ValueHintsDefaultValueString('AL'), displayName: 'i18n://attributes.values.countries.AL'),
                    ValueHintsValue(key: ValueHintsDefaultValueString('DE'), displayName: 'i18n://attributes.values.countries.DE'),
                  ],
                ),
                'state': ValueHints(max: 100),
              },
            ),
            initialValue: const StreetAddressAttributeValue(
              city: 'Aachen',
              country: 'DE',
              houseNumber: '3',
              recipient: 'Familie Elsner',
              street: 'Mittelstraße',
              zipCode: '52062',
            ),
            fieldName: 'StreetAddress',
          ),
        ),
      ]),
    );
  }
}
