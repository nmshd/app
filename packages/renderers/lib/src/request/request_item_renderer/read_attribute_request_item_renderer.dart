import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '/src/attribute/attribute_renderer.dart';
import '../../custom_list_tile.dart';
import '../open_attribute_switcher_function.dart';
import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'decidable/checkbox_enabled_extension.dart';
import 'extensions/extensions.dart';
import 'widgets/validation_error_box.dart';

class ReadAttributeRequestItemRenderer extends StatefulWidget {
  final ReadAttributeRequestItemDVO item;
  final RequestItemIndex itemIndex;
  final RequestRendererController? controller;
  final OpenAttributeSwitcherFunction openAttributeSwitcher;
  final CreateIdentityAttributeFunction createIdentityAttribute;
  final ComposeRelationshipAttributeFunction composeRelationshipAttribute;
  final RequestValidationResultDTO? validationResult;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;

  const ReadAttributeRequestItemRenderer({
    super.key,
    required this.item,
    required this.itemIndex,
    required this.controller,
    required this.openAttributeSwitcher,
    required this.createIdentityAttribute,
    required this.composeRelationshipAttribute,
    required this.validationResult,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
  });

  @override
  State<ReadAttributeRequestItemRenderer> createState() => _ReadAttributeRequestItemRendererState();
}

class _ReadAttributeRequestItemRendererState extends State<ReadAttributeRequestItemRenderer> {
  late bool _isChecked;
  AttributeSwitcherChoice? _choice;

  @override
  void initState() {
    super.initState();

    if (widget.item.response != null) {
      _isChecked = widget.item.response is AcceptResponseItemDVO;

      _choice = switch (widget.item.response) {
        final ReadAttributeAcceptResponseItemDVO response => (dvo: response.attribute, attribute: response.attribute.content),
        final AttributeAlreadySharedAcceptResponseItemDVO response => (dvo: response.attribute, attribute: response.attribute.content),
        final AttributeSuccessionAcceptResponseItemDVO response => (dvo: response.successor, attribute: response.successor.content),
        _ => null,
      };
    } else {
      _isChecked = widget.item.initiallyChecked;
      _choice = _getChoices().firstOrNull;
    }

    if (_isChecked && _choice != null && _choice!.dvo != null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: _choice!.dvo!.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.item.isDecidable ? _onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          spacing: 8,
          children: [
            Row(
              spacing: 8,
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: widget.item.isDecidable && widget.item.checkboxEnabled && _getChoices().isNotEmpty ? _onUpdateCheckbox : null,
                ),
                if (_choice != null && (_choice!.dvo != null || _getQueryValueHints() != null))
                  Expanded(
                    child: AttributeRenderer(
                      attribute: _choice!.attribute,
                      valueHints: _choice!.dvo?.valueHints ?? _getQueryValueHints()!,
                      trailing: widget.item.isDecidable
                          ? Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: const Icon(Icons.chevron_right))
                          : null,
                      expandFileReference: widget.expandFileReference,
                      openFileDetails: widget.openFileDetails,
                      titleOverride: widget.item.isDecidable && widget.item.mustBeAccepted ? (title) => '$title*' : null,
                      extraLine: description != null ? Text(description!, style: Theme.of(context).textTheme.labelMedium) : null,
                    ),
                  )
                else if (_valueType == null)
                  // TODO(jkoenig134): this case currently handles at least two different scenarios
                  // 1. ThirdPartyRelationshipAttributeQueryDVO without results
                  // 2. IQLQuery without results and without a valueType that can be composed
                  // there MUST be a better way to actually find out if we really cannot compose an attribute
                  // and the translation i18n string should be more generic (currently it is only for the third party relationship query)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        children: [
                          TranslatedText(
                            'i18n://dvo.attributeQuery.ThirdPartyRelationshipAttributeQuery.noResults',
                            style: TextStyle(color: Theme.of(context).colorScheme.error),
                          ),
                          if (widget.item.description != null) Text(widget.item.description!, style: Theme.of(context).textTheme.labelMedium),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: CustomListTile(
                      title: title,
                      showTitle: true,
                      valueTextStyle: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.outlineVariant),
                      description: 'i18n://requestRenderer.noEntry',
                      trailing: widget.item.isDecidable
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
                            )
                          : null,
                      titleOverride: widget.item.isDecidable && widget.item.mustBeAccepted ? (title) => '$title*' : null,
                      extraLine: description != null ? Text(description!, style: Theme.of(context).textTheme.labelMedium) : null,
                    ),
                  ),
              ],
            ),
            if (!(widget.validationResult?.isSuccess ?? true)) ValidationErrorBox(validationResult: widget.validationResult!),
          ],
        ),
      ),
    );
  }

  String get title {
    final query = widget.item.query;
    if (query is RelationshipAttributeQueryDVO) {
      return query.attributeCreationHints.title;
    }

    if (query is ProcessedRelationshipAttributeQueryDVO) {
      return query.attributeCreationHints.title;
    }

    return 'i18n://dvo.attribute.name.$_valueType';
  }

  String? get description {
    if (widget.item.description != null) return widget.item.description;

    final query = widget.item.query;
    if (query is RelationshipAttributeQueryDVO) return query.attributeCreationHints.description;
    if (query is ProcessedRelationshipAttributeQueryDVO) return query.attributeCreationHints.description;

    return null;
  }

  String? get _valueType => switch (widget.item.query) {
    final IdentityAttributeQueryDVO query => query.valueType,
    final RelationshipAttributeQueryDVO query => query.valueType,
    final ThirdPartyRelationshipAttributeQueryDVO _ => null,
    final IQLQueryDVO query => query.valueType,
    final ProcessedIdentityAttributeQueryDVO query => query.valueType,
    final ProcessedRelationshipAttributeQueryDVO query => query.valueType,
    final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.valueType,
    final ProcessedIQLQueryDVO query => query.valueType,
  };

  Future<void> _onTap() async {
    final choices = _getChoices();
    if (_choice != null) choices.add(_choice!);

    if (choices.isEmpty) return await _createAttribute();

    await _openAttributeSwitcher(choices);
  }

  Future<void> _createAttribute() async {
    final query = widget.item.query;
    if (query is ProcessedIdentityAttributeQueryDVO) return await _createIdentityAttribute();
    if (query is ProcessedRelationshipAttributeQueryDVO) return await _composeRelationshipAttribute(query);

    // this should never happen
    throw Exception('Cannot create attribute for query: ${query.runtimeType}');
  }

  Future<void> _createIdentityAttribute() async {
    final choice = await widget.createIdentityAttribute(valueType: _valueType!);
    if (choice == null || !mounted) return;

    setState(() {
      _choice = choice;
      _isChecked = true;
    });

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: choice.dvo.id),
    );
  }

  Future<void> _composeRelationshipAttribute(ProcessedRelationshipAttributeQueryDVO query) async {
    final attribute = await widget.composeRelationshipAttribute(query: query);
    if (attribute == null || !mounted) return;

    setState(() {
      _choice = (dvo: null, attribute: attribute);
      _isChecked = true;
    });

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: attribute),
    );
  }

  Future<void> _openAttributeSwitcher(Set<AttributeSwitcherChoice> choices) async {
    final query = widget.item.query;
    // TODO(jkoenig134): this is a workaround for the fact that we cannot really switch between relationship attributes that are not stored yet
    if (query is ProcessedRelationshipAttributeQueryDVO && _getChoices().isEmpty) {
      return await _composeRelationshipAttribute(query);
    }

    final valueType = _valueType;

    final valueHints = _getQueryValueHints();

    final choice = await widget.openAttributeSwitcher(
      valueType: valueType,
      choices: choices.toList(),
      currentChoice: _choice,
      valueHints: valueHints,
    );

    if (choice == null) return;

    setState(() {
      _choice = choice;
      _isChecked = true;
    });

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: choice.dvo == null
          ? AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: choice.attribute)
          : AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: choice.dvo!.id),
    );
  }

  void _onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() => _isChecked = value);

    if (_choice == null || !value) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const RejectRequestItemParameters());

      return;
    }

    final choice = _choice!;

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: choice.dvo == null
          ? AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: choice.attribute)
          : AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: choice.dvo!.id),
    );
  }

  ValueHints? _getQueryValueHints() {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.valueHints,
      final ProcessedRelationshipAttributeQueryDVO query => query.valueHints,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.valueHints ?? query.results.firstOrNull?.valueHints,
      final ProcessedIQLQueryDVO query => query.valueHints,
      final IdentityAttributeQueryDVO query => query.valueHints,
      final RelationshipAttributeQueryDVO query => query.valueHints,
      final ThirdPartyRelationshipAttributeQueryDVO _ => null,
      final IQLQueryDVO query => query.valueHints,
    };
  }

  Set<AttributeSwitcherChoice> _getChoices() {
    final results = switch (widget.item.query as ProcessedAttributeQueryDVO) {
      final ProcessedIdentityAttributeQueryDVO query => query.results,
      final ProcessedRelationshipAttributeQueryDVO query => query.results,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.results,
      final ProcessedIQLQueryDVO query => query.results,
    };

    return results.map<AttributeSwitcherChoice>((result) => (dvo: result, attribute: result.content)).toSet();
  }
}
