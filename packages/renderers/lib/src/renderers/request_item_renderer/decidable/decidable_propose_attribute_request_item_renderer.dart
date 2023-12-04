import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/request_item_index.dart';
import '../../widgets/request_renderer_controller.dart';
import '../widgets/draft_attribute_renderer.dart';
import 'widgets/handle_checkbox_change.dart';

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

  @override
  void initState() {
    super.initState();

    final attribute = attributeContent(widget.item.attribute);
    if (attribute == null) return;

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: attribute),
    );

    updateSelectedAttribute();
  }

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(
      draftAttribute: widget.item.attribute,
      onUpdateCheckbox: onUpdateCheckbox,
      isChecked: isChecked,
      hideCheckbox: widget.requestStatus != LocalRequestStatus.ManualDecisionRequired && widget.item.mustBeAccepted,
      onUpdateAttribute: onUpdateAttribute,
      selectedAttribute: newAttribute,
    );
  }

  AbstractAttribute? attributeContent(DraftAttributeDVO attribute) {
    return switch (widget.item.attribute) {
      final DraftIdentityAttributeDVO dvo => dvo.content,
      final DraftRelationshipAttributeDVO dvo => dvo.content,
    };
  }

  void onUpdateCheckbox(bool? value) {
    setState(() {
      isChecked = value!;
    });

    final attribute = attributeContent(widget.item.attribute);
    if (attribute == null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: const RejectRequestItemParameters(),
      );

      return;
    }

    handleCheckboxChange(
      isChecked: isChecked,
      controller: widget.controller,
      itemIndex: widget.itemIndex,
      acceptRequestItemParameter: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: newAttribute ?? attribute),
    );
  }

  Future<void> onUpdateAttribute(String valueType) async {
    final selectedAttribute = await widget.selectAttribute?.call(valueType: valueType);

    if (selectedAttribute != null) {
      setState(() {
        newAttribute = selectedAttribute;
      });
    }
  }

  Future<void> updateSelectedAttribute() async {
    if (newAttribute != null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: newAttribute!),
      );
    } else {
      final attribute = attributeContent(widget.item.attribute);
      if (attribute == null) return;

      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: attribute),
      );
    }
  }
}
