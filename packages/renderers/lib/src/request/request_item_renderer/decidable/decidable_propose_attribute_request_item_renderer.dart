import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '/src/attribute/attribute_renderer.dart';
import '../../open_attribute_switcher_function.dart';
import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import 'checkbox_enabled_extension.dart';

class DecidableProposeAttributeRequestItemRenderer extends StatefulWidget {
  final ProposeAttributeRequestItemDVO item;
  final RequestItemIndex itemIndex;
  final RequestRendererController? controller;
  final OpenAttributeSwitcherFunction? openAttributeSwitcher;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;

  const DecidableProposeAttributeRequestItemRenderer({
    super.key,
    required this.itemIndex,
    required this.item,
    this.controller,
    this.openAttributeSwitcher,
    required this.expandFileReference,
    required this.openFileDetails,
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

    if (isChecked) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: _choice.attribute),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: isChecked, onChanged: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
        Expanded(
          child: AttributeRenderer(
            attribute: _choice.attribute,
            valueHints: widget.item.attribute.valueHints,
            trailing: SizedBox(
              width: 50,
              child: IconButton(onPressed: () => onUpdateAttribute(widget.item.attribute.valueType), icon: const Icon(Icons.chevron_right)),
            ),
            expandFileReference: widget.expandFileReference,
            openFileDetails: widget.openFileDetails,
          ),
        ),
      ],
    );
  }

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() => isChecked = value);

    if (!isChecked) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const RejectRequestItemParameters());

      return;
    }

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value:
          _choice.id != null
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
      isChecked = true;
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
    final results = switch (widget.item.query as ProcessedAttributeQueryDVO) {
      final ProcessedIdentityAttributeQueryDVO query => query.results,
      final ProcessedRelationshipAttributeQueryDVO query => query.results,
      // TODO: how to handle this (this will never happen as it is not sent from a ProposeAttributeRequestItem)
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.results,
      final ProcessedIQLQueryDVO query => query.results,
    };

    return {...results.map((result) => (id: result.id, attribute: result.content)), _getProposedChoice(), _choice}.toList();
  }

  ({String? id, AbstractAttribute attribute}) _getProposedChoice() {
    return switch (widget.item.attribute) {
      final DraftIdentityAttributeDVO dvo => (id: null, attribute: dvo.content),
      final DraftRelationshipAttributeDVO dvo => (id: null, attribute: dvo.content),
    };
  }
}
