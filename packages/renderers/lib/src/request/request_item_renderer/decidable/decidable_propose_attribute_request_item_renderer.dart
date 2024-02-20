import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../open_attribute_switcher_function.dart';
import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import '/src/attribute/attribute_renderer.dart';
import 'checkbox_enabled_extension.dart';

class DecidableProposeAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableProposeAttributeRequestItemDVO item;
  final RequestItemIndex itemIndex;
  final RequestRendererController? controller;
  final OpenAttributeSwitcherFunction? openAttributeSwitcher;

  const DecidableProposeAttributeRequestItemRenderer({
    super.key,
    required this.itemIndex,
    required this.item,
    this.controller,
    this.openAttributeSwitcher,
  });

  @override
  State<DecidableProposeAttributeRequestItemRenderer> createState() => _DecidableProposeAttributeRequestItemRendererState();
}

class _DecidableProposeAttributeRequestItemRendererState extends State<DecidableProposeAttributeRequestItemRenderer> {
  late bool isChecked;
  late AttributeSwitcherChoice _choice;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked;

    _choice = _getProposedChoice();

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: _choice.attribute),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trailing = IconButton(onPressed: () => onUpdateAttribute(widget.item.attribute.valueType), icon: const Icon(Icons.chevron_right));

    return Row(
      children: [
        Checkbox(value: isChecked, onChanged: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
        Expanded(
          child: AttributeRenderer(
            attribute: _choice.attribute,
            trailing: trailing,
            valueHints: widget.item.attribute.valueHints,
          ),
        ),
      ],
    );
  }

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() => isChecked = value);

    if (!isChecked) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: const RejectRequestItemParameters(),
      );

      return;
    }

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: _choice.id != null
          ? AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: _choice.id!)
          : AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: _choice.attribute),
    );
  }

  Future<void> onUpdateAttribute(String valueType) async {
    if (widget.openAttributeSwitcher == null) return;

    final resultValues = _getChoices();

    final choice = await widget.openAttributeSwitcher!(
      valueType: valueType,
      choices: resultValues,
      currentChoice: _choice,
      valueHints: widget.item.attribute.valueHints,
    );

    if (choice == null) return;

    setState(() {
      _choice = choice;
    });

    if (choice.id != null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: choice.id!),
      );
    } else {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: choice.attribute),
      );
    }
  }

  List<AttributeSwitcherChoice> _getChoices() {
    final results = switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.results,
      final ProcessedRelationshipAttributeQueryDVO query => query.results,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.results,
      final ProcessedIQLQueryDVO query => query.results,
    };

    return {
      ...results.map((result) => (id: result.id, attribute: result.content)),
      _getProposedChoice(),
      _choice,
    }.toList();
  }

  ({String? id, AbstractAttribute attribute}) _getProposedChoice() {
    return switch (widget.item.attribute) {
      final DraftIdentityAttributeDVO dvo => (id: null, attribute: dvo.content),
      final DraftRelationshipAttributeDVO dvo => (id: null, attribute: dvo.content),
    };
  }
}
