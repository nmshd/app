import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';
import 'widgets/processed_query_renderer.dart';

class DecidableProposeAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableProposeAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final int itemIndex;
  final int? groupIndex;

  const DecidableProposeAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.groupIndex,
  });

  @override
  State<DecidableProposeAttributeRequestItemRenderer> createState() => _DecidableProposeAttributeRequestItemRendererState();
}

class _DecidableProposeAttributeRequestItemRendererState extends State<DecidableProposeAttributeRequestItemRenderer> {
  @override
  void initState() {
    super.initState();

    if (widget.groupIndex != null) {
      final groupIndex = widget.groupIndex!;
      final controllerValue = widget.controller?.value?.items[groupIndex] as DecideRequestItemGroupParameters;
      controllerValue.items[widget.itemIndex] =
          AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: widget.item.attribute.id);
    }

    widget.controller?.value?.items[widget.itemIndex] =
        AcceptProposeAttributeRequestItemParametersWithExistingAttribute(attributeId: widget.item.attribute.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${widget.item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        switch (widget.item.query) {
          final ProcessedIdentityAttributeQueryDVO query => ProcessedIdentityAttributeQueryRenderer(query: query, controller: widget.controller),
          final ProcessedRelationshipAttributeQueryDVO query => ProcessedRelationshipAttributeQueryRenderer(query: query),
          final ProcessedThirdPartyRelationshipAttributeQueryDVO query => ProcessedThirdPartyAttributeQueryRenderer(query: query),
          _ => throw Exception("Invalid type '${widget.item.query.type}'"),
        },
        const SizedBox(height: 30),
      ],
    );
  }
}
