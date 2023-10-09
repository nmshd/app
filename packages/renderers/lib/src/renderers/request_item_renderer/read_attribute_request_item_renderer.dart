import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';
import 'widgets/query_renderer.dart';

class ReadAttributeRequestItemRenderer extends StatelessWidget {
  final ReadAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const ReadAttributeRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        switch (item.query) {
          final IdentityAttributeQueryDVO query => IdentityAttributeQueryRenderer(query: query),
          final RelationshipAttributeQueryDVO query => RelationshipAttributeQueryRenderer(query: query),
          final ThirdPartyRelationshipAttributeQueryDVO query => ThirdPartyAttributeQueryRenderer(query: query),
          _ => throw Exception("Invalid type '${item.query.type}'"),
        },
        const SizedBox(height: 30),
      ],
    );
  }
}
