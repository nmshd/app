import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/request_item_index.dart';
import '../../widgets/request_renderer_controller.dart';
import '../widgets/draft_attribute_renderer.dart';

class DecidableProposeAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableProposeAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<AbstractAttribute> Function({required String valueType})? selectAttribute;
  final LocalRequestStatus? requestStatus;

  const DecidableProposeAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.selectAttribute,
    this.requestStatus,
  });
  @override
  State<DecidableProposeAttributeRequestItemRenderer> createState() => _DecidableProposeAttributeRequestItemRendererState();
}

class _DecidableProposeAttributeRequestItemRendererState extends State<DecidableProposeAttributeRequestItemRenderer> {
  bool isChecked = true;
  AbstractAttribute? newAttribute;

  attributeContent(DraftAttributeDVO attribute) {
    return switch (widget.item.attribute) {
      final DraftIdentityAttributeDVO dvo => dvo.content,
      final DraftRelationshipAttributeDVO dvo => dvo.content,
    };
  }

  attributeType(DraftAttributeDVO attribute) {
    return switch (widget.item.attribute) {
      final DraftIdentityAttributeDVO dvo => dvo.valueType,
      final DraftRelationshipAttributeDVO dvo => dvo.valueType,
    };
  }

  void onUpdateCheckbox(bool? value) {
    setState(() {
      isChecked = value!;
    });

    if (isChecked) {
      final attribute = attributeContent(widget.item.attribute);

      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: newAttribute ?? attribute),
      );
    } else {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: const RejectRequestItemParameters(),
      );
    }
  }

  Future<void> loadSelectedAttribute() async {
    final valueType = attributeType(widget.item.attribute);

    final selectedAttribute = await widget.selectAttribute?.call(valueType: valueType);
    if (selectedAttribute != null) {
      setState(() {
        newAttribute = selectedAttribute;
      });

      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: newAttribute!),
      );
    } else {
      final attribute = attributeContent(widget.item.attribute);

      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: attribute),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    final attribute = attributeContent(widget.item.attribute);

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: attribute),
    );

    loadSelectedAttribute();
  }

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(
      draftAttribute: widget.item.attribute,
      onUpdateCheckbox: onUpdateCheckbox,
      isChecked: isChecked,
      hideCheckbox: widget.requestStatus != LocalRequestStatus.ManualDecisionRequired && widget.item.mustBeAccepted,
      selectedAttribute: newAttribute,
    );
  }
}
