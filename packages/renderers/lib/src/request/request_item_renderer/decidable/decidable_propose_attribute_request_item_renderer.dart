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
  })? openAttributeScreen;

  const DecidableProposeAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.openAttributeScreen,
    required this.currentAddress,
  });

  @override
  State<DecidableProposeAttributeRequestItemRenderer> createState() => _DecidableProposeAttributeRequestItemRendererState();
}

class _DecidableProposeAttributeRequestItemRendererState extends State<DecidableProposeAttributeRequestItemRenderer> {
  late bool isChecked;
  AbstractAttribute? newAttribute;
  AbstractAttribute? selectedExistingAttribute;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked;

    final attribute = _getAttributeContent(widget.item.attribute);
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

    if (newAttribute != null || selectedExistingAttribute != null) {
      return Row(
        children: [
          Checkbox(value: isChecked, onChanged: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
          Expanded(
            child: AttributeRenderer(
              attribute: newAttribute ?? selectedExistingAttribute!,
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

  AbstractAttribute? _getAttributeContent(DraftAttributeDVO attribute) {
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

    final attribute = _getAttributeContent(widget.item.attribute);
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

  List<AbstractAttribute> _getAttributeValue(ProcessedAttributeQueryDVO attribute) {
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
    if (widget.openAttributeScreen != null) {
      final resultValues = _getAttributeValue(widget.item.query);

      final selectedAttribute = await widget.openAttributeScreen!(
        valueType: valueType,
        attributes: resultValues,
        valueHints: widget.item.attribute.valueHints,
      );

      if (resultValues.contains(selectedAttribute)) {
        setState(() => selectedExistingAttribute = selectedAttribute);
      } else {
        setState(() => newAttribute = selectedAttribute);
      }

      _updateSelectedAttribute();
    }
  }

  Future<void> _updateSelectedAttribute() async {
    if (newAttribute != null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: newAttribute!),
      );
    } else if (selectedExistingAttribute != null) {
      final results = switch (widget.item.query) {
        final ProcessedIdentityAttributeQueryDVO query => query.results,
        final ProcessedRelationshipAttributeQueryDVO query => query.results,
        final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.results,
        final ProcessedIQLQueryDVO query => query.results,
      };

      final existingAttribute = results.singleWhere((result) => result.content == selectedExistingAttribute);

      final existingAttributeId = switch (existingAttribute) {
        final RepositoryAttributeDVO attribute => attribute.id,
        final SharedToPeerAttributeDVO attribute => attribute.id,
        final PeerAttributeDVO attribute => attribute.id,
        final OwnRelationshipAttributeDVO attribute => attribute.id,
        final PeerRelationshipAttributeDVO attribute => attribute.id,
      };

      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: existingAttributeId),
      );
    } else {
      final attribute = _getAttributeContent(widget.item.attribute);
      if (attribute == null) return;

      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: attribute),
      );
    }
  }
}
