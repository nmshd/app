import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '/src/request_item_index.dart';
import '/src/request_renderer_controller.dart';
import 'error_response_item_renderer.dart';
import 'reject_response_item_renderer.dart';
import 'response.dart';

class ResponseItemRenderer extends StatelessWidget {
  final ResponseItemDVO responseItem;
  final RequestItemDVO requestItem;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const ResponseItemRenderer({
    super.key,
    this.controller,
    required this.itemIndex,
    required this.responseItem,
    required this.requestItem,
  });

  @override
  Widget build(BuildContext context) {
    return switch (responseItem) {
      final ReadAttributeAcceptResponseItemDVO dvo => ReadAttributeAcceptResponseItemRenderer(item: dvo),
      final ProposeAttributeAcceptResponseItemDVO dvo => ProposeAttributeAcceptResponseItemRenderer(item: dvo),
      final CreateAttributeAcceptResponseItemDVO dvo => CreateAttributeAcceptResponseItemRenderer(item: dvo),
      final ShareAttributeAcceptResponseItemDVO dvo => ShareAttributeAcceptResponseItemRenderer(item: dvo),
      final RegisterAttributeListenerAcceptResponseItemDVO dvo => RegisterAttributeListenerAcceptResponseItemRenderer(item: dvo),
      final RejectResponseItemDVO _ => RejectResponseItemRenderer(item: requestItem, itemIndex: itemIndex),
      final ErrorResponseItemDVO dvo => ErrorResponseItemRenderer(item: dvo),
      _ => throw Exception("Invalid type '${responseItem.type}'"),
    };
  }
}
