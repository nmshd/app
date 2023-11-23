import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '/src/request_renderer_controller.dart';

class ProposeAttributeRequestItemRenderer extends StatelessWidget {
  final ProposeAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const ProposeAttributeRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TranslatedText(item.query.name, style: const TextStyle(fontSize: 16)),
    );
  }
}
