import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'response.dart';

class ResponseItemRenderer extends StatelessWidget {
  final ResponseItemDVO item;
  final List<RequestItemDVO> requestItems;

  const ResponseItemRenderer({super.key, required this.item, required this.requestItems});

  @override
  Widget build(BuildContext context) {
    final requestItemList = requestItems.map((item) {
      // if (item is RequestItemGroupDVO) {
      //   return RequestItemGroupRenderer(requestItemGroup: item);
      // }

      // return RequestItemRenderer(item: item);
    }).toList();

    return switch (item) {
      final ReadAttributeAcceptResponseItemDVO dvo => ReadAttributeAcceptResponseItemRenderer(item: dvo),
      final ProposeAttributeAcceptResponseItemDVO dvo => Text(dvo.type),
      final CreateAttributeAcceptResponseItemDVO dvo => Text(dvo.type),
      final ShareAttributeAcceptResponseItemDVO dvo => Text(dvo.type),
      final RegisterAttributeListenerAcceptResponseItemDVO dvo => Text(dvo.type),
      final ErrorResponseItemDVO dvo => Text(dvo.type),
      _ => switch (item.type) {
          // 'RejectResponseItemDVO' => Column(crossAxisAlignment: CrossAxisAlignment.start, children: requestItemList), //Add Rejected message
          _ => throw Exception("Invalid type '${item.type}'"),
        }
    };
  }
}
