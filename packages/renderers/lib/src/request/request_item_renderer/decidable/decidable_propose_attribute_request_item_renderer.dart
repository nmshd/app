import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import '/src/attribute/attribute_renderer.dart';
import '/src/attribute/draft_attribute_renderer.dart';
import 'checkbox_enabled_extension.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableProposeAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableProposeAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final String currentAddress;
  final Future<AbstractAttribute?> Function({
    required String valueType,
    required List<AbstractAttribute> attributes,
    ValueHints? valueHints,
  })? selectAttribute;

  const DecidableProposeAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.selectAttribute,
    required this.currentAddress,
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

    _updateSelectedAttribute();
  }

  @override
  Widget build(BuildContext context) {
    final trailing = IconButton(onPressed: () => onUpdateAttribute(widget.item.attribute.valueType), icon: const Icon(Icons.chevron_right));

    if (newAttribute != null) {
      return Row(
        children: [
          Checkbox(value: isChecked, onChanged: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
          Expanded(
            child: AttributeRenderer(
              attribute: newAttribute!,
              trailing: trailing,
              valueHints: widget.item.attribute.valueHints,
            ),
          ),
        ],
      );
    }

    return DraftAttributeRenderer(
      draftAttribute: widget.item.attribute,
      checkboxSettings: (isChecked: isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
      trailing: trailing,
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

  List<AbstractAttribute> getAttributeValue(ProcessedAttributeQueryDVO attribute) {
    final results = switch (attribute) {
      final ProcessedIdentityAttributeQueryDVO query => query.results,
      final ProcessedRelationshipAttributeQueryDVO query => query.results,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.results,
      final ProcessedIQLQueryDVO query => query.results,
    };

    final List<AbstractAttribute> resultValue = results.map((result) {
      return result.content;
    }).toList();

    return resultValue;
  }

  Future<void> onUpdateAttribute(String valueType) async {
    if (widget.selectAttribute != null) {
      final resultValues = getAttributeValue(widget.item.query);

      final selectedAttribute = await widget.selectAttribute!(
        valueType: valueType,
        attributes: resultValues,
        valueHints: widget.item.attribute.valueHints,
      );

      setState(() => newAttribute = selectedAttribute);

      _updateSelectedAttribute();
    }
  }

  Future<void> _updateSelectedAttribute() async {
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
