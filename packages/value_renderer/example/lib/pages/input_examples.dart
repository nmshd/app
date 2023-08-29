import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

class InputExamples extends StatelessWidget {
  const InputExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(228, 255, 255, 255),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'String',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                        const Divider(
                          color: Colors.blue,
                          thickness: 1.0,
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.InputLike,
                            technicalType: RenderHintsTechnicalType.String,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                          ),
                          fieldName: 'String / InputLike',
                          initialValue: const FullyDynamicAttributeValue(''),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.InputLike,
                            technicalType: RenderHintsTechnicalType.String,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueString('Some Value'), displayName: 'Some Value'),
                              ValueHintsValue(key: ValueHintsDefaultValueString('Some Other Value'), displayName: 'Some Other Value'),
                            ],
                          ),
                          fieldName: 'String / InputLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue('Some Value'),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SelectLike,
                            technicalType: RenderHintsTechnicalType.String,
                          ),
                          valueHints: const ValueHints(
                            max: 2,
                            min: 2,
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueString('Option 1'), displayName: 'Option 1'),
                              ValueHintsValue(key: ValueHintsDefaultValueString('Option 2'), displayName: 'Option 2'),
                              ValueHintsValue(key: ValueHintsDefaultValueString('Option 3'), displayName: 'Option 3'),
                            ],
                          ),
                          fieldName: 'String / SelectLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue('Option 1'),
                        ),
                        ValueRenderer(
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
                          fieldName: 'BirthDate',
                          initialValue: const BirthDateAttributeValue(day: 12, month: 8, year: 2022),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.ButtonLike,
                            technicalType: RenderHintsTechnicalType.String,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueString('Option 1'), displayName: 'Option 1'),
                              ValueHintsValue(key: ValueHintsDefaultValueString('Option 2'), displayName: 'Option 2'),
                            ],
                          ),
                          fieldName: 'String / ButtonLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue('Option 1'),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.ButtonLike,
                            technicalType: RenderHintsTechnicalType.String,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                          ),
                          fieldName: 'String / ButtonLike',
                          initialValue: const FullyDynamicAttributeValue(''),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SliderLike,
                            technicalType: RenderHintsTechnicalType.String,
                          ),
                          valueHints: const ValueHints(
                            max: 2,
                            min: 2,
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueString('Option 1'), displayName: 'Option 1'),
                              ValueHintsValue(key: ValueHintsDefaultValueString('Option 2'), displayName: 'Option 2'),
                              ValueHintsValue(key: ValueHintsDefaultValueString('Option 3'), displayName: 'Option 3'),
                            ],
                          ),
                          fieldName: 'String / SliderLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue('Option 1'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(228, 255, 255, 255),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Boolean',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                        const Divider(
                          color: Colors.blue,
                          thickness: 1.0,
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SelectLike,
                            technicalType: RenderHintsTechnicalType.Boolean,
                          ),
                          valueHints: const ValueHints(
                            max: 2,
                            min: 2,
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueBool(true), displayName: 'true'),
                              ValueHintsValue(key: ValueHintsDefaultValueBool(false), displayName: 'false'),
                            ],
                          ),
                          fieldName: 'Boolean / SelectLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue(true),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.ButtonLike,
                            technicalType: RenderHintsTechnicalType.Boolean,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueBool(true), displayName: 'true'),
                              ValueHintsValue(key: ValueHintsDefaultValueBool(false), displayName: 'false'),
                            ],
                          ),
                          fieldName: 'Boolean / ButtonLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue(true),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.ButtonLike,
                            technicalType: RenderHintsTechnicalType.Boolean,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                          ),
                          fieldName: 'Boolean / ButtonLike',
                          initialValue: const FullyDynamicAttributeValue(false),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SliderLike,
                            technicalType: RenderHintsTechnicalType.Boolean,
                          ),
                          valueHints: const ValueHints(
                            propertyHints: {},
                          ),
                          fieldName: 'Boolean / SliderSlike',
                          initialValue: const FullyDynamicAttributeValue(false),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SliderLike,
                            technicalType: RenderHintsTechnicalType.Boolean,
                          ),
                          valueHints: const ValueHints(
                            max: 2,
                            min: 2,
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueBool(false), displayName: 'false'),
                              ValueHintsValue(key: ValueHintsDefaultValueBool(true), displayName: 'true'),
                            ],
                          ),
                          fieldName: 'Boolean / SliderLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue(false),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(228, 255, 255, 255),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Number',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                        const Divider(
                          color: Colors.blue,
                          thickness: 1.0,
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.InputLike,
                            technicalType: RenderHintsTechnicalType.Integer,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            propertyHints: {},
                          ),
                          fieldName: 'Integer / InputLike',
                          initialValue: const FullyDynamicAttributeValue(1),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.InputLike,
                            technicalType: RenderHintsTechnicalType.Integer,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            propertyHints: {},
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueNum(1), displayName: '1'),
                              ValueHintsValue(key: ValueHintsDefaultValueNum(2), displayName: '2')
                            ],
                          ),
                          fieldName: 'Integer / InputLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue(1),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SelectLike,
                            technicalType: RenderHintsTechnicalType.Integer,
                          ),
                          valueHints: const ValueHints(
                            propertyHints: {},
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueNum(1), displayName: '1'),
                              ValueHintsValue(key: ValueHintsDefaultValueNum(2), displayName: '2'),
                              ValueHintsValue(key: ValueHintsDefaultValueNum(3), displayName: '3'),
                            ],
                          ),
                          fieldName: 'Integer / SelectLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue(1),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SelectLike,
                            technicalType: RenderHintsTechnicalType.Integer,
                          ),
                          valueHints: const ValueHints(
                            max: 5,
                            min: 1,
                            propertyHints: {},
                          ),
                          fieldName: 'Integer / SelectLike',
                          initialValue: const FullyDynamicAttributeValue(5),
                        ),
                        ValueRenderer(
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
                                propertyHints: {},
                              ),
                              'month': ValueHints(
                                editHelp: 'i18n://yourBirthMonth',
                                max: 12,
                                min: 1,
                                propertyHints: {},
                              ),
                              'year': ValueHints(
                                max: 9999,
                                min: 1,
                                propertyHints: {},
                              ),
                            },
                          ),
                          fieldName: 'BirthDate',
                          initialValue: const BirthDateAttributeValue(day: 12, month: 8, year: 2022),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.ButtonLike,
                            technicalType: RenderHintsTechnicalType.Integer,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            propertyHints: {},
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueNum(1), displayName: '1'),
                              ValueHintsValue(key: ValueHintsDefaultValueNum(2), displayName: '2'),
                            ],
                          ),
                          fieldName: 'Integer / ButtonLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue(1),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.ButtonLike,
                            technicalType: RenderHintsTechnicalType.Integer,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            propertyHints: {},
                          ),
                          fieldName: 'Integer / ButtonLike',
                          initialValue: const FullyDynamicAttributeValue(0),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SliderLike,
                            technicalType: RenderHintsTechnicalType.Integer,
                          ),
                          valueHints: const ValueHints(
                            max: 2,
                            min: 2,
                            propertyHints: {},
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueNum(1), displayName: '1'),
                              ValueHintsValue(key: ValueHintsDefaultValueNum(2), displayName: '2'),
                              ValueHintsValue(key: ValueHintsDefaultValueNum(3), displayName: '3'),
                            ],
                          ),
                          fieldName: 'Integer / SliderLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue(1),
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SliderLike,
                            technicalType: RenderHintsTechnicalType.Integer,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            min: 0,
                            propertyHints: {},
                          ),
                          fieldName: 'Integer / SliderLike',
                          initialValue: const FullyDynamicAttributeValue(75),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FullyDynamicAttributeValue extends AttributeValue {
  final dynamic value;

  const FullyDynamicAttributeValue(this.value);

  @override
  Map<String, dynamic> toJson() => {'value': value};

  @override
  List<Object?> get props => [value];
}
