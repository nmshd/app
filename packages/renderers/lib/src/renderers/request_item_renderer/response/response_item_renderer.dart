import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../request_item_renderer.dart';
import 'response.dart';

class ResponseItemRenderer extends StatelessWidget {
  final ResponseItemDVO item;
  final RequestItemDVO requestItem;

  const ResponseItemRenderer({super.key, required this.item, required this.requestItem});

  @override
  Widget build(BuildContext context) {
    return switch (item) {
      final ReadAttributeAcceptResponseItemDVO dvo => ReadAttributeAcceptResponseItemRenderer(item: dvo),
      final ProposeAttributeAcceptResponseItemDVO dvo => ProposeAttributeAcceptResponseItemRenderer(item: dvo),
      final CreateAttributeAcceptResponseItemDVO dvo => CreateAttributeAcceptResponseItemRenderer(item: dvo),
      final ShareAttributeAcceptResponseItemDVO dvo => ShareAttributeAcceptResponseItemRenderer(item: dvo),
      final RegisterAttributeListenerAcceptResponseItemDVO dvo => RegisterAttributeAcceptResponseItemRenderer(item: dvo),
      final ErrorResponseItemDVO dvo => Text(dvo.type),
      _ => switch (item.type) {
          'RejectResponseItemDVO' => RequestItemRenderer(item: requestItem, isRejected: true),
          _ => throw Exception("Invalid type '${item.type}'"),
        }
    };
  }
}
