import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';

class ProposeAttributeAcceptResponseItemRenderer extends StatefulWidget {
  final ProposeAttributeAcceptResponseItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const ProposeAttributeAcceptResponseItemRenderer({
    super.key,
    required this.item,
    required this.itemIndex,
    this.controller,
  });

  @override
  State<ProposeAttributeAcceptResponseItemRenderer> createState() => _ProposeAttributeAcceptResponseItemRendererState();
}

class _ProposeAttributeAcceptResponseItemRendererState extends State<ProposeAttributeAcceptResponseItemRenderer> {
  @override
  void initState() {
    super.initState();

    if (widget.itemIndex.innerIndex != null) {
      final rootIndex = widget.itemIndex.rootIndex;
      final innerIndex = widget.itemIndex.innerIndex!;

      final controllerValue = widget.controller?.value?.items[rootIndex] as DecideRequestItemGroupParameters;
      controllerValue.items[innerIndex] = AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: widget.item.attribute.id);
    } else {
      widget.controller?.value?.items[widget.itemIndex.rootIndex] =
          AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: widget.item.attribute.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${widget.item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        Text(widget.item.attribute.value.toString()),
        const SizedBox(height: 30),
      ],
    );
  }
}
