import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';
import 'widgets/processed_query_renderer.dart';

class DecidableReadAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableReadAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;
  final RequestItemIndex itemIndex;

  const DecidableReadAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    this.onEdit,
    required this.itemIndex,
  });

  @override
  State<DecidableReadAttributeRequestItemRenderer> createState() => _DecidableReadAttributeRequestItemRendererState();
}

class _DecidableReadAttributeRequestItemRendererState extends State<DecidableReadAttributeRequestItemRenderer> {
  @override
  void initState() {
    super.initState();

    if (widget.itemIndex.innerIndex != null) {
      final groupIndex = widget.itemIndex.innerIndex!;
      final controllerValue = widget.controller?.value?.items[groupIndex] as DecideRequestItemGroupParameters;
      controllerValue.items[widget.itemIndex.rootIndex] = controllerValue.items[widget.itemIndex.rootIndex] =
          AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: widget.item.query.id);
    }

    widget.controller?.value?.items[widget.itemIndex.rootIndex] =
        AcceptReadAttributeRequestItemParametersWithExistingAttribute(existingAttributeId: widget.item.query.id);
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => ProcessedIdentityAttributeQueryRenderer(query: query, onEdit: widget.onEdit),
      //final RelationshipAttributeQueryDVO query => RelationshipAttributeQueryRenderer(query: query),
      //final ThirdPartyRelationshipAttributeQueryDVO query => ThirdPartyAttributeQueryRenderer(query: query),
      _ => throw Exception("Invalid type '${widget.item.query.type}'"),
    };
  }
}
