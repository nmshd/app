import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/value_renderer.dart';
import 'package:value_renderer/src/widgets/inputs/datepicker_input.dart';

class ComplexRenderer extends StatelessWidget {
  final RenderHintsDataType? dataType;
  final RenderHintsEditType? editType;
  final String fieldName;
  final AttributeValue? initialValue;
  final RenderHints renderHints;
  final ValueHints valueHints;

  const ComplexRenderer({
    super.key,
    required this.fieldName,
    this.editType,
    this.dataType,
    required this.initialValue,
    required this.valueHints,
    required this.renderHints,
  });

  @override
  Widget build(BuildContext context) {
    if (initialValue is BirthDateAttributeValue) {
      return DatepickerInput(
        initialValue: initialValue,
        fieldName: fieldName,
      );
    }

    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          fieldName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: renderHints.propertyHints?.values.length,
          itemBuilder: (context, index) {
            final key = renderHints.propertyHints!.keys.elementAt(index);
            final itemInitialDynamicValue = initialValue?.toJson()[key];
            final itemInitialValue = itemInitialDynamicValue == null ? null : _ComplexAttributeValueChild(itemInitialDynamicValue);
            final itemRenderHints = renderHints.propertyHints![key];
            final itemValueHints = valueHints.propertyHints![key];

            return ListTile(
              title: ValueRenderer(
                initialValue: itemInitialValue,
                renderHints: itemRenderHints!,
                valueHints: itemValueHints!,
                fieldName: key,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ComplexAttributeValueChild extends AttributeValue {
  final dynamic value;

  const _ComplexAttributeValueChild(this.value);

  @override
  Map<String, dynamic> toJson() => {'value': value};

  @override
  List<Object?> get props => [value];
}
