import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../open_attribute_switcher_function.dart';
import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'decidable/decidable.dart';
import 'request_item_renderers.dart';

class RequestItemRenderer extends StatelessWidget {
  final String currentAddress;
  final RequestItemDVO item;
  final RequestItemIndex itemIndex;
  final RequestRendererController? controller;
  final LocalRequestStatus? requestStatus;
  final bool isRejected;
  final OpenAttributeSwitcherFunction? openAttributeSwitcher;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO, [LocalAttributeDVO?]) openFileDetails;

  final Color? backgroundColor;

  final RequestValidationResultDTO? validationResult;

  const RequestItemRenderer({
    super.key,
    required this.currentAddress,
    required this.item,
    required this.itemIndex,
    this.controller,
    this.requestStatus,
    this.isRejected = false,
    this.openAttributeSwitcher,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
    this.backgroundColor,
    this.validationResult,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: backgroundColor,
      child: switch (item) {
        final ReadAttributeRequestItemDVO dvo =>
          dvo.isDecidable
              ? DecidableReadAttributeRequestItemRenderer(
                  controller: controller,
                  item: dvo,
                  itemIndex: itemIndex,
                  openAttributeSwitcher: openAttributeSwitcher,
                  currentAddress: currentAddress,
                  expandFileReference: expandFileReference,
                  chooseFile: chooseFile,
                  openFileDetails: openFileDetails,
                )
              : ReadAttributeRequestItemRenderer(item: dvo),
        final ProposeAttributeRequestItemDVO dvo => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: dvo.isDecidable
              ? DecidableProposeAttributeRequestItemRenderer(
                  controller: controller,
                  item: dvo,
                  itemIndex: itemIndex,
                  openAttributeSwitcher: openAttributeSwitcher,
                  expandFileReference: expandFileReference,
                  openFileDetails: openFileDetails,
                )
              : ProposeAttributeRequestItemRenderer(item: dvo),
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
        final RegisterAttributeListenerRequestItemDVO dvo => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: dvo.isDecidable
              ? DecidableRegisterAttributeListenerRequestItemRenderer(controller: controller, item: dvo, itemIndex: itemIndex)
              : RegisterAttributeListenerRequestItemRenderer(item: dvo),
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
        _ => throw Exception("Invalid type '${item.type}'"),
      },
    );
  }
}
