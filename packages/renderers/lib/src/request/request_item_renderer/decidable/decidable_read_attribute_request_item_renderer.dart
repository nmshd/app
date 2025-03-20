import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';
import 'package:renderers/renderers.dart';

import '/src/attribute/identity_attribute_value_renderer.dart';
import '/src/attribute/relationship_attribute_value_renderer.dart';
import '../../request_item_index.dart';
import 'checkbox_enabled_extension.dart';
import 'widgets/manual_decision_required.dart';

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
  // CheckboxSettings? checkboxSettings;

  AttributeSwitcherChoice? _choice;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked(widget.item.mustBeAccepted, widget.item.requireManualDecision);
    isManualDecisionAccepted = widget.item.initallyDecided;
    // checkboxSettings = (
    //   // isChecked: isChecked,
    //   // onUpdateCheckbox: widget.item.checkboxEnabled ? _onUpdateCheckbox : null,
    //   isManualDecided: isManualDecisionAccepted,
    //   onUpdateManualDecision: onUpdateManualDecision,
    // );

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
    return InkWell(
      onTap: () => _onUpdateAttribute(_getQueryValueType()!),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(value: isChecked, onChanged: widget.item.checkboxEnabled ? _onUpdateCheckbox : null),
                Expanded(child: Padding(padding: EdgeInsets.only(right: 12), child: _buildQueryRenderer())),
              ],
            ),
            if (widget.item.requireManualDecision == true) ...[
              SizedBox(height: 12),
              ManualDecisionRequired(isManualDecisionAccepted: isManualDecisionAccepted, onUpdateManualDecision: _onUpdateManualDecision),
            ],
          ],
        ),
      ),
    );
  }

  StatelessWidget _buildQueryRenderer() {
    if (_choice == null) {
      return ListTile(
        contentPadding: EdgeInsets.only(right: 24),
        visualDensity: VisualDensity.compact,
        tileColor: Theme.of(context).colorScheme.surface,
        title: Text(
          '${FlutterI18n.translate(context, 'dvo.attribute.name.${_getQueryValueType()}')}${widget.item.mustBeAccepted ? '*' : ''}',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        subtitle: TranslatedText(
          'i18n://requestRenderer.noEntry',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.outline),
        ),
        trailing: Icon(Icons.add, color: Theme.of(context).colorScheme.primary, size: 24),
      );
    }

    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => IdentityAttributeValueRenderer(
        titleOverride: (title) => '$title${widget.item.mustBeAccepted ? '*' : ''}',
        value: _choice?.attribute != null ? (_choice?.attribute as IdentityAttribute).value : query.results.first.value as IdentityAttributeValue,
        valueHints: query.valueHints,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (query.results.length > 1) Flexible(child: Text('+${query.results.length - 1}')),
            const SizedBox(width: 10),
            Icon(Icons.chevron_right),
          ],
        ),
        expandFileReference: widget.expandFileReference,
        openFileDetails: widget.openFileDetails,
      ),
      final ProcessedRelationshipAttributeQueryDVO query => RelationshipAttributeValueRenderer(
        value:
            _choice?.attribute is RelationshipAttribute
                ? (_choice?.attribute as RelationshipAttribute).value
                : query.results.first.value as RelationshipAttributeValue,
        trailing: SizedBox(width: 50, child: IconButton(onPressed: () => _onUpdateAttribute(query.valueType), icon: const Icon(Icons.chevron_right))),
        expandFileReference: widget.expandFileReference,
        openFileDetails: widget.openFileDetails,
      ),
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => RelationshipAttributeValueRenderer(
        value:
            _choice?.attribute is RelationshipAttribute
                ? (_choice?.attribute as RelationshipAttribute).value
                : query.results.first.value as RelationshipAttributeValue,
        trailing: SizedBox(
          width: 50,
          child: IconButton(onPressed: () => _onUpdateAttribute(query.valueType!), icon: const Icon(Icons.chevron_right)),
        ),
        expandFileReference: widget.expandFileReference,
        openFileDetails: widget.openFileDetails,
      ),

      final ProcessedIQLQueryDVO query => IdentityAttributeValueRenderer(
        titleOverride: (title) => '${widget.item.name}${widget.item.mustBeAccepted ? '*' : ''}',
        value:
            _choice?.attribute is IdentityAttribute
                ? (_choice?.attribute as IdentityAttribute).value
                : query.results.first.value as IdentityAttributeValue,
        valueHints: query.results.firstOrNull?.valueHints ?? query.valueHints!,
        trailing: SizedBox(
          width: 50,
          child: IconButton(onPressed: () => _onUpdateAttribute(query.valueType!), icon: const Icon(Icons.chevron_right)),
        ),
        expandFileReference: widget.expandFileReference,
        openFileDetails: widget.openFileDetails,
      ),
    };
  }

  void _onUpdateCheckbox(bool? value) {
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

  void _onUpdateManualDecision(bool? value) {
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

  String? _getQueryValueType() {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.valueType,
      final ProcessedRelationshipAttributeQueryDVO query => query.valueType,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.valueType,
      final ProcessedIQLQueryDVO query => query.valueType,
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
