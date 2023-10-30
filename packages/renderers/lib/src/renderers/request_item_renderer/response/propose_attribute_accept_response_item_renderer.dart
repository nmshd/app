import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class ProposeAttributeAcceptResponseItemRenderer extends StatelessWidget {
  final ProposeAttributeAcceptResponseItemDVO item;

  const ProposeAttributeAcceptResponseItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${item.type})', style: const TextStyle(fontWeight: FontWeight.w200)),
        Text(item.attributeId),
        Text(item.attribute.value.toString()),
        const SizedBox(height: 30),
      ],
    );
  }
}
