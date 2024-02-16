import 'dart:convert';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:value_renderer/value_renderer.dart';

class InputExamples extends StatefulWidget {
  const InputExamples({super.key});

  @override
  State<InputExamples> createState() => _InputExamplesState();
}

class _InputExamplesState extends State<InputExamples> {
  Map<String, dynamic>? _valuehintsJsonData;
  Map<String, dynamic>? _renderhintsJsonData;

  @override
  void initState() {
    _loadJsonData();

    super.initState();
  }

  Future<void> _loadJsonData() async {
    final valuehintsJsonData = await rootBundle.loadString('assets/valuehints.json');
    final renderhintsJsonData = await rootBundle.loadString('assets/renderhints.json');

    setState(() {
      _valuehintsJsonData = jsonDecode(valuehintsJsonData);
      _renderhintsJsonData = jsonDecode(renderhintsJsonData);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_valuehintsJsonData == null || _renderhintsJsonData == null) return const CircularProgressIndicator();
    final renderHints = RenderHints.fromJson(_renderhintsJsonData!);
    final valueHints = ValueHints.fromJson(_valuehintsJsonData!);

    return SingleChildScrollView(
      child: Column(
        children: [
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
                        const Divider(color: Colors.blue, thickness: 1.0),
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const Divider(color: Colors.blue, thickness: 1.0),
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                          'Integer',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                        const Divider(color: Colors.blue, thickness: 1.0),
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.InputLike,
                            technicalType: RenderHintsTechnicalType.Integer,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            propertyHints: {},
                            pattern: r'^\d+$',
                          ),
                          fieldName: 'Integer / InputLike',
                          initialValue: const FullyDynamicAttributeValue(1),
                        ),
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.InputLike,
                            technicalType: RenderHintsTechnicalType.Integer,
                          ),
                          valueHints: const ValueHints(
                            min: 1,
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
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
                          'Double',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                        const Divider(
                          color: Colors.blue,
                          thickness: 1.0,
                        ),
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.InputLike,
                            technicalType: RenderHintsTechnicalType.Float,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            propertyHints: {},
                            pattern: r'^\d+(\.\d{1,2})?$',
                          ),
                          fieldName: 'Double / InputLike',
                          initialValue: const FullyDynamicAttributeValue(1.5),
                        ),
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.InputLike,
                            technicalType: RenderHintsTechnicalType.Float,
                          ),
                          valueHints: const ValueHints(
                            min: 1,
                            max: 100,
                            propertyHints: {},
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueNum(1.2), displayName: '1.2'),
                              ValueHintsValue(key: ValueHintsDefaultValueNum(2.2), displayName: '2.2')
                            ],
                          ),
                          fieldName: 'Double / InputLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue(1.2),
                        ),
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SelectLike,
                            technicalType: RenderHintsTechnicalType.Float,
                          ),
                          valueHints: const ValueHints(
                            propertyHints: {},
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueNum(1.2), displayName: '1.2'),
                              ValueHintsValue(key: ValueHintsDefaultValueNum(2.2), displayName: '2.2'),
                              ValueHintsValue(key: ValueHintsDefaultValueNum(3.2), displayName: '3.2')
                            ],
                          ),
                          fieldName: 'Double / SelectLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue(1.2),
                        ),
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SelectLike,
                            technicalType: RenderHintsTechnicalType.Float,
                          ),
                          valueHints: const ValueHints(
                            max: 5,
                            min: 1,
                            propertyHints: {},
                          ),
                          fieldName: 'Double / SelectLike',
                          initialValue: const FullyDynamicAttributeValue(1.5),
                        ),
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.ButtonLike,
                            technicalType: RenderHintsTechnicalType.Float,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            propertyHints: {},
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueNum(1.5), displayName: '1.5'),
                              ValueHintsValue(key: ValueHintsDefaultValueNum(2.5), displayName: '2.5'),
                            ],
                          ),
                          fieldName: 'Double / ButtonLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue(1.5),
                        ),
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.ButtonLike,
                            technicalType: RenderHintsTechnicalType.Float,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            propertyHints: {},
                          ),
                          fieldName: 'Double / ButtonLike',
                          initialValue: const FullyDynamicAttributeValue(1.5),
                        ),
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SliderLike,
                            technicalType: RenderHintsTechnicalType.Float,
                          ),
                          valueHints: const ValueHints(
                            propertyHints: {},
                            values: [
                              ValueHintsValue(key: ValueHintsDefaultValueNum(1.5), displayName: '1.5'),
                              ValueHintsValue(key: ValueHintsDefaultValueNum(2.5), displayName: '2.5'),
                              ValueHintsValue(key: ValueHintsDefaultValueNum(3.5), displayName: '3.5'),
                            ],
                          ),
                          fieldName: 'Double / SliderLike / ValueHints.Values',
                          initialValue: const FullyDynamicAttributeValue(1.5),
                        ),
                        const SizedBox(height: 12),
                        ValueRenderer(
                          valueType: '',
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SliderLike,
                            technicalType: RenderHintsTechnicalType.Float,
                          ),
                          valueHints: const ValueHints(
                            max: 10,
                            min: 0,
                            propertyHints: {},
                          ),
                          fieldName: 'Double / SliderLike',
                          initialValue: const FullyDynamicAttributeValue(7.5),
                        ),
                        const Divider(),
                        ValueRenderer(
                          renderHints: renderHints,
                          valueHints: valueHints,
                          valueType: 'DeliveryBoxAddress',
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

  const FullyDynamicAttributeValue(this.value) : super('FullyDynamic');

  @override
  Map<String, dynamic> toJson() => {'value': value};

  @override
  List<Object?> get props => [value];
}
