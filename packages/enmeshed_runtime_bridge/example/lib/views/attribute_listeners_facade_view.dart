import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';

class AttributeListenersFacadeView extends StatelessWidget {
  final EnmeshedRuntime runtime;

  const AttributeListenersFacadeView({super.key, required this.runtime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              const listenerId = '';
              final listener = await runtime.currentSession.consumptionServices.attributeListeners.getAttributeListener(
                listenerId: listenerId,
              );
              print(listener);
            },
            child: const Text('getAttributeListener'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final listeners = await runtime.currentSession.consumptionServices.attributeListeners.getAttributeListeners();
              print(listeners);
            },
            child: const Text('getAttributeListeners'),
          ),
        ],
      ),
    );
  }
}
