import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class CreateAttributeAcceptResponseItemRenderer extends StatelessWidget {
  final CreateAttributeAcceptResponseItemDVO item;

  const CreateAttributeAcceptResponseItemRenderer({super.key, required this.item});

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
