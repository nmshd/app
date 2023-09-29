import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';
import 'utils/query_renderer.dart';

class ProposeAttributeRequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final ProposeAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const ProposeAttributeRequestItemRenderer({super.key, required this.request, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
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
        // Text.rich(TextSpan(
        //   text: 'Date: ',
        //   children: [TextSpan(text: DateTime.parse(item.date!).toString())],
        // )),
        Row(
          children: [
            const Text('Query: '),
            QueryRenderer.render(query: item.query),
          ],
        )
      ],
    );
  }
}
