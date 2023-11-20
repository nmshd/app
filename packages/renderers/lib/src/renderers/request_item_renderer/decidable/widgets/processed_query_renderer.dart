import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';
import 'package:value_renderer/value_renderer.dart';

import '../../../widgets/value_renderer_list_tile.dart';
import '/src/request_renderer_controller.dart';
import 'identity_attribute_value_renderer.dart';
import 'relationship_attribute_value_renderer.dart';

class ProcessedIdentityAttributeQueryRenderer extends StatefulWidget {
  final ProcessedIdentityAttributeQueryDVO query;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;
  final Function(bool?)? onUpdateCheckbox;
  final bool? isChecked;
  final bool? showCheckbox;

  const ProcessedIdentityAttributeQueryRenderer({
    super.key,
    required this.query,
    this.controller,
    this.onEdit,
    this.onUpdateCheckbox,
    this.isChecked,
    this.showCheckbox,
  });

  @override
  State<ProcessedIdentityAttributeQueryRenderer> createState() => _ProcessedIdentityAttributeQueryRendererState();
}

class _ProcessedIdentityAttributeQueryRendererState extends State<ProcessedIdentityAttributeQueryRenderer> {
  final ValueRendererController _valueController = ValueRendererController();
  dynamic value;

  @override
  void initState() {
    _valueController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // setState(() => widget.controller.value.items = _valueController.value);
        setState(() => print(_valueController.value));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.query.results.isEmpty
        ? ValueRendererListTile(
            fieldName: widget.query.valueType,
            renderHints: widget.query.renderHints,
            valueHints: widget.query.valueHints,
            controller: _valueController,
            // onUpdateCheckbox: widget.onUpdateCheckbox,
            // isChecked: widget.isChecked,
            // showCheckbox: widget.showCheckbox!,
          )
        : switch (widget.query.results.first.value) {
            final IdentityAttributeValue value => IdentityAttributeValueRenderer(
                query: widget.query,
                value: value,
                controller: widget.controller,
                onEdit: widget.onEdit,
              ),
            final RelationshipAttributeValue value => RelationshipAttributeValueRenderer(results: widget.query.results, value: value),
            _ => throw Exception('Unknown AttributeValue: ${widget.query.results.first.valueType}'),
          };
  }
}

class ProcessedRelationshipAttributeQueryRenderer extends StatelessWidget {
  final ProcessedRelationshipAttributeQueryDVO query;

  const ProcessedRelationshipAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TranslatedText(query.name),
        Text(query.type),
        // Text(query.valueType),
        Text(query.owner.name),
        Text(query.attributeCreationHints.title),
        //ValueRenderer(fieldName: query.valueType, renderHints: query.renderHints, valueHints: query.valueHints),
      ],
    );
  }
}

class ProcessedThirdPartyAttributeQueryRenderer extends StatelessWidget {
  final ProcessedThirdPartyRelationshipAttributeQueryDVO query;

  const ProcessedThirdPartyAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(query.type),
        TranslatedText(query.name),
        // owner, thirdParty ...
      ],
    );
  }
}
