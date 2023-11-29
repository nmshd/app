import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';
import '../widgets/processed_query_renderer.dart';
import '/src/request_item_index.dart';
import '/src/request_renderer_controller.dart';

class DecidableReadAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableReadAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;
  final RequestItemIndex itemIndex;
  final Future<AbstractAttribute> Function({required String valueType})? selectAttribute;
  final LocalRequestStatus? requestStatus;

  const DecidableReadAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    this.onEdit,
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

  void onUpdateCheckbox(bool? value) {
    setState(() {
      isChecked = value!;
    });

    if (isChecked) {
      final attribute = switch (widget.item.query) {
        final ProcessedIdentityAttributeQueryDVO query => query.results.first.content,
        final ProcessedRelationshipAttributeQueryDVO query => query.results.first.content,
        final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.thirdParty.first.relationship?.items.first.content,
        final ProcessedIQLQueryDVO query => query.results.first.content,
      };

      if (attribute != null) {
        widget.controller?.writeAtIndex(
          index: widget.itemIndex,
          value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: newAttribute ?? attribute),
        );
      }
    } else {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: const RejectRequestItemParameters(),
      );
    }
  }

  Future<void> loadSelectedAttribute() async {
    final attribute = switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.results.first.valueType,
      final ProcessedRelationshipAttributeQueryDVO query => query.results.first.valueType,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.thirdParty.first.relationship?.items.first.valueType,
      final ProcessedIQLQueryDVO query => query.results.first.valueType,
    };

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
      final attribute = switch (widget.item.query) {
        final ProcessedIdentityAttributeQueryDVO query => query.results.first.content,
        final ProcessedRelationshipAttributeQueryDVO query => query.results.first.content,
        final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.thirdParty.first.relationship?.items.first.content,
        final ProcessedIQLQueryDVO query => query.results.first.content,
      };

      if (attribute != null) {
        widget.controller?.writeAtIndex(
          index: widget.itemIndex,
          value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: attribute),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    final attribute = switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.results.first.content,
      final ProcessedRelationshipAttributeQueryDVO query => query.results.first.content,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.thirdParty.first.relationship?.items.first.content,
      final ProcessedIQLQueryDVO query => query.results.first.content,
    };

    if (isChecked) {
      if (attribute != null) {
        widget.controller?.writeAtIndex(
          index: widget.itemIndex,
          value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: attribute),
        );
      }
    }
    loadSelectedAttribute();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => ProcessedIdentityAttributeQueryRenderer(query: query, onEdit: widget.onEdit),
      final ProcessedRelationshipAttributeQueryDVO query => ProcessedRelationshipAttributeQueryRenderer(query: query),
      //final ThirdPartyRelationshipAttributeQueryDVO query => ThirdPartyAttributeQueryRenderer(query: query),
      _ => throw Exception("Invalid type '${widget.item.query.type}'"),
    };
  }
}
