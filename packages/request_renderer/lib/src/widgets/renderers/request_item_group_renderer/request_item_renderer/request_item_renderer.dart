import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:request_renderer/src/widgets/renderers/request_item_group_renderer/request_item_renderer/request_item_renderers.dart';

class RequestItemRenderer extends StatelessWidget {
  final RequestItemDVO item;

  const RequestItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return switch (item.type) {
      'ReadAttributeRequestItemDVO' => const ReadAttributeRequestItemRenderer(),
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
