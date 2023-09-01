import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

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
  ValueRendererController switchInputController = ValueRendererController();

  dynamic textInputValue;
  dynamic numberInputValue;
  ValueHintsDefaultValueString? radioInputValue;
  bool? checkboxInputValue;
  ValueHintsDefaultValueString? dropdownInputValue;
  ValueHintsDefaultValueString? segmentedButtonInputValue;
  double? sliderInputValue;
  bool? switchInputValue;

  @override
  void initState() {
    super.initState();

    textInputController.addListener(() => setState(() => textInputValue = textInputController.value));
    numberInputController.addListener(() => setState(() => numberInputValue = numberInputController.value));
    radioInputController.addListener(() => setState(() => radioInputValue = radioInputController.value));
    checkboxInputController.addListener(() => setState(() => checkboxInputValue = checkboxInputController.value));
    dropdownInputController.addListener(() => setState(() => dropdownInputValue = dropdownInputController.value));
    segmentedButtonInputController.addListener(() => setState(() => segmentedButtonInputValue = segmentedButtonInputController.value));
    sliderInputController.addListener(() => setState(() => sliderInputValue = sliderInputController.value));
    switchInputController.addListener(() => setState(() => switchInputValue = switchInputController.value));
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  controller: textInputController,
                ),
                Text(textInputValue.toString()),
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
                Text(numberInputValue.toString()),
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
                  controller: radioInputController,
                ),
                Text(radioInputValue?.value ?? ''),
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
                Text(checkboxInputValue.toString()),
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
                Text(dropdownInputValue?.value ?? ''),
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
                Text(segmentedButtonInputValue?.value ?? ''),
              ],
            ),
            Column(
              children: [
                ValueRenderer(
                  fieldName: 'Slider Input',
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
                Text(sliderInputValue.toString()),
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
                Text(switchInputValue.toString()),
              ],
            ),
          ],
        ),
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
