import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';

class DecidableConsentRequestItemRenderer extends StatefulWidget {
  final DecidableConsentRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const DecidableConsentRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
  });

  @override
  State<DecidableConsentRequestItemRenderer> createState() => _DecidableConsentRequestItemRendererState();
}

class _DecidableConsentRequestItemRendererState extends State<DecidableConsentRequestItemRenderer> {
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
    return Column(
      children: [
        Text('(${widget.item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        Text(widget.item.consent),
        if (widget.item.link != null) Text(widget.item.link!),
      ],
    );
  }
}
