import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../../request_renderer.dart';
import '../utils/query_type_resolver.dart';

class RegisterAttributeListenerRequestItemRenderer extends StatelessWidget {
  final RegisterAttributeListenerRequestItemDVO item;
  final RequestRendererController? controller;

  const RegisterAttributeListenerRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    final attributeQuery = QueryTypeResolver.resolveType(query: item.query);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.type, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text.rich(TextSpan(
          text: 'Name: ',
          children: [TextSpan(text: item.name)],
        )),
        Text.rich(TextSpan(
          text: 'Description: ',
          children: [TextSpan(text: item.description)],
        )),
        Text.rich(TextSpan(
          text: 'Date: ',
          children: [TextSpan(text: item.date)],
        )),
        Text.rich(TextSpan(
          text: 'Query: ',
          children: [TextSpan(text: attributeQuery.type)],
        )),
      ],
    );
  }
}
