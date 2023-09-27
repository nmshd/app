import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../request_renderer.dart';
import 'request_item_renderers.dart';

class RequestItemRenderer extends StatelessWidget {
  final RequestItemDVO item;
  final RequestRendererController? controller;

  const RequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    if (item.type.startsWith('Decidable')) return const Text('Decidable');

    return switch (item) {
      final ReadAttributeRequestItemDVO dvo => ReadAttributeRequestItemRenderer(controller: controller, item: dvo),
      final ProposeAttributeRequestItemDVO dvo => ProposeAttributeRequestItemRenderer(controller: controller, item: dvo),
      final CreateAttributeRequestItemDVO dvo => CreateAttributeRequestItemRenderer(controller: controller, item: dvo),
      final ShareAttributeRequestItemDVO dvo => ShareAttributeRequestItemRenderer(controller: controller, item: dvo),
      final AuthenticationRequestItemDVO dvo => AuthenticationRequestItemRenderer(controller: controller, item: dvo),
      final ConsentRequestItemDVO dvo => ConsentRequestItemRenderer(controller: controller, item: dvo),
      final RegisterAttributeListenerRequestItemDVO dvo => RegisterAttributeListenerRequestItemRenderer(controller: controller, item: dvo),
      _ => throw Exception("Invalid type '${item.type}'"),
    };
  }
}
