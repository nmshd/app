import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../open_attribute_switcher_function.dart';
import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'authentication_request_item_renderer.dart';
import 'consent_request_item_renderer.dart';
import 'create_attribute_request_item_renderer.dart';
import 'form_field_request_item_renderer/form_field_request_item_renderer.dart';
import 'free_text_request_item_renderer.dart';
import 'propose_attribute_request_item_renderer.dart';
import 'read_attribute_request_item_renderer.dart';
import 'register_attribute_listener_request_item_renderer.dart';
import 'share_attribute_request_item_renderer.dart';
import 'transfer_file_ownership_request_item_renderer.dart';

class RequestItemRenderer extends StatelessWidget {
  final RequestItemDVO item;
  final RequestItemIndex itemIndex;
  final RequestRendererController? controller;
  final LocalRequestStatus? requestStatus;
  final OpenAttributeSwitcherFunction openAttributeSwitcher;
  final CreateIdentityAttributeFunction createIdentityAttribute;
  final ComposeRelationshipAttributeFunction composeRelationshipAttribute;

  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO, [LocalAttributeDVO?]) openFileDetails;

  final Color? backgroundColor;

  final RequestValidationResultDTO? validationResult;

  const RequestItemRenderer({
    required this.item,
    required this.itemIndex,
    required this.controller,
    required this.requestStatus,
    required this.openAttributeSwitcher,
    required this.createIdentityAttribute,
    required this.composeRelationshipAttribute,
    required this.expandFileReference,
    required this.openFileDetails,
    required this.backgroundColor,
    required this.validationResult,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: backgroundColor,
      child: switch (item) {
        final ReadAttributeRequestItemDVO dvo => ReadAttributeRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          openAttributeSwitcher: openAttributeSwitcher,
          createIdentityAttribute: createIdentityAttribute,
          composeRelationshipAttribute: composeRelationshipAttribute,
          expandFileReference: expandFileReference,
          openFileDetails: openFileDetails,
          validationResult: validationResult,
        ),
        final ProposeAttributeRequestItemDVO dvo => ProposeAttributeRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          openAttributeSwitcher: openAttributeSwitcher,
          expandFileReference: expandFileReference,
          openFileDetails: openFileDetails,
          validationResult: validationResult,
        ),
        final CreateAttributeRequestItemDVO dvo => CreateAttributeRequestItemRenderer(
          item: dvo,
          controller: controller,
          itemIndex: itemIndex,
          validationResult: validationResult,
          expandFileReference: expandFileReference,
          openFileDetails: openFileDetails,
        ),
        final ShareAttributeRequestItemDVO dvo => ShareAttributeRequestItemRenderer(
          item: dvo,
          controller: controller,
          itemIndex: itemIndex,
          validationResult: validationResult,
          expandFileReference: expandFileReference,
          openFileDetails: openFileDetails,
        ),
        final AuthenticationRequestItemDVO dvo => AuthenticationRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          validationResult: validationResult,
        ),
        final ConsentRequestItemDVO dvo => ConsentRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          validationResult: validationResult,
        ),
        final RegisterAttributeListenerRequestItemDVO dvo => RegisterAttributeListenerRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
        ),
        final FreeTextRequestItemDVO dvo => FreeTextRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          requestStatus: requestStatus,
        ),
        final TransferFileOwnershipRequestItemDVO dvo => TransferFileOwnershipRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          expandFileReference: expandFileReference,
          openFileDetails: openFileDetails,
          validationResult: validationResult,
        ),
        final FormFieldRequestItemDVO dvo => FormFieldRequestItemRenderer(
          controller: controller,
          item: dvo,
          itemIndex: itemIndex,
          validationResult: validationResult,
        ),
        _ => throw Exception("Invalid type '${item.type}'"),
      },
    );
  }
}
