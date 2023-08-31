import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

class ControllerExample extends StatefulWidget {
  const ControllerExample({super.key});

  @override
  State<ControllerExample> createState() => _ControllerExampleState();
}

class _ControllerExampleState extends State<ControllerExample> {
  ValueRendererController controller = ValueRendererController();

  dynamic value;

  @override
  void initState() {
    super.initState();

    controller.addListener(() => setState(() => value = controller.value));
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueRenderer(
          fieldName: 'fieldName',
          renderHints: RenderHints(
            technicalType: RenderHintsTechnicalType.String,
            editType: RenderHintsEditType.InputLike,
          ),
          valueHints: const ValueHints(),
          controller: controller,
        ),
        Text(value.toString()),
      ],
    );
  }
}
