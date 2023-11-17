import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '/src/request_item_index.dart';
import '/src/request_renderer_controller.dart';
import 'decidable/decidable.dart';
import 'request_item_renderers.dart';

class RequestItemRenderer extends StatelessWidget {
  final RequestItemDVO item;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;
  final RequestItemIndex itemIndex;
  final Future<AbstractAttribute> Function()? selectAttribute;
  final LocalRequestStatus? requestStatus;

  const RequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    this.onEdit,
    required this.itemIndex,
    this.selectAttribute,
    this.requestStatus,
  });

  @override
  Widget build(BuildContext context) {
    if (item.type.startsWith('Decidable')) {
      return switch (item) {
        final DecidableReadAttributeRequestItemDVO dvo =>
          DecidableReadAttributeRequestItemRenderer(controller: controller, item: dvo, onEdit: onEdit, itemIndex: itemIndex),
        final DecidableProposeAttributeRequestItemDVO dvo => DecidableProposeAttributeRequestItemRenderer(
            controller: controller,
            item: dvo,
            itemIndex: itemIndex,
            selectAttribute: selectAttribute,
            requestStatus: requestStatus,
          ),
        final DecidableCreateAttributeRequestItemDVO dvo =>
          DecidableCreateAttributeRequestItemRenderer(controller: controller, item: dvo, itemIndex: itemIndex),
        final DecidableShareAttributeRequestItemDVO dvo =>
          DecidableShareAttributeRequestItemRenderer(controller: controller, item: dvo, itemIndex: itemIndex),
        final DecidableAuthenticationRequestItemDVO dvo =>
          DecidableAuthenticationRequestItemRenderer(controller: controller, item: dvo, itemIndex: itemIndex),
        final DecidableConsentRequestItemDVO dvo => DecidableConsentRequestItemRenderer(controller: controller, item: dvo, itemIndex: itemIndex),
        final DecidableRegisterAttributeListenerRequestItemDVO dvo =>
          DecidableRegisterAttributeListenerRequestItemRenderer(controller: controller, item: dvo, itemIndex: itemIndex),
        _ => throw Exception("Invalid type '${item.type}'"),
      };
    }

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
