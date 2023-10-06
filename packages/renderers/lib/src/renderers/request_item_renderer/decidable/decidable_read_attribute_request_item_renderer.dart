import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';
import 'widgets/processed_query_renderer.dart';

class DecidableReadAttributeRequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final DecidableReadAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableReadAttributeRequestItemRenderer({super.key, required this.request, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.type, style: const TextStyle(fontWeight: FontWeight.bold)),
        switch (item.query) {
          final ProcessedIdentityAttributeQueryDVO query => ProcessedIdentityAttributeQueryRenderer(query: query),
          //final RelationshipAttributeQueryDVO query => RelationshipAttributeQueryRenderer(query: query),
          //final ThirdPartyRelationshipAttributeQueryDVO query => ThirdPartyAttributeQueryRenderer(query: query),
          _ => throw Exception("Invalid type '${item.query.type}'"),
        },
        const SizedBox(height: 30),
      ],
    );
  }
}
