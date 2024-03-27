import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../inputs/inputs.dart';
import '/value_renderer.dart';

class DeliveryBoxAddressRenderer extends StatefulWidget {
  final RenderHints renderHints;
  final ValueHints valueHints;
  final String? translatedText;
  final ValueRendererController? controller;
  final DeliveryBoxAddressAttributeValue? initialValue;
  final InputDecoration? decoration;

  const DeliveryBoxAddressRenderer({
    required this.renderHints,
    required this.valueHints,
    this.translatedText,
    this.controller,
    this.initialValue,
    this.decoration,
    super.key,
  });

  @override
  State<DeliveryBoxAddressRenderer> createState() => _DeliveryBoxAddressRendererState();
}

class _DeliveryBoxAddressRendererState extends State<DeliveryBoxAddressRenderer> {
  ValueRendererInputValueMap? _inputValueMap;

  final Map<String, dynamic> _valueMap = {};
  final _requiredValues = ['recipient', 'deliveryBoxId', 'userId', 'phoneNumber', 'zipCode', 'city', 'country'];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextInput(
            mustBeFilledOut: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: _initialValue(widget.initialValue?.recipient),
            onChanged: (value) => _onChanged(key: 'recipient', value: value),
            values: widget.valueHints.propertyHints!['recipient']!.values,
            pattern: widget.valueHints.propertyHints!['recipient']!.pattern,
            fieldName: _fieldName(context, 'recipient'),
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: _initialValue(widget.initialValue?.deliveryBoxId),
            onChanged: (value) => _onChanged(key: 'deliveryBoxId', value: value),
            values: widget.valueHints.propertyHints!['deliveryBoxId']!.values,
            pattern: widget.valueHints.propertyHints!['deliveryBoxId']!.pattern,
            fieldName: _fieldName(context, 'deliveryBoxId'),
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: _initialValue(widget.initialValue?.userId),
            onChanged: (value) => _onChanged(key: 'userId', value: value),
            values: widget.valueHints.propertyHints!['userId']!.values,
            pattern: widget.valueHints.propertyHints!['userId']!.pattern,
            fieldName: _fieldName(context, 'userId'),
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: _initialValue(widget.initialValue?.phoneNumber),
            onChanged: (value) => _onChanged(key: 'phoneNumber', value: value),
            values: widget.valueHints.propertyHints!['phoneNumber']!.values,
            pattern: widget.valueHints.propertyHints!['phoneNumber']!.pattern,
            fieldName: _fieldName(context, 'phoneNumber'),
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: _initialValue(widget.initialValue?.zipCode),
            onChanged: (value) => _onChanged(key: 'zipCode', value: value),
            values: widget.valueHints.propertyHints!['zipCode']!.values,
            pattern: widget.valueHints.propertyHints!['zipCode']!.pattern,
            fieldName: _fieldName(context, 'zipCode'),
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: _initialValue(widget.initialValue?.city),
            onChanged: (value) => _onChanged(key: 'city', value: value),
            values: widget.valueHints.propertyHints!['city']!.values,
            pattern: widget.valueHints.propertyHints!['city']!.pattern,
            fieldName: _fieldName(context, 'city'),
          ),
          const SizedBox(height: 16),
          TextInput(
            mustBeFilledOut: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: _initialValue(widget.initialValue?.state),
            onChanged: (value) => _onChanged(key: 'state', value: value, requiredValue: false),
            values: widget.valueHints.propertyHints!['state']!.values,
            pattern: widget.valueHints.propertyHints!['state']!.pattern,
            fieldName: _fieldName(context, 'state'),
          ),
          const SizedBox(height: 16),
          DropdownSelectInput(
            onChanged: (value) => _onChanged(key: 'country', value: value),
            decoration: widget.decoration,
            mustBeFilledOut: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: _initialValue(widget.initialValue?.country),
            technicalType: widget.renderHints.propertyHints!['country']!.technicalType,
            dataType: widget.renderHints.propertyHints!['country']!.dataType,
            values: widget.valueHints.propertyHints!['country']!.values!,
            fieldName: _fieldName(context, 'country'),
          ),
        ],
      ),
    );
  }

  String _fieldName(BuildContext context, String key) {
    final translation = FlutterI18n.translate(context, 'attributes.values.DeliveryBoxAddress.$key.label');

    return _requiredValues.contains(key) ? '$translation*' : translation;
  }

  void _onChanged({bool requiredValue = true, required String key, required String value}) {
    if (value.isEmpty && requiredValue) {
      _valueMap.remove(key);
    } else {
      _valueMap[key] = ValueRendererInputValueString(value);
      _inputValueMap = ValueRendererInputValueMap(Map<String, dynamic>.from(_valueMap));
    }

    _validateForm();
  }

  void _validateForm() {
    if (widget.controller != null && _formKey.currentState != null) {
      widget.controller!.value = _containsAllRequiredValues && _formKey.currentState!.validate() ? _inputValueMap : ValueRendererValidationError();
    }
  }

  ValueHintsDefaultValueString? _initialValue(String? value) => value != null ? ValueHintsDefaultValueString(value) : null;

  bool get _containsAllRequiredValues => _requiredValues.every((element) => _valueMap.containsKey(element));
}
