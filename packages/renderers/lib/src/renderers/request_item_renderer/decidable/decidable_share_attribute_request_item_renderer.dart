import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '/src/request_item_index.dart';
import '/src/request_renderer_controller.dart';
import '../widgets/draft_attribute_renderer.dart';

class DecidableShareAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableShareAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const DecidableShareAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
  });

  @override
  State<DecidableShareAttributeRequestItemRenderer> createState() => _DecidableShareAttributeRequestItemRendererState();
}

class _DecidableShareAttributeRequestItemRendererState extends State<DecidableShareAttributeRequestItemRenderer> {
  @override
  void initState() {
    super.initState();

    widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DraftAttributeRenderer(draftAttribute: widget.item.attribute),
        Text(widget.item.attribute.name),
        const SizedBox(height: 30),
      ],
    );
  }
}
