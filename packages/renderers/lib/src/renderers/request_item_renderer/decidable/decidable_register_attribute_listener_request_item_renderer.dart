import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../../../renderers.dart';

class DecidableRegisterAttributeListenerRequestItemRenderer extends StatelessWidget {
  final DecidableRegisterAttributeListenerRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableRegisterAttributeListenerRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return TranslatedText(item.query.name, style: const TextStyle(fontSize: 16));
  }
}
