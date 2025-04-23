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
    this.validationResult,
  });

  @override
  Widget build(BuildContext context) {
    return switch (item) {
      final DecidableReadAttributeRequestItemDVO dvo => DecidableReadAttributeRequestItemRenderer(
        controller: controller,
        item: dvo,
        itemIndex: itemIndex,
        openAttributeSwitcher: openAttributeSwitcher,
        currentAddress: currentAddress,
        expandFileReference: expandFileReference,
        chooseFile: chooseFile,
        openFileDetails: openFileDetails,
      ),
      final DecidableProposeAttributeRequestItemDVO dvo => DecidableProposeAttributeRequestItemRenderer(
        controller: controller,
        item: dvo,
        itemIndex: itemIndex,
        openAttributeSwitcher: openAttributeSwitcher,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),
      final DecidableCreateAttributeRequestItemDVO dvo => DecidableCreateAttributeRequestItemRenderer(
        controller: controller,
        item: dvo,
        itemIndex: itemIndex,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),
      final DecidableShareAttributeRequestItemDVO dvo => DecidableShareAttributeRequestItemRenderer(
        controller: controller,
        item: dvo,
        itemIndex: itemIndex,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),
      final DecidableAuthenticationRequestItemDVO dvo => DecidableAuthenticationRequestItemRenderer(
        controller: controller,
        item: dvo,
        itemIndex: itemIndex,
      ),
      final DecidableConsentRequestItemDVO dvo => DecidableConsentRequestItemRenderer(controller: controller, item: dvo, itemIndex: itemIndex),
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
      final DecidableTransferFileOwnershipRequestItemDVO dvo => TransferFileOwnershipRequestItemRenderer(
        controller: controller,
        item: dvo,
        file: dvo.file,
        itemIndex: itemIndex,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
        validationResult: validationResult,
      ),
      final ReadAttributeRequestItemDVO dvo => ReadAttributeRequestItemRenderer(item: dvo),
      final ProposeAttributeRequestItemDVO dvo => ProposeAttributeRequestItemRenderer(item: dvo),
      final CreateAttributeRequestItemDVO dvo => CreateAttributeRequestItemRenderer(
        item: dvo,
        isRejected: isRejected,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),
      final ShareAttributeRequestItemDVO dvo => ShareAttributeRequestItemRenderer(
        item: dvo,
        isRejected: isRejected,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),
      final AuthenticationRequestItemDVO dvo => AuthenticationRequestItemRenderer(item: dvo),
      final ConsentRequestItemDVO dvo => ConsentRequestItemRenderer(item: dvo),
      final RegisterAttributeListenerRequestItemDVO dvo => RegisterAttributeListenerRequestItemRenderer(item: dvo),
      final FreeTextRequestItemDVO dvo => FreeTextRequestItemRenderer(item: dvo),
      final TransferFileOwnershipRequestItemDVO dvo => TransferFileOwnershipRequestItemRenderer(
        item: dvo,
        file: dvo.file,
        itemIndex: itemIndex,
        expandFileReference: expandFileReference,
        openFileDetails: openFileDetails,
      ),
      _ => throw Exception("Invalid type '${item.type}'"),
    };
  }
}
