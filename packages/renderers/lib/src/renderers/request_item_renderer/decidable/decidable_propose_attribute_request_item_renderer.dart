import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:renderers/src/renderers/request_item_renderer/widgets/draft_attribute_renderer.dart';

import '/src/request_item_index.dart';
import '/src/request_renderer_controller.dart';

class DecidableProposeAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableProposeAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<AbstractAttribute> Function()? selectAttribute;
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

  void onUpdateCheckbox(bool? value) {
    setState(() {
      isChecked = value!;
    });

    if (isChecked) {
      loadSelectedAttribute();
    } else {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: const RejectRequestItemParameters(),
      );
    }
  }

  Future<void> loadSelectedAttribute() async {
    final selectedAttribute = await widget.selectAttribute?.call();
    if (selectedAttribute != null) {
      setState(() {
        newAttribute = selectedAttribute;
      });

      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: newAttribute!),
      );
    } else {
      final attribute = switch (widget.item.attribute) {
        final DraftIdentityAttributeDVO dvo => dvo.content,
        final DraftRelationshipAttributeDVO dvo => dvo.content,
      };

      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: attribute),
      );
    }
  }

  @override
  void initState() {
    super.initState();

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
