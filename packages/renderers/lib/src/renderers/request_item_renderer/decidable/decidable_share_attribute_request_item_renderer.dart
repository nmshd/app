import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';
import '../widgets/identity_attribute_renderer.dart';
import '../widgets/relationship_attribute_renderer.dart';

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

    if (widget.itemIndex.innerIndex != null) {
      final groupIndex = widget.itemIndex.innerIndex!;
      final controllerValue = widget.controller?.value?.items[groupIndex] as DecideRequestItemGroupParameters;
      controllerValue.items[widget.itemIndex.rootIndex] =
          AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: widget.item.attribute.id);
    }

    widget.controller?.value?.items[widget.itemIndex.rootIndex] =
        AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: widget.item.attribute.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        switch (widget.item.attribute) {
          final DraftIdentityAttributeDVO dvo => DraftIdentityAttributeRenderer(attribute: dvo),
          final DraftRelationshipAttributeDVO dvo => DraftRelationshipAttributeRenderer(attribute: dvo),
        },
        Text(widget.item.attribute.name),
        const SizedBox(height: 30),
      ],
    );
  }
}
