import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '/src/request_item_index.dart';
import '/src/request_renderer_controller.dart';
import 'widgets/processed_query_renderer.dart';

class DecidableProposeAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableProposeAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<AbstractAttribute> Function()? selectAttribute;
  final LocalRequestStatus? requestStatus;

  const DecidableProposeAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.selectAttribute,
    this.requestStatus,
  });

  @override
  State<DecidableProposeAttributeRequestItemRenderer> createState() => _DecidableProposeAttributeRequestItemRendererState();
}

class _DecidableProposeAttributeRequestItemRendererState extends State<DecidableProposeAttributeRequestItemRenderer> {
  bool isChecked = true;

  void onUpdateCheckbox(bool? value) {
    setState(() {
      isChecked = value!;
    });

    if (isChecked) {
      _loadSelectedAttribute();
    } else {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: const RejectRequestItemParameters(),
      );
    }
  }

  Future<void> _loadSelectedAttribute() async {
    final selectedAttribute = widget.selectAttribute?.call();
    if (selectedAttribute != null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: await selectedAttribute),
      );
    } else {
      final attribute = switch (widget.item.attribute) {
        final DraftIdentityAttributeDVO dvo => dvo.content,
        final DraftRelationshipAttributeDVO dvo => dvo.content,
      };

      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptProposeAttributeRequestItemParametersWithNewAttribute(attribute: attribute),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _loadSelectedAttribute();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${widget.item.type} )', style: const TextStyle(fontStyle: FontStyle.italic)),
        switch (widget.item.query) {
          final ProcessedIdentityAttributeQueryDVO query => ProcessedIdentityAttributeQueryRenderer(
              query: query,
              controller: widget.controller,
              onUpdateCheckbox: onUpdateCheckbox,
              isChecked: isChecked,
              showCheckbox: widget.requestStatus != LocalRequestStatus.ManualDecisionRequired && widget.item.mustBeAccepted ? false : true,
            ),
          final ProcessedRelationshipAttributeQueryDVO query => ProcessedRelationshipAttributeQueryRenderer(query: query),
          final ProcessedThirdPartyRelationshipAttributeQueryDVO query => ProcessedThirdPartyAttributeQueryRenderer(query: query),
          _ => throw Exception("Invalid type '${widget.item.query.type}'"),
        },
        const SizedBox(height: 30),
      ],
    );
  }
}
