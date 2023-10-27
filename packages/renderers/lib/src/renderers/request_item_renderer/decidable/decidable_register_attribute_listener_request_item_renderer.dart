import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:renderers/src/renderers/request_item_renderer/widgets/query_renderer.dart';

import '../../../../renderers.dart';

class DecidableRegisterAttributeListenerRequestItemRenderer extends StatefulWidget {
  final DecidableRegisterAttributeListenerRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const DecidableRegisterAttributeListenerRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
  });

  @override
  State<DecidableRegisterAttributeListenerRequestItemRenderer> createState() => _DecidableRegisterAttributeListenerRequestItemRendererState();
}

class _DecidableRegisterAttributeListenerRequestItemRendererState extends State<DecidableRegisterAttributeListenerRequestItemRenderer> {
  @override
  void initState() {
    super.initState();

    if (widget.itemIndex.innerIndex != null) {
      final groupIndex = widget.itemIndex.innerIndex!;
      final controllerValue = widget.controller?.value?.items[groupIndex] as DecideRequestItemGroupParameters;
      controllerValue.items[widget.itemIndex.rootIndex] = const AcceptRequestItemParameters();
    }

    widget.controller?.value?.items[widget.itemIndex.rootIndex] = const AcceptRequestItemParameters();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${widget.item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        switch (widget.item.query) {
          final IdentityAttributeQueryDVO query => IdentityAttributeQueryRenderer(query: query),
          final RelationshipAttributeQueryDVO query => RelationshipAttributeQueryRenderer(query: query),
          final ThirdPartyRelationshipAttributeQueryDVO query => ThirdPartyAttributeQueryRenderer(query: query),
          _ => throw Exception("Invalid type '${widget.item.query.type}'"),
        },
        const SizedBox(height: 30),
      ],
    );
  }
}
