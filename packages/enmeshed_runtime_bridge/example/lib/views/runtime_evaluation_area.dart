import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';

class RuntimeEvaluationArea extends StatefulWidget {
  final EnmeshedRuntime runtime;

  const RuntimeEvaluationArea({super.key, required this.runtime});

  @override
  State<RuntimeEvaluationArea> createState() => _RuntimeEvaluationAreaState();
}

class _RuntimeEvaluationAreaState extends State<RuntimeEvaluationArea> {
  final textEditingController = TextEditingController();
  String? evaluationResult;

  Future<void> evaluateCodeFromTextField() async {
    final content = textEditingController.text;
    final result = await widget.runtime.evaluateJavascript(content);
    setState(() {
      evaluationResult = result.toString();
    });

    textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textEditingController,
            onSubmitted: (_) => evaluateCodeFromTextField(),
            decoration: const InputDecoration(
              hintText: 'Enter your message',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: evaluateCodeFromTextField,
            child: const Text('evaluate'),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              evaluationResult ?? '',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
