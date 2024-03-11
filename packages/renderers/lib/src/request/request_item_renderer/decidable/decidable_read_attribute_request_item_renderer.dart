import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';
import 'package:value_renderer/value_renderer.dart';

import '../../request_item_index.dart';
import 'checkbox_enabled_extension.dart';
import 'widgets/processed_query_renderer.dart';

class DecidableReadAttributeRequestItemRenderer extends StatefulWidget {
  final String currentAddress;
  final DecidableReadAttributeRequestItemDVO item;
  final RequestItemIndex itemIndex;
  final RequestRendererController? controller;
  final OpenAttributeSwitcherFunction? openAttributeSwitcher;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;

  const DecidableReadAttributeRequestItemRenderer({
    super.key,
    required this.currentAddress,
    required this.item,
    required this.itemIndex,
    this.controller,
    this.openAttributeSwitcher,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
  });

  @override
  State<DecidableReadAttributeRequestItemRenderer> createState() => _DecidableReadAttributeRequestItemRendererState();
}

class _DecidableReadAttributeRequestItemRendererState extends State<DecidableReadAttributeRequestItemRenderer> {
  late bool isChecked;

  AttributeSwitcherChoice? _choice;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked;

    final choice = _getChoices().firstOrNull;
    if (choice == null) return;

    _choice = choice;

    if (isChecked) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: choice.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => ProcessedIdentityAttributeQueryRenderer(
          query: query,
          checkboxSettings: (isChecked: isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
          onUpdateAttribute: _onUpdateAttribute,
          onUpdateInput: _onUpdateInput,
          selectedAttribute: _choice?.attribute,
          mustBeAccepted: widget.item.mustBeAccepted,
          expandFileReference: widget.expandFileReference,
          chooseFile: widget.chooseFile,
          openFileDetails: widget.openFileDetails,
        ),
      final ProcessedRelationshipAttributeQueryDVO query => ProcessedRelationshipAttributeQueryRenderer(
          query: query,
          checkboxSettings: (isChecked: isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
          onUpdateAttribute: _onUpdateAttribute,
          onUpdateInput: _onUpdateInput,
          selectedAttribute: _choice?.attribute,
          mustBeAccepted: widget.item.mustBeAccepted,
          expandFileReference: widget.expandFileReference,
          chooseFile: widget.chooseFile,
          openFileDetails: widget.openFileDetails,
        ),
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => ProcessedThirdPartyRelationshipAttributeQueryRenderer(
          query: query,
          checkboxSettings: (isChecked: isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
          onUpdateAttribute: _onUpdateAttribute,
          selectedAttribute: _choice?.attribute,
          expandFileReference: widget.expandFileReference,
          openFileDetails: widget.openFileDetails,
        ),
      final ProcessedIQLQueryDVO query => ProcessedIQLQueryRenderer(
          query: query,
          checkboxSettings: (isChecked: isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
          onUpdateAttribute: _onUpdateAttribute,
          selectedAttribute: _choice?.attribute,
          expandFileReference: widget.expandFileReference,
          chooseFile: widget.chooseFile,
          mustBeAccepted: widget.item.mustBeAccepted,
          onUpdateInput: _onUpdateInput,
          openFileDetails: widget.openFileDetails,
        ),
    };
  }

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() {
      isChecked = value;
    });

    if (_choice == null || !value) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: const RejectRequestItemParameters(),
      );

      return;
    }

    final choice = _choice!;

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: choice.id == null
          ? AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: choice.attribute)
          : AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: choice.id!),
    );
  }

  void _onUpdateInput({String? valueType, ValueRendererInputValue? inputValue, required bool isComplex}) {
    if (widget.item.query is ProcessedIdentityAttributeQueryDVO && widget.item.query is ProcessedIQLQueryDVO) {
      final IdentityAttribute? composedValue = composeIdentityAttributeValue(
        inputValue: inputValue,
        valueType: valueType,
        isComplex: isComplex,
        currentAddress: widget.currentAddress,
      );

      if (composedValue != null) {
        widget.controller?.writeAtIndex(
          index: widget.itemIndex,
          value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: composedValue),
        );

        if (!isChecked) setState(() => isChecked = true);
      } else {
        widget.controller?.writeAtIndex(
          index: widget.itemIndex,
          value: const RejectRequestItemParameters(),
        );
      }
    } else if (widget.item.query is ProcessedRelationshipAttributeQueryDVO) {
      final RelationshipAttribute? composedValue = composeRelationshipAttributeValue(
        inputValue: inputValue,
        valueType: valueType,
        isComplex: isComplex,
        query: widget.item.query as ProcessedRelationshipAttributeQueryDVO,
        currentAddress: widget.currentAddress,
      );

      if (composedValue != null) {
        widget.controller?.writeAtIndex(
          index: widget.itemIndex,
          value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: composedValue),
        );

        if (!isChecked) setState(() => isChecked = true);
      } else {
        widget.controller?.writeAtIndex(
          index: widget.itemIndex,
          value: const RejectRequestItemParameters(),
        );
      }
    }
  }

  Future<void> _onUpdateAttribute([String? valueType]) async {
    if (widget.openAttributeSwitcher == null) return;

    final resultValues = Set<AttributeSwitcherChoice>.from(_getChoices());
    if (_choice != null) resultValues.add(_choice!);

    final valueHints = _getQueryValueHints();

    final choice = await widget.openAttributeSwitcher!(
      valueType: valueType,
      choices: resultValues.toList(),
      currentChoice: _choice,
      valueHints: valueHints,
    );

    if (choice == null) return;

    setState(() {
      _choice = choice;
      isChecked = true;
    });

    if (choice.id != null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: choice.id!),
      );
    } else {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: choice.attribute),
      );
    }
  }

  ValueHints? _getQueryValueHints() {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.valueHints,
      final ProcessedRelationshipAttributeQueryDVO query => query.valueHints,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.valueHints,
      final ProcessedIQLQueryDVO query => query.valueHints,
    };
  }

  List<({String id, AbstractAttribute attribute})> _getChoices() {
    final results = switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.results,
      final ProcessedRelationshipAttributeQueryDVO query => query.results,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.results,
      final ProcessedIQLQueryDVO query => query.results,
    };

    return results.map((result) => (id: result.id, attribute: result.content)).toList();
  }
}
