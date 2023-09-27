import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../../request_renderer.dart';
import '../utils/query_type_resolver.dart';

class ReadAttributeRequestItemRenderer extends StatelessWidget {
  final ReadAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const ReadAttributeRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    final attributeQuery = QueryTypeResolver.resolveType(query: item.query);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.type, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(attributeQuery.type),
      ],
    );
  }
}

class IdentityAttributeQueryRenderer extends StatelessWidget {
  final IdentityAttributeQueryDVO query;

  const IdentityAttributeQueryRenderer({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Text(query.type);
  }
}
