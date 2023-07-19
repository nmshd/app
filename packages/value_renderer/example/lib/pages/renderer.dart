import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

class Renderer extends StatelessWidget {
  const Renderer({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: Text('Value Renderer'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Text(data["value"]["@type"]),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data["renderHints"]["propertyHints"].length,
              itemBuilder: (context, index) {
                String key = data["renderHints"]["propertyHints"].keys.elementAt(index);
                dynamic techType = data["renderHints"]["propertyHints"][key]["technicalType"];
                dynamic dataType = data["renderHints"]["propertyHints"][key]["dataType"];
                dynamic editType = data["renderHints"]["propertyHints"][key]["editType"];
                dynamic initialValue = data["value"][key];
                dynamic maxLength = data["valueHints"]["propertyHints"][key]["max"];
                dynamic minLength = data["valueHints"]["propertyHints"][key]["min"];
                dynamic values = data["valueHints"]["propertyHints"][key]["values"];

                return ListTile(
                  title: Text('$key: $techType, $editType, $dataType | $initialValue, $maxLength, $minLength'),
                  subtitle: showInput(key, initialValue, values, techType, editType),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

showInput(key, initialValue, values, techType, editType) {
  if (editType == 'SelectLike') {
    return ValueRenderer(
      initialValue: initialValue,
      values: values,
      fieldName: key,
      technicalType: RenderHintsTechnicalType.String,
      editType: RenderHintsEditType.SelectLike,
    );
  } else if (techType == 'String') {
    return ValueRenderer(
      initialValue: initialValue,
      fieldName: key,
      technicalType: RenderHintsTechnicalType.String,
    );
  }
}
