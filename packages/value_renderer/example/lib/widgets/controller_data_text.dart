import 'package:flutter/material.dart';

class ControllerDataText extends StatelessWidget {
  final String controllerData;

  const ControllerDataText({super.key, required this.controllerData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: Row(
        children: [
          const Text('Controller: ', style: TextStyle(fontWeight: FontWeight.w500)),
          Flexible(child: Text(controllerData)),
        ],
      ),
    );
  }
}
