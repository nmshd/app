import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../../../../renderers.dart';

class DecidableRegisterAttributeListenerRequestItemRenderer extends StatefulWidget {
  final DecidableRegisterAttributeListenerRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const DecidableRegisterAttributeListenerRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
  });

  @override
  State<DecidableRegisterAttributeListenerRequestItemRenderer> createState() => _DecidableRegisterAttributeListenerRequestItemRendererState();
}

class _DecidableRegisterAttributeListenerRequestItemRendererState extends State<DecidableRegisterAttributeListenerRequestItemRenderer> {
  @override
  void initState() {
    super.initState();

    if (widget.itemIndex.innerIndex != null) {
      final groupIndex = widget.itemIndex.innerIndex!;
      final controllerValue = widget.controller?.value?.items[groupIndex] as DecideRequestItemGroupParameters;
      controllerValue.items[widget.itemIndex.rootIndex] = const AcceptRequestItemParameters();
    }

    widget.controller?.value?.items[widget.itemIndex.rootIndex] = const AcceptRequestItemParameters();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
      child: TranslatedText(widget.item.query.name, style: const TextStyle(fontSize: 16)),
    );
  }
}
