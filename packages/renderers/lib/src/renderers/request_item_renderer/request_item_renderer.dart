import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../widgets/request_item_index.dart';
import '../widgets/request_renderer_controller.dart';
import 'decidable/decidable.dart';
import 'request_item_renderers.dart';

class RequestItemRenderer extends StatelessWidget {
  final RequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<AbstractAttribute> Function({required String valueType})? selectAttribute;
  final LocalRequestStatus? requestStatus;
  final bool isRejected;

  const RequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.selectAttribute,
    this.requestStatus,
    this.isRejected = false,
  });

  @override
  Widget build(BuildContext context) {
    return switch (item) {
      final DecidableReadAttributeRequestItemDVO dvo => DecidableReadAttributeRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          selectAttribute: selectAttribute,
          requestStatus: requestStatus,
        ),
      final DecidableProposeAttributeRequestItemDVO dvo => DecidableProposeAttributeRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          selectAttribute: selectAttribute,
          requestStatus: requestStatus,
        ),
      final DecidableCreateAttributeRequestItemDVO dvo => DecidableCreateAttributeRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          requestStatus: requestStatus,
        ),
      final DecidableShareAttributeRequestItemDVO dvo => DecidableShareAttributeRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          requestStatus: requestStatus,
        ),
      final DecidableAuthenticationRequestItemDVO dvo => DecidableAuthenticationRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          requestStatus: requestStatus,
        ),
      final DecidableConsentRequestItemDVO dvo => DecidableConsentRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          requestStatus: requestStatus,
        ),
      final DecidableRegisterAttributeListenerRequestItemDVO dvo => DecidableRegisterAttributeListenerRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          requestStatus: requestStatus,
        ),
      final ReadAttributeRequestItemDVO dvo => ReadAttributeRequestItemRenderer(controller: controller, item: dvo),
      final ProposeAttributeRequestItemDVO dvo => ProposeAttributeRequestItemRenderer(controller: controller, item: dvo),
      final CreateAttributeRequestItemDVO dvo => CreateAttributeRequestItemRenderer(controller: controller, item: dvo, isRejected: isRejected),
      final ShareAttributeRequestItemDVO dvo => ShareAttributeRequestItemRenderer(controller: controller, item: dvo, isRejected: isRejected),
      final AuthenticationRequestItemDVO dvo => AuthenticationRequestItemRenderer(controller: controller, item: dvo),
      final ConsentRequestItemDVO dvo => ConsentRequestItemRenderer(controller: controller, item: dvo),
      final RegisterAttributeListenerRequestItemDVO dvo => RegisterAttributeListenerRequestItemRenderer(controller: controller, item: dvo),
      _ => throw Exception("Invalid type '${item.type}'"),
    };
  }
}
