import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';
import '../widgets/processed_query_renderer.dart';

class DecidableProposeAttributeRequestItemRenderer extends StatelessWidget {
  final DecidableProposeAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableProposeAttributeRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        switch (item.query) {
          final ProcessedIdentityAttributeQueryDVO query => ProcessedIdentityAttributeQueryRenderer(query: query, controller: controller),
          final ProcessedRelationshipAttributeQueryDVO query => ProcessedRelationshipAttributeQueryRenderer(query: query),
          final ProcessedThirdPartyRelationshipAttributeQueryDVO query => ProcessedThirdPartyAttributeQueryRenderer(query: query),
          _ => throw Exception("Invalid type '${item.query.type}'"),
        },
        const SizedBox(height: 30),
      ],
    );
  }
}
