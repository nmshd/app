import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';
import 'widgets/query_renderer.dart';

class RegisterAttributeListenerRequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final RegisterAttributeListenerRequestItemDVO item;
  final RequestRendererController? controller;

  const RegisterAttributeListenerRequestItemRenderer({super.key, required this.request, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.type, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Text('Query: '),
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
