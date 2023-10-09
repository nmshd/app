import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:renderers/src/renderers/request_item_renderer/widgets/query_renderer.dart';

import '../../../../renderers.dart';

class DecidableRegisterAttributeListenerRequestItemRenderer extends StatelessWidget {
  final DecidableRegisterAttributeListenerRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableRegisterAttributeListenerRequestItemRenderer({super.key, required this.item, this.controller});

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
