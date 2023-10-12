import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';
import 'widgets/processed_query_renderer.dart';

class DecidableReadAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableReadAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const DecidableReadAttributeRequestItemRenderer({super.key, required this.item, this.controller, this. onEdit});

  @override
  State<DecidableReadAttributeRequestItemRenderer> createState() => _DecidableReadAttributeRequestItemRendererState();
}

class _DecidableReadAttributeRequestItemRendererState extends State<DecidableReadAttributeRequestItemRenderer> {
  @override
  void initState() {
    super.initState();

    widget.controller?.value = widget.item.query;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Text('(${widget.item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        switch (widget.item.query) {
          final ProcessedIdentityAttributeQueryDVO query => ProcessedIdentityAttributeQueryRenderer(query: query, onEdit: widget.onEdit),
          //final RelationshipAttributeQueryDVO query => RelationshipAttributeQueryRenderer(query: query),
          //final ThirdPartyRelationshipAttributeQueryDVO query => ThirdPartyAttributeQueryRenderer(query: query),
          _ => throw Exception("Invalid type '${widget.item.query.type}'"),
        },
        const SizedBox(height: 30),
      ],
    );
  }
}
