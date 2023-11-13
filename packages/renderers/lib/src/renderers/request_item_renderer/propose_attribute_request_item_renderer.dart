import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '/src/request_renderer_controller.dart';

class ProposeAttributeRequestItemRenderer extends StatefulWidget {
  final ProposeAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const ProposeAttributeRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  State<ProposeAttributeRequestItemRenderer> createState() => _ProposeAttributeRequestItemRendererState();
}

class _ProposeAttributeRequestItemRendererState extends State<ProposeAttributeRequestItemRenderer> {
  late AcceptProposeAttributeRequestItemParametersWithNewAttribute canAccept;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
      child: TranslatedText(widget.item.query.name, style: const TextStyle(fontSize: 16)),
    );
  }
}
