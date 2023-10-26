import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:renderers/src/renderers/request_item_renderer/response/propose_attribute_accept_response_item_renderer.dart';

import '../../../../renderers.dart';
import '../../request_item_group_renderer.dart';
import '../request_item_renderer.dart';
import 'response.dart';

class ResponseItemRenderer extends StatelessWidget {
  final ResponseItemDVO item;
  final List<RequestItemDVO> requestItems;
  final RequestRendererController? controller;
  final int itemIndex;
  final int? groupIndex;

  const ResponseItemRenderer({
    super.key,
    required this.item,
    required this.requestItems,
    this.controller,
    required this.itemIndex,
    this.groupIndex,
  });

  @override
  Widget build(BuildContext context) {
    final requestItemList = requestItems.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      if (item is RequestItemGroupDVO) {
        return RequestItemGroupRenderer(requestItemGroup: item, groupIndex: index);
      }

      return RequestItemRenderer(item: item, itemIndex: index);
    }).toList();

    return switch (item) {
      final ReadAttributeAcceptResponseItemDVO dvo => ReadAttributeAcceptResponseItemRenderer(item: dvo),
      final ProposeAttributeAcceptResponseItemDVO dvo =>
        ProposeAttributeAcceptResponseItemRenderer(item: dvo, itemIndex: itemIndex, controller: controller, groupIndex: groupIndex),
      final CreateAttributeAcceptResponseItemDVO dvo => Text(dvo.type),
      final ShareAttributeAcceptResponseItemDVO dvo => Text(dvo.type),
      final RegisterAttributeListenerAcceptResponseItemDVO dvo => Text(dvo.type),
      final ErrorResponseItemDVO dvo => Text(dvo.type),
      final AcceptResponseItemDVO dvo => Text(dvo.type),
      _ => switch (item.type) {
          'RejectResponseItemDVO' => Column(crossAxisAlignment: CrossAxisAlignment.start, children: requestItemList), //Add Rejected message
          _ => throw Exception("Invalid type '${item.type}'"),
        }
    };
  }
}
