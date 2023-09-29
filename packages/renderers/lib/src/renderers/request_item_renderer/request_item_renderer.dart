import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';
import 'request_item_renderers.dart';

class RequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final RequestItemDVO item;
  final RequestRendererController? controller;

  const RequestItemRenderer({super.key, required this.request, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    print(item.runtimeType);
    if (item.type.startsWith('Decidable')) return const Text('Decidable');

    return switch (item) {
      final ReadAttributeRequestItemDVO dvo => ReadAttributeRequestItemRenderer(request: request, controller: controller, item: dvo),
      final ProposeAttributeRequestItemDVO dvo => ProposeAttributeRequestItemRenderer(request: request, controller: controller, item: dvo),
      final CreateAttributeRequestItemDVO dvo => CreateAttributeRequestItemRenderer(request: request, controller: controller, item: dvo),
      final ShareAttributeRequestItemDVO dvo => ShareAttributeRequestItemRenderer(request: request, controller: controller, item: dvo),
      final AuthenticationRequestItemDVO dvo => AuthenticationRequestItemRenderer(request: request, controller: controller, item: dvo),
      final ConsentRequestItemDVO dvo => ConsentRequestItemRenderer(request: request, controller: controller, item: dvo),
      final RegisterAttributeListenerRequestItemDVO dvo =>
        RegisterAttributeListenerRequestItemRenderer(request: request, controller: controller, item: dvo),
      _ => throw Exception("Invalid type '${item.type}'"),
    };
  }
}
