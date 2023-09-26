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

    return switch (item.type) {
      'ReadAttributeRequestItemDVO' => ReadAttributeRequestItemRenderer(controller: controller, item: item as ReadAttributeRequestItemDVO),
      'ProposeAttributeRequestItemDVO' => ProposeAttributeRequestItemRenderer(controller: controller, item: item as ProposeAttributeRequestItemDVO),
      'CreateAttributeRequestItemDVO' => CreateAttributeRequestItemRenderer(controller: controller, item: item as CreateAttributeRequestItemDVO),
      'ShareAttributeRequestItemDVO' => ShareAttributeRequestItemRenderer(controller: controller, item: item as ShareAttributeRequestItemDVO),
      'AuthenticationRequestItemDVO' => AuthenticationRequestItemRenderer(controller: controller, item: item as AuthenticationRequestItemDVO),
      'ConsentRequestItemDVO' => ConsentRequestItemRenderer(controller: controller, item: item as ConsentRequestItemDVO),
      'RegisterAttributeListenerRequestItemDVO' => RegisterAttributeListenerRequestItemRenderer(
          controller: controller,
          item: item as RegisterAttributeListenerRequestItemDVO,
        ),
      _ => throw Exception("Invalid type '${item.type}'"),
    };
  }
}
