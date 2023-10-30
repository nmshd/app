import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class RegisterAttributeAcceptResponseItemRenderer extends StatelessWidget {
  final RegisterAttributeListenerAcceptResponseItemDVO item;

  const RegisterAttributeAcceptResponseItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${item.type})', style: const TextStyle(fontWeight: FontWeight.w200)),
        const SizedBox(height: 30),
      ],
    );
  }
}
