import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';
import 'decidable/decidable_authentication_request_item_renderer.dart';
import 'decidable/decidable_consent_request_item_renderer.dart';
import 'decidable/decidable_create_attribute_request_item.dart';
import 'decidable/decidable_propose_attribute_request_item_renderer.dart';
import 'decidable/decidable_read_attribute_request_item_renderer.dart';
import 'decidable/decidable_register_attribute_listener_request_item_renderer.dart';
import 'decidable/decidable_share_attribute_request_item_renderer.dart';
import 'request_item_renderers.dart';

class RequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final RequestItemDVO item;
  final RequestRendererController? controller;
  const RequestItemRenderer({super.key, required this.request, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    if (item.type.startsWith('Decidable')) {
      return switch (item) {
        final DecidableReadAttributeRequestItemDVO dvo =>
          DecidableReadAttributeRequestItemRenderer(request: request, controller: controller, item: dvo),
        final DecidableProposeAttributeRequestItemDVO dvo =>
          DecidableProposeAttributeRequestItemRenderer(request: request, controller: controller, item: dvo),
        final DecidableCreateAttributeRequestItemDVO dvo =>
          DecidableCreateAttributeRequestItemRenderer(request: request, controller: controller, item: dvo),
        final DecidableShareAttributeRequestItemDVO dvo =>
          DecidableShareAttributeRequestItemRenderer(request: request, controller: controller, item: dvo),
        final DecidableAuthenticationRequestItemDVO dvo =>
          DecidableAuthenticationRequestItemRenderer(request: request, controller: controller, item: dvo),
        final DecidableConsentRequestItemDVO dvo => DecidableConsentRequestItemRenderer(request: request, controller: controller, item: dvo),
        final DecidableRegisterAttributeListenerRequestItemDVO dvo =>
          DecidableRegisterAttributeListenerRequestItemRenderer(request: request, controller: controller, item: dvo),
        _ => throw Exception("Invalid type '${item.type}'"),
      };
    }

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
