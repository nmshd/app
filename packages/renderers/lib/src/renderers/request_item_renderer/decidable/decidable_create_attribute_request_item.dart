import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';

class DecidableCreateAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableCreateAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const DecidableCreateAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
  });

  @override
  State<DecidableCreateAttributeRequestItemRenderer> createState() => _DecidableCreateAttributeRequestItemRendererState();
}

class _DecidableCreateAttributeRequestItemRendererState extends State<DecidableCreateAttributeRequestItemRenderer> {
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
    return const Placeholder();
  }
}
