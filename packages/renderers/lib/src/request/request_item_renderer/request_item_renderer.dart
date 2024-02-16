import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:renderers/src/request/request_item_renderer/decidable/decidable_free_text_request_item.dart';

import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'decidable/decidable.dart';
import 'request_item_renderers.dart';

class RequestItemRenderer extends StatelessWidget {
  final RequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final LocalRequestStatus? requestStatus;
  final bool isRejected;
  final String currentAddress;
  final Future<AbstractAttribute?> Function({
    required String valueType,
    required List<AbstractAttribute> attributes,
    ValueHints? valueHints,
  })? selectAttribute;

  const RequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.selectAttribute,
    this.requestStatus,
    this.isRejected = false,
    required this.currentAddress,
  });

  @override
  Widget build(BuildContext context) {
    return switch (item) {
      final DecidableReadAttributeRequestItemDVO dvo => DecidableReadAttributeRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          selectAttribute: selectAttribute,
          currentAddress: currentAddress,
        ),
      final DecidableProposeAttributeRequestItemDVO dvo => DecidableProposeAttributeRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          selectAttribute: selectAttribute,
          currentAddress: currentAddress,
        ),
      final DecidableCreateAttributeRequestItemDVO dvo => DecidableCreateAttributeRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
        ),
      final DecidableShareAttributeRequestItemDVO dvo => DecidableShareAttributeRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
        ),
      final DecidableAuthenticationRequestItemDVO dvo => DecidableAuthenticationRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
        ),
      final DecidableConsentRequestItemDVO dvo => DecidableConsentRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
        ),
      final DecidableRegisterAttributeListenerRequestItemDVO dvo => DecidableRegisterAttributeListenerRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
        ),
      final DecidableFreeTextRequestItemDVO dvo => DecidableFreeTextRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          requestStatus: requestStatus,
        ),
      final ReadAttributeRequestItemDVO dvo => ReadAttributeRequestItemRenderer(item: dvo),
      final ProposeAttributeRequestItemDVO dvo => ProposeAttributeRequestItemRenderer(item: dvo),
      final CreateAttributeRequestItemDVO dvo => CreateAttributeRequestItemRenderer(item: dvo, isRejected: isRejected),
      final ShareAttributeRequestItemDVO dvo => ShareAttributeRequestItemRenderer(item: dvo, isRejected: isRejected),
      final AuthenticationRequestItemDVO dvo => AuthenticationRequestItemRenderer(item: dvo),
      final ConsentRequestItemDVO dvo => ConsentRequestItemRenderer(item: dvo),
      final RegisterAttributeListenerRequestItemDVO dvo => RegisterAttributeListenerRequestItemRenderer(item: dvo),
      final FreeTextRequestItemDVO dvo => FreeTextRequestItemRenderer(item: dvo),
      _ => throw Exception("Invalid type '${item.type}'"),
    };
  }
}
