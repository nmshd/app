import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/value_renderer.dart';

class ComplexRenderer extends StatelessWidget {
  const ComplexRenderer({
    super.key,
    this.fieldName,
    this.editType,
    this.dataType,
    required this.initialValue,
    required this.valueHints,
    required this.renderHints,
  });

  final Map<String, dynamic>? initialValue;
  final String? fieldName;
  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;
  final RenderHints renderHints;
  final ValueHints valueHints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          initialValue?['@type'] ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 500,
          child: ListView.builder(
            itemCount: renderHints.propertyHints?.values.length,
            itemBuilder: (context, index) {
              final String key = renderHints.propertyHints!.keys.elementAt(index);
              final itemInitialValue = {'@type': key, 'value': initialValue?[key]};
              final itemRenderHints = renderHints.propertyHints![key];
              final itemValueHints = valueHints.propertyHints![key];

              return ListTile(
                title: ValueRenderer(
                  initialValue: itemInitialValue,
                  renderHints: itemRenderHints!,
                  valueHints: itemValueHints!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
