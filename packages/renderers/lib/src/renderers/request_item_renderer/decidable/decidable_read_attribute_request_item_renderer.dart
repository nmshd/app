import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/request_item_index.dart';
import '../../widgets/request_renderer_controller.dart';
import '../widgets/processed_query_renderer.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableReadAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableReadAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<AbstractAttribute> Function({required String valueType})? selectAttribute;
  final LocalRequestStatus? requestStatus;

  const DecidableReadAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.selectAttribute,
    this.requestStatus,
  });

  @override
  State<DecidableReadAttributeRequestItemRenderer> createState() => _DecidableReadAttributeRequestItemRendererState();
}

class _DecidableReadAttributeRequestItemRendererState extends State<DecidableReadAttributeRequestItemRenderer> {
  bool isChecked = true;
  AbstractAttribute? newAttribute;

  @override
  void initState() {
    super.initState();

    final attribute = attributeContent(widget.item.query);

    if (attribute != null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: attribute),
      );
    }

    loadSelectedAttribute();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => ProcessedIdentityAttributeQueryRenderer(query: query),
      final ProcessedRelationshipAttributeQueryDVO query => ProcessedRelationshipAttributeQueryRenderer(query: query),
      //final ThirdPartyRelationshipAttributeQueryDVO query => ThirdPartyAttributeQueryRenderer(query: query),
      _ => throw Exception("Invalid type '${widget.item.query.type}'"),
    };
  }

  attributeContent(ProcessedAttributeQueryDVO attribute) {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.results.first.content,
      final ProcessedRelationshipAttributeQueryDVO query => query.results.first.content,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.thirdParty.first.relationship?.items.first.content,
      final ProcessedIQLQueryDVO query => query.results.first.content,
    };
  }

  void onUpdateCheckbox(bool? value) {
    setState(() {
      isChecked = value!;
    });

    final attribute = attributeContent(widget.item.query);

    handleCheckboxChange(
      isChecked: isChecked,
      controller: widget.controller,
      itemIndex: widget.itemIndex,
      acceptRequestItemParameter: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: newAttribute ?? attribute),
    );
  }

  Future<void> loadSelectedAttribute() async {
    attributeType(ProcessedAttributeQueryDVO attribute) {
      return switch (widget.item.query) {
        final ProcessedIdentityAttributeQueryDVO query => query.results.first.valueType,
        final ProcessedRelationshipAttributeQueryDVO query => query.results.first.valueType,
        final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.thirdParty.first.relationship?.items.first.valueType,
        final ProcessedIQLQueryDVO query => query.results.first.valueType,
      };
    }

    final attribute = attributeType(widget.item.query);

    if (attribute != null) {
      final selectedAttribute = await widget.selectAttribute?.call(valueType: attribute);
      if (selectedAttribute != null) {
        setState(() {
          newAttribute = selectedAttribute;
        });

        widget.controller?.writeAtIndex(
          index: widget.itemIndex,
          value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: newAttribute!),
        );
      }
    } else {
      final attribute = attributeContent(widget.item.query);

      if (attribute != null) {
        widget.controller?.writeAtIndex(
          index: widget.itemIndex,
          value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: attribute),
        );
      }
    }
  }
}
