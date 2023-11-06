import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../request_renderer.dart';

class ProposeAttributeRequestItemRenderer extends StatelessWidget {
  final ProposeAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final bool isRejected;

  const ProposeAttributeRequestItemRenderer({super.key, required this.item, required this.controller, required this.isRejected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
      child: TranslatedText(item.query.name, style: const TextStyle(fontSize: 16)),
    );
  }
}
