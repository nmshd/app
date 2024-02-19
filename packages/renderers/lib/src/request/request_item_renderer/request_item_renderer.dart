import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';
import 'package:renderers/src/request/request_item_renderer/decidable/decidable_free_text_request_item.dart';

import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'decidable/decidable.dart';
import 'request_item_renderers.dart';
import 'widgets/open_select_attribute_screen_function.dart';

class RequestItemRenderer extends StatelessWidget {
  final String currentAddress;
  final RequestItemDVO item;
  final RequestItemIndex itemIndex;
  final RequestRendererController? controller;
  final LocalRequestStatus? requestStatus;
  final bool isRejected;
  final OpenSelectAttributeScreenFunction? openAttributeScreen;

  const RequestItemRenderer({
    super.key,
    required this.currentAddress,
    required this.item,
    required this.itemIndex,
    this.controller,
    this.requestStatus,
    this.isRejected = false,
    this.openAttributeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: switch (item) {
        final DecidableReadAttributeRequestItemDVO dvo => DecidableReadAttributeRequestItemRenderer(
            controller: controller,
            item: dvo,
            itemIndex: itemIndex,
            openAttributeScreen: openAttributeScreen,
            currentAddress: currentAddress,
          ),
        final DecidableProposeAttributeRequestItemDVO dvo => DecidableProposeAttributeRequestItemRenderer(
            controller: controller,
            item: dvo,
            itemIndex: itemIndex,
            openAttributeScreen: openAttributeScreen,
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
      },
    );
  }
}
