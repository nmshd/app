import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import '../widgets/draft_attribute_renderer.dart';
import 'checkbox_enabled_extension.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableProposeAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableProposeAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<AbstractAttribute> Function({required String valueType})? selectAttribute;

  const DecidableProposeAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.selectAttribute,
  });

  @override
  State<DecidableProposeAttributeRequestItemRenderer> createState() => _DecidableProposeAttributeRequestItemRendererState();
}

class _DecidableProposeAttributeRequestItemRendererState extends State<DecidableProposeAttributeRequestItemRenderer> {
  late bool isChecked;
  AbstractAttribute? newAttribute;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked;

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
      checkboxSettings: (isChecked: isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
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
    if (value == null) return;

    setState(() {
      isChecked = value;
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
