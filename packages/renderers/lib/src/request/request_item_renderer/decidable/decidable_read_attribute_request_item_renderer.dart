import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:value_renderer/value_renderer.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import '../widgets/processed_query_renderer.dart';
import 'checkbox_enabled_extension.dart';
import 'widgets/compose_identity_attribute_value.dart';
import 'widgets/compose_relationship_attribute_value.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableReadAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableReadAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<AttributeValue?> Function({required String valueType, List<AttributeValue>? attributes})? selectAttribute;
  final String currentAddress;

  const DecidableReadAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.selectAttribute,
    required this.currentAddress,
  });

  @override
  State<DecidableReadAttributeRequestItemRenderer> createState() => _DecidableReadAttributeRequestItemRendererState();
}

class _DecidableReadAttributeRequestItemRendererState extends State<DecidableReadAttributeRequestItemRenderer> {
  late bool isChecked;
  AbstractAttribute? newAttribute;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked;

    final attribute = attributeContent(widget.item.query);
    if (attribute == null) return;

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: attribute),
    );

    _updateSelectedAttribute();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => ProcessedIdentityAttributeQueryRenderer(
          query: query,
          checkboxSettings: (isChecked: isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
          onUpdateAttribute: onUpdateAttribute,
          onUpdateInput: onUpdateInput,
          selectedAttribute: newAttribute,
          mustBeAccepted: widget.item.mustBeAccepted,
        ),
      final ProcessedRelationshipAttributeQueryDVO query => ProcessedRelationshipAttributeQueryRenderer(
          query: query,
          checkboxSettings: (isChecked: isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
          onUpdateAttribute: onUpdateAttribute,
          onUpdateInput: onUpdateInput,
          selectedAttribute: newAttribute,
          mustBeAccepted: widget.item.mustBeAccepted,
        ),
      //final ThirdPartyRelationshipAttributeQueryDVO query => ThirdPartyAttributeQueryRenderer(query: query),
      _ => throw Exception("Invalid type '${widget.item.query.type}'"),
    };
  }

  AbstractAttribute? attributeContent(ProcessedAttributeQueryDVO attribute) {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.results.firstOrNull?.content,
      final ProcessedRelationshipAttributeQueryDVO query => query.results.firstOrNull?.content,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.thirdParty.first.relationship?.items.firstOrNull?.content,
      final ProcessedIQLQueryDVO query => query.results.firstOrNull?.content,
    };
  }

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() {
      isChecked = value;
    });

    final attribute = attributeContent(widget.item.query);
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
      acceptRequestItemParameter: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: newAttribute ?? attribute),
    );
  }

  void onUpdateInput({String? valueType, ValueRendererInputValue? inputValue, required bool isComplex}) {
    if (widget.item.query is ProcessedIdentityAttributeQueryDVO) {
      final IdentityAttribute? composedValue = composeIdentityAttributeValue(
        inputValue: inputValue,
        valueType: valueType,
        isComplex: isComplex,
        currentAddress: widget.currentAddress,
      );

      if (composedValue != null) {
        setState(() => newAttribute = composedValue);

        _updateSelectedAttribute();
        _enableCheckbox();
      } else {
        widget.controller?.writeAtIndex(
          index: widget.itemIndex,
          value: const RejectRequestItemParameters(),
        );
      }
    }

    if (widget.item.query is ProcessedRelationshipAttributeQueryDVO) {
      final RelationshipAttribute? composedValue = composeRelationshipAttributeValue(
        inputValue: inputValue,
        valueType: valueType,
        isComplex: isComplex,
        query: widget.item.query as ProcessedRelationshipAttributeQueryDVO,
        currentAddress: widget.currentAddress,
      );

      if (composedValue != null) {
        setState(() => newAttribute = composedValue);

        _updateSelectedAttribute();
        _enableCheckbox();
      } else {
        widget.controller?.writeAtIndex(
          index: widget.itemIndex,
          value: const RejectRequestItemParameters(),
        );
      }
    }
  }

  List<AttributeValue> getAttributeValue(ProcessedAttributeQueryDVO attribute) {
    final results = switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.results,
      final ProcessedRelationshipAttributeQueryDVO query => query.results,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.results,
      final ProcessedIQLQueryDVO query => query.results,
    };

    final resultValue = results.map((result) {
      return switch (result.content) {
        final IdentityAttribute resultContent => resultContent.value,
        final RelationshipAttribute resultContent => resultContent.value,
        _ => throw Exception("Invalid type '${result.content.runtimeType}'"),
      };
    }).toList();

    return resultValue;
  }

  Future<void> onUpdateAttribute(String valueType) async {
    if (widget.selectAttribute != null) {
      final resultValues = getAttributeValue(widget.item.query);

      final selectedAttribute = await widget.selectAttribute!(valueType: valueType, attributes: resultValues);

      if (selectedAttribute is IdentityAttribute) {
        final attributeValue = IdentityAttribute(
          owner: widget.currentAddress,
          value: IdentityAttributeValue.fromJson({'@type': valueType, 'value': selectedAttribute}),
        );

        setState(() => newAttribute = attributeValue);

        _updateSelectedAttribute();
      }

      if (selectedAttribute is RelationshipAttribute) {
        final processedAttributeQuery = widget.item.query as ProcessedRelationshipAttributeQueryDVO;

        final attributeValue = RelationshipAttribute(
          confidentiality: RelationshipAttributeConfidentiality.values.byName(processedAttributeQuery.attributeCreationHints.confidentiality),
          key: processedAttributeQuery.key,
          owner: widget.currentAddress,
          value: RelationshipAttributeValue.fromJson({'@type': valueType, 'value': selectedAttribute}),
        );

        setState(() => newAttribute = attributeValue);

        _updateSelectedAttribute();
      }
    }
  }

  void _updateSelectedAttribute() {
    if (newAttribute != null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: newAttribute!),
      );
    } else {
      final attribute = attributeContent(widget.item.query);
      if (attribute == null) return;

      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: attribute),
      );
    }
  }

  void _enableCheckbox() {
    if (widget.controller != null && !widget.item.mustBeAccepted) {
      setState(() {
        isChecked = true;
      });
    }
  }
}