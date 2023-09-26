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
    return switch (item.type) {
      'ReadAttributeRequestItemDVO' => ReadAttributeRequestItemRenderer(controller: controller, item: item),
      'ProposeAttributeRequestItemDVO' => const ProposeAttributeRequestItemRenderer(),
      'CreateAttributeRequestItemDVO' => const CreateAttributeRequestItemRenderer(),
      'ShareAttributeRequestItemDVO' => const ShareAttributeRequestItemRenderer(),
      'AuthenticationRequestItemDVO' => const AuthenticationRequestItemRenderer(),
      'ConsentRequestItemDVO' => const ConsentRequestItemRenderer(),
      'RegisterAttributeListenerRequestItemDVO' => const RegisterAttributeListenerRequestItemRenderer(),
      _ => throw Exception("Invalid type '${item.type}'"),
    };
  }
}
