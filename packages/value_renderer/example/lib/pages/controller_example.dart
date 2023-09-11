import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

import '../widgets/widgets.dart';

class ControllerExample extends StatefulWidget {
  const ControllerExample({super.key});

  @override
  State<ControllerExample> createState() => _ControllerExampleState();
}

class _ControllerExampleState extends State<ControllerExample> {
  // ValueRendererController textInputController = ValueRendererController();
  late final Controllers controllers;

  String? textInputValue;
  ValueHintsDefaultValueNum? integerInputValue;
  ValueHintsDefaultValueNum? doubleInputValue;
  ValueHintsDefaultValueNum? integerSliderInputValue;
  ValueHintsDefaultValueNum? doubleSliderInputValue;
  ValueHintsDefaultValueString? stringDropdownInputValue;
  ValueHintsDefaultValueNum? integerDropdownInputValue;
  ValueHintsDefaultValueNum? doubleDropdownInputValue;
  ValueHintsDefaultValueBool? booleanDropdownInputValue;
  ValueHintsDefaultValueString? stringSegmentedInputValue;
  ValueHintsDefaultValueNum? integerSegmentedInputValue;
  ValueHintsDefaultValueNum? doubleSegmentedInputValue;
  ValueHintsDefaultValueBool? booleanSegmentedInputValue;
  ValueHintsDefaultValueString? stringRadioInputValue;
  ValueHintsDefaultValueNum? integerRadioInputValue;
  ValueHintsDefaultValueNum? doubleRadioInputValue;
  ValueHintsDefaultValueBool? booleanRadioInputValue;
  bool? switchInputValue;
  bool? checkboxInputValue;
  dynamic datepickerInputValue;
  dynamic complexInputValue;

  @override
  void initState() {
    super.initState();

    controllers = Controllers(
      onTextInputValueChanged: (value) => setState(() => textInputValue = value),
      onIntegerInputValueChanged: (value) => setState(() => integerInputValue = value),
      onDoubleInputValueChanged: (value) => setState(() => doubleInputValue = value),
      onIntegerSliderInputValueChanged: (value) => setState(() => integerSliderInputValue = value),
      onDoubleSliderInputValueChanged: (value) => setState(() => doubleSliderInputValue = value),
      onStringDropdownInputValueChanged: (value) => setState(() => stringDropdownInputValue = value),
      onIntegerDropdownInputValueChanged: (value) => setState(() => integerDropdownInputValue = value),
      onDoubleDropdownInputValueChanged: (value) => setState(() => doubleDropdownInputValue = value),
      onBooleanDropdownInputValueChanged: (value) => setState(() => booleanDropdownInputValue = value),
      onStringSegmentedInputValueChanged: (value) => setState(() => stringSegmentedInputValue = value),
      onIntegerSegmentedInputValueChanged: (value) => setState(() => integerSegmentedInputValue = value),
      onDoubleSegmentedInputValueChanged: (value) => setState(() => doubleSegmentedInputValue = value),
      onBooleanSegmentedInputValueChanged: (value) => setState(() => booleanSegmentedInputValue = value),
      onStringRadioInputValueChanged: (value) => setState(() => stringRadioInputValue = value),
      onIntegerRadioInputValueChanged: (value) => setState(() => integerRadioInputValue = value),
      onDoubleRadioInputValueChanged: (value) => setState(() => doubleRadioInputValue = value),
      onBooleanRadioInputValueChanged: (value) => setState(() => booleanRadioInputValue = value),
      onSwitchInputValueChanged: (value) => setState(() => switchInputValue = value),
      onCheckboxInputValueChanged: (value) => setState(() => checkboxInputValue = value),
      onDatepickerInputValueChanged: (value) => setState(() => datepickerInputValue = value),
      onComplexInputValueChanged: (value) => setState(() => complexInputValue = value),
    );
  }

  @override
  void dispose() {
    controllers.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        Column(
                          children: [
                            ValueRenderer(
                              renderHints: RenderHints(
                                editType: RenderHintsEditType.InputLike,
                                technicalType: RenderHintsTechnicalType.String,
                              ),
                              valueHints: const ValueHints(
                                max: 100,
                              ),
                              fieldName: 'Text Input',
                              initialValue: const FullyDynamicAttributeValue('Text'),
                              controller: controllers.textInputController,
                            ),
                            ControllerDataText(controllerData: textInputValue.toString()),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              controller: controllers.stringDropdownInputController,
                            ),
                            ControllerDataText(controllerData: stringDropdownInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
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
                              controller: controllers.stringRadioInputController,
                            ),
                            ControllerDataText(controllerData: stringRadioInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
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
                              controller: controllers.stringSegmentedInputController,
                            ),
                            ControllerDataText(controllerData: stringSegmentedInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
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
                        Column(
                          children: [
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
                              fieldName: 'Boolean Dropdown',
                              initialValue: const FullyDynamicAttributeValue(true),
                              controller: controllers.booleanDropdownInputController,
                            ),
                            ControllerDataText(controllerData: booleanDropdownInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
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
                              controller: controllers.booleanRadioInputController,
                            ),
                            ControllerDataText(controllerData: booleanRadioInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
                              renderHints: RenderHints(
                                editType: RenderHintsEditType.ButtonLike,
                                technicalType: RenderHintsTechnicalType.Boolean,
                              ),
                              valueHints: const ValueHints(
                                max: 100,
                              ),
                              fieldName: 'Checkbox',
                              initialValue: const FullyDynamicAttributeValue(false),
                              controller: controllers.checkboxInputController,
                            ),
                            ControllerDataText(controllerData: checkboxInputValue?.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
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
                              controller: controllers.switchInputController,
                            ),
                            ControllerDataText(controllerData: switchInputValue?.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
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
                              controller: controllers.booleanSegmentedInputController,
                            ),
                            ControllerDataText(controllerData: booleanSegmentedInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
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
                        Column(
                          children: [
                            ValueRenderer(
                              renderHints: RenderHints(
                                editType: RenderHintsEditType.InputLike,
                                technicalType: RenderHintsTechnicalType.Integer,
                              ),
                              valueHints: const ValueHints(
                                max: 100,
                                propertyHints: {},
                                pattern: r'^\d+$',
                              ),
                              fieldName: 'Number Input',
                              initialValue: const FullyDynamicAttributeValue(1),
                              controller: controllers.integerInputController,
                            ),
                            ControllerDataText(controllerData: integerInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
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
                              controller: controllers.integerDropdownInputController,
                            ),
                            ControllerDataText(controllerData: integerDropdownInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
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
                              controller: controllers.datepickerInputController,
                            ),
                            ControllerDataText(controllerData: datepickerInputValue?.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
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
                              controller: controllers.integerRadioInputController,
                            ),
                            ControllerDataText(controllerData: integerRadioInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
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
                              controller: controllers.integerSegmentedInputController,
                            ),
                            ControllerDataText(controllerData: integerSegmentedInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
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
                              controller: controllers.integerSliderInputController,
                            ),
                            ControllerDataText(controllerData: integerSliderInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
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
                        Column(
                          children: [
                            ValueRenderer(
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
                              controller: controllers.doubleInputController,
                            ),
                            ControllerDataText(controllerData: doubleInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
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
                              controller: controllers.doubleDropdownInputController,
                            ),
                            ControllerDataText(controllerData: doubleDropdownInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
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
                              controller: controllers.doubleRadioInputController,
                            ),
                            ControllerDataText(controllerData: doubleRadioInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
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
                              controller: controllers.doubleSegmentedInputController,
                            ),
                            ControllerDataText(controllerData: doubleSegmentedInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
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
                              controller: controllers.doubleSliderInputController,
                            ),
                            ControllerDataText(controllerData: doubleSliderInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
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
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      const Text(
                        'Complex',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                      const Divider(
                        color: Colors.blue,
                        thickness: 1.0,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ValueRenderer(
                              fieldName: 'StreetAddress',
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
                              controller: controllers.complexInputController,
                            ),
                          ),
                          ControllerDataText(
                            controllerData: complexInputValue?.entries
                                    .map(
                                      (entry) =>
                                          '${entry.key}: ${entry.value is ValueHintsDefaultValue ? (entry.value as ValueHintsDefaultValue).toJson() : entry.value}',
                                    )
                                    .join('\n') ??
                                'null',
                          ),
                        ],
                      ),
                    ]),
                  ),
                )
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
