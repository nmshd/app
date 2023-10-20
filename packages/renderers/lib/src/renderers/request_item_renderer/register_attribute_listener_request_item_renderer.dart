import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../request_renderer.dart';

class RegisterAttributeListenerRequestItemRenderer extends StatelessWidget {
  final RegisterAttributeListenerRequestItemDVO item;
  final RequestRendererController? controller;

  const RegisterAttributeListenerRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TranslatedText(item.query.name, style: const TextStyle(fontSize: 16)),
        const Divider(height: 0),
      ],
    );
  }
}
