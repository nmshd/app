import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../inputs/dropdown_select_input.dart';
import '../../inputs/text_input.dart';
import '../../value_renderer_utils.dart';
import 'extensions.dart';

class StreetAddressRenderer extends StatefulWidget {
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String? fieldName;
  final ValueRendererController? controller;
  final StreetAddressAttributeValue? initialValue;
  final InputDecoration? decoration;

  const StreetAddressRenderer({
    required this.renderHints,
    required this.valueHints,
    this.fieldName,
    this.controller,
    this.initialValue,
    this.decoration,
    super.key,
  });

  @override
  State<StreetAddressRenderer> createState() => _StreetAddressRendererState();
}

class _StreetAddressRendererState extends State<StreetAddressRenderer> {
  static const __valueType = 'StreetAddress';

  ValueRendererInputValueMap? _inputValueMap;

  final Map<String, dynamic> _valueMap = {};
  final _requiredValues = ['recipient', 'street', 'houseNo', 'zipCode', 'city', 'country'];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onChanged(key: 'recipient', value: widget.initialValue!.recipient);
        _onChanged(key: 'street', value: widget.initialValue!.street);
        _onChanged(key: 'houseNo', value: widget.initialValue!.houseNumber);
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
            mustBeFilledOut: _requiredValues.contains('recipient'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.recipient.toValueHintsDefaultValue(),
            onChanged: (value) => _onChanged(key: 'recipient', value: value),
            values: widget.valueHints.propertyHints!['recipient']!.values,
            pattern: widget.valueHints.propertyHints!['recipient']!.pattern,
            fieldName: 'i18n://attributes.values.$__valueType.recipient.label',
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: _requiredValues.contains('street'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.street.toValueHintsDefaultValue(),
            onChanged: (value) => _onChanged(key: 'street', value: value),
            values: widget.valueHints.propertyHints!['street']!.values,
            pattern: widget.valueHints.propertyHints!['street']!.pattern,
            fieldName: 'i18n://attributes.values.$__valueType.street.label',
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: _requiredValues.contains('houseNo'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.houseNumber.toValueHintsDefaultValue(),
            onChanged: (value) => _onChanged(key: 'houseNo', value: value),
            values: widget.valueHints.propertyHints!['houseNo']!.values,
            pattern: widget.valueHints.propertyHints!['houseNo']!.pattern,
            formatValidations: const {r'\d': 'errors.value_renderer.houseNoNumericCharacter'},
            fieldName: 'i18n://attributes.values.$__valueType.houseNo.label',
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: _requiredValues.contains('zipCode'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.zipCode.toValueHintsDefaultValue(),
            onChanged: (value) => _onChanged(key: 'zipCode', value: value),
            values: widget.valueHints.propertyHints!['zipCode']!.values,
            pattern: widget.valueHints.propertyHints!['zipCode']!.pattern,
            fieldName: 'i18n://attributes.values.$__valueType.zipCode.label',
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: _requiredValues.contains('city'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.city.toValueHintsDefaultValue(),
            onChanged: (value) => _onChanged(key: 'city', value: value),
            values: widget.valueHints.propertyHints!['city']!.values,
            pattern: widget.valueHints.propertyHints!['city']!.pattern,
            fieldName: 'i18n://attributes.values.$__valueType.city.label',
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: _requiredValues.contains('state'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.state.toValueHintsDefaultValue(),
            onChanged: (value) => _onChanged(key: 'state', value: value),
            values: widget.valueHints.propertyHints!['state']!.values,
            pattern: widget.valueHints.propertyHints!['state']!.pattern,
            fieldName: 'i18n://attributes.values.$__valueType.state.label',
          ),
          const SizedBox(height: 16),
          DropdownSelectInput(
            onChanged: (value) => _onChanged(key: 'country', value: value),
            decoration: widget.decoration,
            mustBeFilledOut: _requiredValues.contains('country'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.initialValue?.country.toValueHintsDefaultValue(),
            technicalType: widget.renderHints.propertyHints!['country']!.technicalType,
            dataType: widget.renderHints.propertyHints!['country']!.dataType,
            values: widget.valueHints.propertyHints!['country']!.values!,
            fieldName: 'i18n://attributes.values.$__valueType.country.label',
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
