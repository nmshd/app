import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class FreeTextRequestItemRenderer extends StatelessWidget {
  final RequestItemDVO item;

  const FreeTextRequestItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(item.name, style: const TextStyle(fontSize: 16)),
    );
  }
}
