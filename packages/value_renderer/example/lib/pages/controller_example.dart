import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

import '../widgets/controller_data_text.dart';

class ControllerExample extends StatefulWidget {
  const ControllerExample({super.key});

  @override
  State<ControllerExample> createState() => _ControllerExampleState();
}

class _ControllerExampleState extends State<ControllerExample> {
  ValueRendererController textInputController = ValueRendererController();
  ValueRendererController numberInputController = ValueRendererController();
  ValueRendererController radioInputController = ValueRendererController();
  ValueRendererController checkboxInputController = ValueRendererController();
  ValueRendererController dropdownInputController = ValueRendererController();
  ValueRendererController segmentedButtonInputController = ValueRendererController();
  ValueRendererController sliderInputController = ValueRendererController();
  ValueRendererController doubleSliderInputController = ValueRendererController();
  ValueRendererController switchInputController = ValueRendererController();
  ValueRendererController datepickerInputController = ValueRendererController();
  ValueRendererController complexInputController = ValueRendererController();

  dynamic textInputValue;
  dynamic numberInputValue;
  ValueHintsDefaultValueString? radioInputValue;
  bool? checkboxInputValue;
  ValueHintsDefaultValueString? dropdownInputValue;
  ValueHintsDefaultValueString? segmentedButtonInputValue;
  ValueHintsDefaultValueNum? sliderInputValue;
  ValueHintsDefaultValueNum? doubleSliderInputValue;
  bool? switchInputValue;
  dynamic datepickerInputValue;
  Map<String, dynamic>? complexInputValue;

  @override
  void initState() {
    super.initState();

    textInputController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => textInputValue = textInputController.value);
      });
    });

    numberInputController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => numberInputValue = numberInputController.value);
      });
    });

    radioInputController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => radioInputValue = radioInputController.value);
      });
    });

    checkboxInputController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => checkboxInputValue = checkboxInputController.value);
      });
    });

    dropdownInputController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => dropdownInputValue = dropdownInputController.value);
      });
    });

    segmentedButtonInputController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => segmentedButtonInputValue = segmentedButtonInputController.value);
      });
    });

    sliderInputController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => sliderInputValue = sliderInputController.value);
      });
    });

    doubleSliderInputController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => doubleSliderInputValue = doubleSliderInputController.value);
      });
    });

    switchInputController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => switchInputValue = switchInputController.value);
      });
    });

    datepickerInputController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => datepickerInputValue = datepickerInputController.value);
      });
    });

    complexInputController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => complexInputValue = complexInputController.value);
      });
    });
  }

  @override
  void dispose() {
    textInputController.dispose();
    numberInputController.dispose();
    radioInputController.dispose();
    checkboxInputController.dispose();
    dropdownInputController.dispose();
    segmentedButtonInputController.dispose();
    sliderInputController.dispose();
    switchInputController.dispose();
    datepickerInputController.dispose();
    complexInputController.dispose();

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
                      children: [
                        Column(
                          children: [
                            ValueRenderer(
                              fieldName: 'Text Input',
                              renderHints: RenderHints(
                                technicalType: RenderHintsTechnicalType.String,
                                editType: RenderHintsEditType.InputLike,
                              ),
                              valueHints: const ValueHints(),
                              initialValue: const FullyDynamicAttributeValue('Text'),
                              controller: textInputController,
                            ),
                            ControllerDataText(controllerData: textInputValue.toString()),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
                              fieldName: 'Number Input',
                              renderHints: RenderHints(
                                editType: RenderHintsEditType.InputLike,
                                technicalType: RenderHintsTechnicalType.Integer,
                              ),
                              valueHints: const ValueHints(),
                              initialValue: const FullyDynamicAttributeValue(1),
                              controller: numberInputController,
                            ),
                            ControllerDataText(controllerData: numberInputValue.toString()),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
                              fieldName: 'Radio Input',
                              renderHints: RenderHints(
                                technicalType: RenderHintsTechnicalType.String,
                                editType: RenderHintsEditType.ButtonLike,
                              ),
                              valueHints: const ValueHints(
                                values: [
                                  ValueHintsValue(key: ValueHintsDefaultValueString('Option 1'), displayName: 'Option 1'),
                                  ValueHintsValue(key: ValueHintsDefaultValueString('Option 2'), displayName: 'Option 2'),
                                ],
                              ),
                              initialValue: const FullyDynamicAttributeValue('Option 1'),
                              controller: radioInputController,
                            ),
                            ControllerDataText(controllerData: radioInputValue?.value ?? ''),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
                              fieldName: 'Checkbox Input',
                              renderHints: RenderHints(
                                editType: RenderHintsEditType.ButtonLike,
                                technicalType: RenderHintsTechnicalType.Boolean,
                              ),
                              valueHints: const ValueHints(
                                max: 100,
                              ),
                              initialValue: const FullyDynamicAttributeValue(false),
                              controller: checkboxInputController,
                            ),
                            ControllerDataText(controllerData: checkboxInputValue.toString()),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
                              fieldName: 'Dropdown Input',
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
                              initialValue: const FullyDynamicAttributeValue('Option 1'),
                              controller: dropdownInputController,
                            ),
                            ControllerDataText(controllerData: dropdownInputValue?.value ?? ''),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
                              fieldName: 'Segmented Button Input',
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
                              initialValue: const FullyDynamicAttributeValue('Option 1'),
                              controller: segmentedButtonInputController,
                            ),
                            ControllerDataText(controllerData: segmentedButtonInputValue?.value ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
                              fieldName: 'Integer Slider Input',
                              renderHints: RenderHints(
                                editType: RenderHintsEditType.SliderLike,
                                technicalType: RenderHintsTechnicalType.Integer,
                              ),
                              valueHints: const ValueHints(
                                max: 100,
                                min: 0,
                                propertyHints: {},
                              ),
                              initialValue: const FullyDynamicAttributeValue(75),
                              controller: sliderInputController,
                            ),
                            ControllerDataText(controllerData: sliderInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
                              fieldName: 'Double Slider Input',
                              renderHints: RenderHints(
                                editType: RenderHintsEditType.SliderLike,
                                technicalType: RenderHintsTechnicalType.Float,
                              ),
                              valueHints: const ValueHints(
                                max: 100,
                                min: 0,
                                propertyHints: {},
                              ),
                              initialValue: const FullyDynamicAttributeValue(7.5),
                              controller: doubleSliderInputController,
                            ),
                            ControllerDataText(controllerData: doubleSliderInputValue?.value.toString() ?? 'null'),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
                              fieldName: 'Switch Input',
                              renderHints: RenderHints(
                                editType: RenderHintsEditType.SliderLike,
                                technicalType: RenderHintsTechnicalType.Boolean,
                              ),
                              valueHints: const ValueHints(
                                propertyHints: {},
                              ),
                              initialValue: const FullyDynamicAttributeValue(false),
                              controller: switchInputController,
                            ),
                            ControllerDataText(controllerData: switchInputValue.toString()),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
                        ),
                        Column(
                          children: [
                            ValueRenderer(
                              fieldName: 'BirthDate',
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
                              initialValue: const BirthDateAttributeValue(day: 12, month: 8, year: 2022),
                              controller: datepickerInputController,
                            ),
                            ControllerDataText(controllerData: datepickerInputValue.toString()),
                            const Divider(color: Colors.black12, thickness: 1.0, indent: 50, endIndent: 50),
                          ],
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
                                        ValueHintsValue(
                                            key: ValueHintsDefaultValueString('AF'), displayName: 'i18n://attributes.values.countries.AF'),
                                        ValueHintsValue(
                                            key: ValueHintsDefaultValueString('AL'), displayName: 'i18n://attributes.values.countries.AL'),
                                        ValueHintsValue(
                                            key: ValueHintsDefaultValueString('DE'), displayName: 'i18n://attributes.values.countries.DE'),
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
                                controller: complexInputController,
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
                        )
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
