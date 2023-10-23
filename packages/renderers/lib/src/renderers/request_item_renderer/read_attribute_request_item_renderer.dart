import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../request_renderer.dart';

class ReadAttributeRequestItemRenderer extends StatelessWidget {
  final ReadAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const ReadAttributeRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
          child: TranslatedText(item.query.name, style: const TextStyle(fontSize: 16)),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
