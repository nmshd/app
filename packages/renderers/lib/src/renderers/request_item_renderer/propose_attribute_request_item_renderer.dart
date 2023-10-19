import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';
import 'widgets/query_renderer.dart';

class ProposeAttributeRequestItemRenderer extends StatefulWidget {
  final ProposeAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const ProposeAttributeRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  State<ProposeAttributeRequestItemRenderer> createState() => _ProposeAttributeRequestItemRendererState();
}

class _ProposeAttributeRequestItemRendererState extends State<ProposeAttributeRequestItemRenderer> {
  late AcceptProposeAttributeRequestItemParametersWithNewAttribute canAccept;

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
