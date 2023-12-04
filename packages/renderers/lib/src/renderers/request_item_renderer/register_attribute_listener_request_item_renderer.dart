import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

class RegisterAttributeListenerRequestItemRenderer extends StatelessWidget {
  final RegisterAttributeListenerRequestItemDVO item;

  const RegisterAttributeListenerRequestItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TranslatedText(item.query.name, style: const TextStyle(fontSize: 16)),
    );
  }
}
