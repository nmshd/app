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
  late bool _isChecked;
  late bool _isManualDecisionAccepted;
  AttributeSwitcherChoice? _choice;

  @override
  void initState() {
    super.initState();

    _isChecked = widget.item.initiallyChecked(widget.item.mustBeAccepted, widget.item.requireManualDecision);
    _isManualDecisionAccepted = widget.item.initallyDecided;

    final choice = _getChoices().firstOrNull;
    if (choice == null) return;

    _choice = choice;

    if (_isChecked && widget.item.requireManualDecision != true) {
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(value: _isChecked, onChanged: widget.item.checkboxEnabled ? _onUpdateCheckbox : null),
                Expanded(
                  child: _ProcessedQueryRenderer(
                    choice: _choice,
                    item: widget.item,
                    valueType: _getQueryValueType(),
                    expandFileReference: widget.expandFileReference,
                    openFileDetails: widget.openFileDetails,
                    onUpdateAttribute: _onUpdateAttribute,
                  ),
                ),
              ],
            ),
            if (widget.item.requireManualDecision == true) ...[
              SizedBox(height: 12),
              ManualDecisionRequired(isManualDecisionAccepted: _isManualDecisionAccepted, onUpdateManualDecision: _onUpdateManualDecision),
            ],
          ],
        ),
      ),
    );
  }

  void _onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() {
      _isChecked = value;
    });

    if (_choice == null && value) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: ''),
      );
      return;
    }

    if ((widget.item.requireManualDecision == true && _isManualDecisionAccepted == false) || _choice == null || !value) {
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

    setState(() => _isManualDecisionAccepted = value);

    if ((widget.item.requireManualDecision == true && _isManualDecisionAccepted == false) || _choice == null) {
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

    final title = switch (widget.item.query) {
      final ProcessedRelationshipAttributeQueryDVO query => query.name,
      _ => FlutterI18n.translate(context, 'dvo.attribute.name.$valueType'),
    };

    final choice = await widget.openAttributeSwitcher!(
      valueType: valueType,
      choices: resultValues.toList(),
      currentChoice: _choice,
      valueHints: valueHints,
      tags: tags,
      title: title,
    );

    if (choice == null) return;

    setState(() {
      _choice = choice;
      _isChecked = true;
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

class _ProcessedQueryRenderer extends StatelessWidget {
  final AttributeSwitcherChoice? choice;
  final DecidableReadAttributeRequestItemDVO item;
  final String? valueType;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;
  final Future<void> Function(String) onUpdateAttribute;

  const _ProcessedQueryRenderer({
    required this.choice,
    required this.item,
    required this.valueType,
    required this.expandFileReference,
    required this.openFileDetails,
    required this.onUpdateAttribute,
  });

  @override
  Widget build(BuildContext context) {
    if (choice == null) {
      return ListTile(
        contentPadding: EdgeInsets.only(right: 12),
        visualDensity: VisualDensity.compact,
        title: Text(
          _getTitle(context),
          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TranslatedText(
              'i18n://requestRenderer.noEntry',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.outline),
            ),
            if (item.description != null) Text(item.description!),
          ],
        ),
        trailing: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
      );
    }

    return switch (item.query) {
      final ProcessedIdentityAttributeQueryDVO query => IdentityAttributeValueRenderer(
        titleOverride: (title) => '$title${item.mustBeAccepted ? '*' : ''}',
        value: choice?.attribute != null ? (choice?.attribute as IdentityAttribute).value : query.results.first.value as IdentityAttributeValue,
        valueHints: query.valueHints,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (query.results.length > 1) Flexible(child: Text('+${query.results.length - 1}')),
            const SizedBox(width: 10),
            Icon(Icons.chevron_right),
          ],
        ),
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),
      final ProcessedRelationshipAttributeQueryDVO query => RelationshipAttributeValueRenderer(
        value:
            choice?.attribute is RelationshipAttribute
                ? (choice?.attribute as RelationshipAttribute).value
                : query.results.first.value as RelationshipAttributeValue,
        trailing: SizedBox(width: 50, child: IconButton(onPressed: () => onUpdateAttribute(query.valueType), icon: const Icon(Icons.chevron_right))),
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => RelationshipAttributeValueRenderer(
        value:
            choice?.attribute is RelationshipAttribute
                ? (choice?.attribute as RelationshipAttribute).value
                : query.results.first.value as RelationshipAttributeValue,
        trailing: SizedBox(width: 50, child: IconButton(onPressed: () => onUpdateAttribute(query.valueType!), icon: const Icon(Icons.chevron_right))),
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),

      final ProcessedIQLQueryDVO query => IdentityAttributeValueRenderer(
        titleOverride: (title) => '${item.name}${item.mustBeAccepted ? '*' : ''}',
        value:
            choice?.attribute is IdentityAttribute
                ? (choice?.attribute as IdentityAttribute).value
                : query.results.first.value as IdentityAttributeValue,
        valueHints: query.results.firstOrNull?.valueHints ?? query.valueHints!,
        trailing: SizedBox(width: 50, child: IconButton(onPressed: () => onUpdateAttribute(query.valueType!), icon: const Icon(Icons.chevron_right))),
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),
    };
  }

  String _getTitle(BuildContext context) {
    final title = switch (item.query) {
      final ProcessedRelationshipAttributeQueryDVO query => query.name,
      _ => FlutterI18n.translate(context, 'dvo.attribute.name.$valueType'),
    };
    return '$title${item.mustBeAccepted ? '*' : ''}';
  }
}
