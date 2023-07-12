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

                return ListTile(
                  // title: Text('$key: $techType, $editType, $dataType'),
                  subtitle: showInput(key, techType, editType),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

showInput(key, techType, editType) {
  if (editType == 'SelectLike') {
    return const ValueRenderer(
      technicalType: RenderHintsTechnicalType.String,
      editType: RenderHintsEditType.SelectLike,
    );
  } else if (techType == 'String') {
    return ValueRenderer(
      fieldName: key,
      technicalType: RenderHintsTechnicalType.String,
    );
  }
}
