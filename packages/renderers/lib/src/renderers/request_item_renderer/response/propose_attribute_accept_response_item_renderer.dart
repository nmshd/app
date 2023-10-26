import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';

class ProposeAttributeAcceptResponseItemRenderer extends StatefulWidget {
  final ProposeAttributeAcceptResponseItemDVO item;
  final RequestRendererController? controller;
  final int itemIndex;
  final int? groupIndex;

  const ProposeAttributeAcceptResponseItemRenderer({
    super.key,
    required this.item,
    required this.itemIndex,
    this.groupIndex,
    this.controller,
  });

  @override
  State<ProposeAttributeAcceptResponseItemRenderer> createState() => _ProposeAttributeAcceptResponseItemRendererState();
}

class _ProposeAttributeAcceptResponseItemRendererState extends State<ProposeAttributeAcceptResponseItemRenderer> {
  @override
  void initState() {
    super.initState();

    if (widget.groupIndex != null) {
      final groupIndex = widget.groupIndex!;
      final controllerValue = widget.controller?.value?.items[groupIndex] as DecideRequestItemGroupParameters;
      controllerValue.items[widget.itemIndex] =
          AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: widget.item.attribute.id);
    } else {
      widget.controller?.value?.items[widget.itemIndex] =
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
