import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/src/value_renderer.dart';

class ComplexRenderer extends StatelessWidget {
  const ComplexRenderer(
      {super.key, this.fieldName, this.editType, this.dataType, required this.initialValue, required this.valueHints, required this.renderHints});

  final Map<String, dynamic>? initialValue;
  final String? fieldName;
  final RenderHintsEditType? editType;
  final RenderHintsDataType? dataType;
  final Map<String, dynamic> renderHints;
  final Map<String, dynamic> valueHints;

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
            itemCount: renderHints['propertyHints'].length,
            itemBuilder: (context, index) {
              final String key = renderHints['propertyHints'].keys.elementAt(index);
              final dynamic itemInitialValue = {'@type': key, 'value': initialValue?[key]};
              final dynamic itemRenderHints = renderHints['propertyHints'][key];
              final dynamic itemValueHints = valueHints['propertyHints'][key];

              return ListTile(
                title: ValueRenderer(fieldName: key, initialValue: itemInitialValue, renderHints: itemRenderHints, valueHints: itemValueHints),
              );
            },
          ),
        ),
      ],
    );
  }
}
