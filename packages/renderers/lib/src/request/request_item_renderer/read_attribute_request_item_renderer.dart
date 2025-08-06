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

class ReadAttributeRequestItemRenderer extends StatefulWidget {
  final String currentAddress;
  final ReadAttributeRequestItemDVO item;
  final RequestItemIndex itemIndex;
  final RequestRendererController? controller;
  final OpenAttributeSwitcherFunction? openAttributeSwitcher;
  final RequestValidationResultDTO? validationResult;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO) openFileDetails;

  const ReadAttributeRequestItemRenderer({
    super.key,
    required this.currentAddress,
    required this.item,
    required this.itemIndex,
    required this.controller,
    required this.openAttributeSwitcher,
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
        final ReadAttributeAcceptResponseItemDVO response => (id: response.attribute.id, attribute: response.attribute.content),
        final AttributeAlreadySharedAcceptResponseItemDVO response => (id: response.attribute.id, attribute: response.attribute.content),
        final AttributeSuccessionAcceptResponseItemDVO response => (id: response.successor.id, attribute: response.successor.content),
        _ => null,
      };
    } else {
      _isChecked = widget.item.initiallyChecked;
      _choice = _getChoices().firstOrNull;
    }

    if (_isChecked && _choice != null && _choice!.id != null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: _choice!.id!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: show the help line

    return InkWell(
      onTap: _onUpdateAttribute,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                // TODO: disable the checkbox if no value can be selected?
                Checkbox(value: _isChecked, onChanged: widget.item.checkboxEnabled ? _onUpdateCheckbox : null),
                if (_choice != null)
                  Expanded(
                    child: AttributeRenderer(
                      attribute: _choice!.attribute,
                      valueHints: _getQueryValueHints()!,
                      trailing: SizedBox(
                        width: 50,
                        child: IconButton(onPressed: () => _onUpdateAttribute(), icon: const Icon(Icons.chevron_right)),
                      ),
                      expandFileReference: widget.expandFileReference,
                      openFileDetails: widget.openFileDetails,
                      titleOverride: widget.item.isDecidable && widget.item.mustBeAccepted ? (title) => '$title*' : null,
                    ),
                  )
                else if (widget.item.query is ProcessedThirdPartyRelationshipAttributeQueryDVO)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TranslatedText(
                        'i18n://dvo.attributeQuery.ThirdPartyRelationshipAttributeQuery.noResults',
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  )
                else ...[
                  Expanded(
                    child: CustomListTile(
                      title: 'i18n://dvo.attribute.name.$_valueType',
                      showTitle: true,
                      valueTextStyle: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.outlineVariant),
                      description: 'Kein Eintrag',
                      trailing: SizedBox(
                        width: 50,
                        child: IconButton(
                          onPressed: () => _onUpdateAttribute(),
                          icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      titleOverride: widget.item.isDecidable && widget.item.mustBeAccepted ? (title) => '$title*' : null,
                    ),
                  ),
                ],
              ],
            ),
            if (widget.validationResult != null && !widget.validationResult!.isSuccess)
              Padding(
                padding: const EdgeInsets.only(left: 48.0, top: 8.0),
                child: TranslatedText(widget.validationResult!.code!, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12)),
              ),
          ],
        ),
      ),
    );
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

  Future<void> _onUpdateAttribute() async {
    final valueType = _valueType;

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
      _isChecked = true;
    });

    if (choice.id != null) throw Exception('Choice should not have an ID when updating an attribute');

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: choice.id!),
    );
  }

  void _onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() {
      _isChecked = value;
    });

    if (_choice == null || !value) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const RejectRequestItemParameters());

      return;
    }

    final choice = _choice!;

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: choice.id!),
    );
  }

  ValueHints? _getQueryValueHints() {
    return switch (widget.item.query as ProcessedAttributeQueryDVO) {
      final ProcessedIdentityAttributeQueryDVO query => query.valueHints,
      final ProcessedRelationshipAttributeQueryDVO query => query.valueHints,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.valueHints,
      final ProcessedIQLQueryDVO query => query.valueHints,
    };
  }

  List<({String id, AbstractAttribute attribute})> _getChoices() {
    final results = switch (widget.item.query as ProcessedAttributeQueryDVO) {
      final ProcessedIdentityAttributeQueryDVO query => query.results,
      final ProcessedRelationshipAttributeQueryDVO query => query.results,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.results,
      final ProcessedIQLQueryDVO query => query.results,
    };

    return results.map((result) => (id: result.id, attribute: result.content)).toList();
  }
}
