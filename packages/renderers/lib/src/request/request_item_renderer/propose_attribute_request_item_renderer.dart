import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/src/attribute/attribute_renderer.dart';
import '../../custom_list_tile.dart';
import '../open_attribute_switcher_function.dart';
import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'extensions/extensions.dart';
import 'widgets/validation_error_box.dart';

class ProposeAttributeRequestItemRenderer extends StatefulWidget {
  final ProposeAttributeRequestItemDVO item;
  final RequestItemIndex itemIndex;
  final RequestRendererController? controller;
  final OpenAttributeSwitcherFunction openAttributeSwitcher;
  final RequestValidationResultDTO? validationResult;

  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;

  const ProposeAttributeRequestItemRenderer({
    required this.item,
    required this.itemIndex,
    required this.controller,
    required this.openAttributeSwitcher,
    required this.validationResult,
    required this.expandFileReference,
    required this.openFileDetails,
    super.key,
  });

  @override
  State<ProposeAttributeRequestItemRenderer> createState() => _ProposeAttributeRequestItemRendererState();
}

class _ProposeAttributeRequestItemRendererState extends State<ProposeAttributeRequestItemRenderer> {
  late bool _isChecked;
  late AttributeSwitcherChoice _choice;

  @override
  void initState() {
    super.initState();

    if (widget.item.response != null) {
      _isChecked = widget.item.response is AcceptResponseItemDVO;

      _choice = switch (widget.item.response) {
        final ProposeAttributeAcceptResponseItemDVO response => (dvo: response.attribute, attribute: response.attribute.content),
        final AttributeAlreadySharedAcceptResponseItemDVO response => (dvo: response.attribute, attribute: response.attribute.content),
        final AttributeSuccessionAcceptResponseItemDVO response => (dvo: response.successor, attribute: response.successor.content),
        _ => throw Exception('Unknown response type: ${widget.item.response.runtimeType}'),
      };
    } else {
      _isChecked = widget.item.initiallyChecked;
      _choice = _getProposedChoice();
    }

    if (_isChecked && _choice.dvo != null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: _choice.dvo!.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.item.isDecidable ? () async => await _openAttributeSwitcher(_getChoices()) : null,
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
                if (_choice.dvo != null || _getQueryValueHints() != null)
                  Expanded(
                    child: AttributeRenderer(
                      attribute: _choice.attribute,
                      valueHints: _choice.dvo?.valueHints ?? _getQueryValueHints()!,
                      trailing: widget.item.isDecidable
                          ? Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: const Icon(Icons.chevron_right))
                          : null,
                      expandFileReference: widget.expandFileReference,
                      openFileDetails: widget.openFileDetails,
                      titleOverride: widget.item.isDecidable && widget.item.mustBeAccepted ? (title) => '$title*' : null,
                      extraLine: description != null ? Text(description!, style: Theme.of(context).textTheme.labelMedium) : null,
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
    if (query is RelationshipAttributeQueryDVO) return query.attributeCreationHints.title;
    if (query is ProcessedRelationshipAttributeQueryDVO) return query.attributeCreationHints.title;

    return 'i18n://dvo.attribute.name.$_valueType';
  }

  String? get description {
    if (widget.item.description != null) return widget.item.description;

    final query = widget.item.query;
    if (query is RelationshipAttributeQueryDVO) return query.attributeCreationHints.description;
    if (query is ProcessedRelationshipAttributeQueryDVO) return query.attributeCreationHints.description;

    return null;
  }

  String get _valueType =>
      switch (widget.item.query) {
        final IdentityAttributeQueryDVO query => query.valueType,
        final RelationshipAttributeQueryDVO query => query.valueType,
        final ThirdPartyRelationshipAttributeQueryDVO _ => null,
        final IQLQueryDVO query => query.valueType,
        final ProcessedIdentityAttributeQueryDVO query => query.valueType,
        final ProcessedRelationshipAttributeQueryDVO query => query.valueType,
        final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.valueType,
        final ProcessedIQLQueryDVO query => query.valueType,
      } ??
      widget.item.attribute.valueType;

  Future<void> _openAttributeSwitcher(Set<AttributeSwitcherChoice> choices) async {
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
          ? AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: choice.attribute)
          : AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: choice.dvo!.id),
    );
  }

  void _onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() => _isChecked = value);

    if (!value) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const RejectRequestItemParameters());

      return;
    }

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: _choice.dvo == null
          ? AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: _choice.attribute)
          : AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: _choice.dvo!.id),
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

    return {...results.map((result) => (dvo: result, attribute: result.content)), _getProposedChoice(), _choice};
  }

  ({LocalAttributeDVO? dvo, AbstractAttribute attribute}) _getProposedChoice() => (dvo: null, attribute: widget.item.attribute.content);
}
