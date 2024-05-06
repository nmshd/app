import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../inputs/dropdown_select_input.dart';
import '../../inputs/text_input.dart';
import '../../value_renderer_utils.dart';
import 'extensions.dart';

class PostOfficeBoxAddressRenderer extends StatefulWidget {
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String? translatedText;
  final ValueRendererController? controller;
  final PostOfficeBoxAddressAttributeValue? initialValue;
  final InputDecoration? decoration;

  const PostOfficeBoxAddressRenderer({
    required this.renderHints,
    required this.valueHints,
    this.translatedText,
    this.controller,
    this.initialValue,
    this.decoration,
    super.key,
  });

  @override
  State<PostOfficeBoxAddressRenderer> createState() => _PostOfficeBoxAddressRendererState();
}

class _PostOfficeBoxAddressRendererState extends State<PostOfficeBoxAddressRenderer> {
  static const __valueType = 'PostOfficeBoxAddress';

  ValueRendererInputValueMap? _inputValueMap;

  final Map<String, dynamic> _valueMap = {};
  final _requiredValues = ['recipient', 'boxId', 'zipCode', 'city', 'country'];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onChanged(key: 'recipient', value: widget.initialValue!.recipient);
        _onChanged(key: 'boxId', value: widget.initialValue!.boxId);
        _onChanged(key: 'zipCode', value: widget.initialValue!.zipCode);
        _onChanged(key: 'city', value: widget.initialValue!.city);
        if (widget.initialValue!.state != null) _onChanged(key: 'state', value: widget.initialValue!.state!);
        _onChanged(
          key: 'country',
          value: widget.initialValue!.country.startsWith('dup_') ? widget.initialValue!.country.substring(4) : widget.initialValue!.country,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextInput(
            mustBeFilledOut: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.recipient.toValueHintsDefaultValue(),
            onChanged: (value) => _onChanged(key: 'recipient', value: value),
            values: widget.valueHints.propertyHints!['recipient']!.values,
            pattern: widget.valueHints.propertyHints!['recipient']!.pattern,
            fieldName: context.fieldName(__valueType, 'recipient', _requiredValues),
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.boxId.toValueHintsDefaultValue(),
            onChanged: (value) => _onChanged(key: 'boxId', value: value),
            values: widget.valueHints.propertyHints!['boxId']!.values,
            pattern: widget.valueHints.propertyHints!['boxId']!.pattern,
            fieldName: context.fieldName(__valueType, 'boxId', _requiredValues),
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.zipCode.toValueHintsDefaultValue(),
            onChanged: (value) => _onChanged(key: 'zipCode', value: value),
            values: widget.valueHints.propertyHints!['zipCode']!.values,
            pattern: widget.valueHints.propertyHints!['zipCode']!.pattern,
            fieldName: context.fieldName(__valueType, 'zipCode', _requiredValues),
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.city.toValueHintsDefaultValue(),
            onChanged: (value) => _onChanged(key: 'city', value: value),
            values: widget.valueHints.propertyHints!['city']!.values,
            pattern: widget.valueHints.propertyHints!['city']!.pattern,
            fieldName: context.fieldName(__valueType, 'city', _requiredValues),
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.state.toValueHintsDefaultValue(),
            onChanged: (value) => _onChanged(key: 'state', value: value),
            values: widget.valueHints.propertyHints!['state']!.values,
            pattern: widget.valueHints.propertyHints!['state']!.pattern,
            fieldName: context.fieldName(__valueType, 'state', _requiredValues),
          ),
          const SizedBox(height: 16),
          DropdownSelectInput(
            onChanged: (value) => _onChanged(key: 'country', value: value),
            decoration: widget.decoration,
            mustBeFilledOut: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.country.toValueHintsDefaultValue(),
            technicalType: widget.renderHints.propertyHints!['country']!.technicalType,
            dataType: widget.renderHints.propertyHints!['country']!.dataType,
            values: widget.valueHints.propertyHints!['country']!.values!,
            fieldName: context.fieldName(__valueType, 'country', _requiredValues),
          ),
        ],
      ),
    );
  }

  void _onChanged({required String key, required String value}) {
    if (widget.controller == null) return;

    if (value.isEmpty) {
      _valueMap.remove(key);
    } else {
      _valueMap[key] = ValueRendererInputValueString(value);
      _inputValueMap = ValueRendererInputValueMap(Map<String, dynamic>.from(_valueMap));
    }

    if (!_requiredValues.every((element) => _valueMap.containsKey(element)) || !_formKey.currentState!.validate()) {
      widget.controller!.value = ValueRendererValidationError();

      return;
    }

    widget.controller!.value = _inputValueMap;
  }
}
