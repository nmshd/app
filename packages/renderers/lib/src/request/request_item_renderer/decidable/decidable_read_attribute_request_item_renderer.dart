import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

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
  late bool isManualDecisionAccepted;

  AttributeSwitcherChoice? _choice;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked(widget.item.mustBeAccepted, widget.item.requireManualDecision);
    isManualDecisionAccepted = widget.item.initallyDecided;

    final choice = _getChoices().firstOrNull;
    if (choice == null) return;

    _choice = choice;

    if (isChecked && widget.item.requireManualDecision != true) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: choice.id!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => ProcessedIdentityAttributeQueryRenderer(
        query: query,
        checkboxSettings: (
          isChecked: isChecked,
          onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null,
          isManualDecided: isManualDecisionAccepted,
          onUpdateManualDecision: onUpdateManualDecision,
        ),
        onUpdateAttribute: _onUpdateAttribute,
        selectedAttribute: _choice?.attribute,
        mustBeAccepted: widget.item.mustBeAccepted,
        requireManualDecision: widget.item.requireManualDecision,
        expandFileReference: widget.expandFileReference,
        chooseFile: widget.chooseFile,
        openFileDetails: widget.openFileDetails,
      ),
      final ProcessedRelationshipAttributeQueryDVO query => ProcessedRelationshipAttributeQueryRenderer(
        query: query,
        checkboxSettings: (
          isChecked: isChecked,
          onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null,
          isManualDecided: isManualDecisionAccepted,
          onUpdateManualDecision: onUpdateManualDecision,
        ),
        onUpdateAttribute: _onUpdateAttribute,
        selectedAttribute: _choice?.attribute,
        mustBeAccepted: widget.item.mustBeAccepted,
        requireManualDecision: widget.item.requireManualDecision,
        expandFileReference: widget.expandFileReference,
        chooseFile: widget.chooseFile,
        openFileDetails: widget.openFileDetails,
      ),
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => ProcessedThirdPartyRelationshipAttributeQueryRenderer(
        query: query,
        checkboxSettings: (
          isChecked: isChecked,
          onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null,
          isManualDecided: isManualDecisionAccepted,
          onUpdateManualDecision: onUpdateManualDecision,
        ),
        onUpdateAttribute: _onUpdateAttribute,
        selectedAttribute: _choice?.attribute,
        mustBeAccepted: widget.item.mustBeAccepted,
        requireManualDecision: widget.item.requireManualDecision,
        expandFileReference: widget.expandFileReference,
        openFileDetails: widget.openFileDetails,
      ),
      final ProcessedIQLQueryDVO query => ProcessedIQLQueryRenderer(
        requestItemTitle: widget.item.name,
        query: query,
        checkboxSettings: (
          isChecked: isChecked,
          onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null,
          isManualDecided: isManualDecisionAccepted,
          onUpdateManualDecision: onUpdateManualDecision,
        ),
        onUpdateAttribute: _onUpdateAttribute,
        selectedAttribute: _choice?.attribute,
        expandFileReference: widget.expandFileReference,
        chooseFile: widget.chooseFile,
        mustBeAccepted: widget.item.mustBeAccepted,
        requireManualDecision: widget.item.requireManualDecision,
        openFileDetails: widget.openFileDetails,
      ),
    };
  }

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() {
      isChecked = value;
    });

    if (_choice == null && value) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: ''),
      );
      return;
    }

    if ((widget.item.requireManualDecision == true && isManualDecisionAccepted == false) || _choice == null || !value) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const RejectRequestItemParameters());

      return;
    }

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: _choice!.id!),
    );
  }

  void onUpdateManualDecision(bool? value) {
    if (value == null) return;

    setState(() {
      isManualDecisionAccepted = value;
    });

    if ((widget.item.requireManualDecision == true && isManualDecisionAccepted == false) || _choice == null) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const RejectRequestItemParameters());

      return;
    }
    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: _choice!.id!),
    );
  }

  Future<void> _onUpdateAttribute(String valueType) async {
    if (widget.openAttributeSwitcher == null) return;

    final resultValues = Set<AttributeSwitcherChoice>.from(_getChoices());
    if (_choice != null) resultValues.add(_choice!);

    final valueHints = _getQueryValueHints();

    final tags = switch (widget.item.query) {
      final ProcessedIQLQueryDVO query => query.tags,
      final IdentityAttributeQueryDVO query => query.tags,
      _ => null,
    };

    final choice = await widget.openAttributeSwitcher!(
      valueType: valueType,
      choices: resultValues.toList(),
      currentChoice: _choice,
      valueHints: valueHints,
      tags: tags,
    );

    if (choice == null) return;

    setState(() {
      _choice = choice;
      isChecked = true;
    });

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: choice.id!),
    );
  }

  ValueHints? _getQueryValueHints() {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.valueHints,
      final ProcessedRelationshipAttributeQueryDVO query => query.valueHints,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.valueHints,
      final ProcessedIQLQueryDVO query => query.valueHints,
    };
  }

  List<AttributeSwitcherChoice> _getChoices() {
    final results = switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.results,
      final ProcessedRelationshipAttributeQueryDVO query => query.results,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.results,
      final ProcessedIQLQueryDVO query => query.results,
    };

    return results
        .map(
          (result) => (
            id: result.id,
            attribute: result.content,
            isDefaultRepositoryAttribute: result is RepositoryAttributeDVO ? result.isDefault : null,
          ),
        )
        .toList();
  }
}
