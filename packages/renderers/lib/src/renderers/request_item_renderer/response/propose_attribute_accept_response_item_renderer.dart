import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../widgets/identity_attribute_value_renderer.dart';
import '../widgets/relationship_attribute_value_renderer.dart';
import '/src/request_item_index.dart';
import '/src/request_renderer_controller.dart';

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
    return switch (widget.item.attribute.value) {
      final IdentityAttributeValue value => IdentityAttributeValueRenderer(value: value),
      final RelationshipAttributeValue value => RelationshipAttributeValueRenderer(value: value),
      _ => throw Exception('Unknown AttributeValue: ${widget.item.attribute.valueType}'),
    };
  }
}
