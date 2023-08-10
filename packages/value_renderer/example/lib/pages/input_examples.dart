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
                          initialValue: const {'@type': 'String / InputLike', 'value': ''},
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
                              ValueHintsValue(key: 'Option 1', displayName: ''),
                              ValueHintsValue(key: 'Option 2', displayName: ''),
                              ValueHintsValue(key: 'Option 3', displayName: ''),
                            ],
                          ),
                          initialValue: const {'@type': 'String / SelectLike', 'value': 'Option 1'},
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
                          initialValue: const {
                            '@type': 'BirthDate',
                            'day': 12,
                            'month': 8,
                            'year': 2022,
                          },
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.ButtonLike,
                            technicalType: RenderHintsTechnicalType.String,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            values: [
                              ValueHintsValue(key: 'Option 1', displayName: ''),
                              ValueHintsValue(key: 'Option 2', displayName: ''),
                            ],
                          ),
                          initialValue: const {'@type': 'String / ButtonLike', 'value': 'Option 1'},
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
                              ValueHintsValue(key: 'Option 1', displayName: ''),
                              ValueHintsValue(key: 'Option 2', displayName: ''),
                              ValueHintsValue(key: 'Option 3', displayName: ''),
                            ],
                          ),
                          initialValue: const {'@type': 'String / SliderLike / ValueHint.Values', 'value': 'Option 1'},
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
                              ValueHintsValue(key: 'Option 1', displayName: ''),
                              ValueHintsValue(key: 'Option 2', displayName: ''),
                            ],
                          ),
                          initialValue: const {'@type': 'Boolean / SelectLike', 'value': 'Option 1'},
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.ButtonLike,
                            technicalType: RenderHintsTechnicalType.Boolean,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            values: [
                              ValueHintsValue(key: 'Option 1', displayName: ''),
                              ValueHintsValue(key: 'Option 2', displayName: ''),
                              ValueHintsValue(key: 'Option 3', displayName: ''),
                            ],
                          ),
                          initialValue: const {
                            '@type': 'Boolean / ButtonLike / ValueHint.Values',
                            'value': 'Option 1',
                          },
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.ButtonLike,
                            technicalType: RenderHintsTechnicalType.Boolean,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            values: [],
                          ),
                          initialValue: const {'@type': 'Boolean / ButtonLike', 'value': true},
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SliderLike,
                            technicalType: RenderHintsTechnicalType.Boolean,
                          ),
                          valueHints: const ValueHints(
                            propertyHints: {},
                            values: [],
                          ),
                          initialValue: const {'@type': 'Boolean / SliderSlike', 'value': false},
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
                              ValueHintsValue(key: false, displayName: ''),
                              ValueHintsValue(key: true, displayName: ''),
                            ],
                          ),
                          initialValue: const {'@type': 'Boolean / SliderLike / ValueHint.Values', 'value': false},
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
                          initialValue: const {'@type': 'Integer / InputLike', 'value': ''},
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.ButtonLike,
                            technicalType: RenderHintsTechnicalType.Integer,
                          ),
                          valueHints: const ValueHints(
                            max: 100,
                            propertyHints: {},
                            values: [],
                          ),
                          initialValue: const {'@type': 'Integer / ButtonLike / ValueHints.Values', 'value': ''},
                        ),
                        ValueRenderer(
                          renderHints: RenderHints(
                            editType: RenderHintsEditType.SelectLike,
                            technicalType: RenderHintsTechnicalType.Integer,
                          ),
                          valueHints: const ValueHints(
                            propertyHints: {},
                            values: [
                              ValueHintsValue(key: 1, displayName: ''),
                              ValueHintsValue(key: 2, displayName: ''),
                              ValueHintsValue(key: 3, displayName: ''),
                            ],
                          ),
                          initialValue: const {'@type': 'Integer / SelectLike / ValueHints.Values', 'value': 1},
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
                            values: [],
                          ),
                          initialValue: const {'@type': 'Integer / SelectLike', 'value': 5},
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
                          initialValue: const {
                            '@type': 'BirthDate',
                            'day': 12,
                            'month': 8,
                            'year': 2022,
                          },
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
                              ValueHintsValue(key: 1, displayName: ''),
                              ValueHintsValue(key: 2, displayName: ''),
                            ],
                          ),
                          initialValue: const {'@type': 'Integer / ButtonLike', 'value': 1},
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
                              ValueHintsValue(key: 1, displayName: ''),
                              ValueHintsValue(key: 2, displayName: ''),
                              ValueHintsValue(key: 3, displayName: ''),
                            ],
                          ),
                          initialValue: const {'@type': 'Integer / SliderLike / ValueHint.Values', 'value': 1},
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
                            values: [],
                          ),
                          initialValue: const {'@type': 'Integer / SliderLike', 'value': 75},
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
