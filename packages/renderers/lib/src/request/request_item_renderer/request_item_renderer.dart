import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

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
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 12),
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
        final ProposeAttributeRequestItemDVO dvo =>
          dvo.isDecidable
              ? DecidableProposeAttributeRequestItemRenderer(
                  controller: controller,
                  item: dvo,
                  itemIndex: itemIndex,
                  openAttributeSwitcher: openAttributeSwitcher,
                  expandFileReference: expandFileReference,
                  openFileDetails: openFileDetails,
                )
              : ProposeAttributeRequestItemRenderer(item: dvo),
        final CreateAttributeRequestItemDVO dvo =>
          dvo.isDecidable
              ? DecidableCreateAttributeRequestItemRenderer(
                  controller: controller,
                  item: dvo,
                  itemIndex: itemIndex,
                  expandFileReference: expandFileReference,
                  openFileDetails: openFileDetails,
                )
              : CreateAttributeRequestItemRenderer(
                  item: dvo,
                  isRejected: isRejected,
                  expandFileReference: expandFileReference,
                  openFileDetails: openFileDetails,
                ),
        final ShareAttributeRequestItemDVO dvo =>
          dvo.isDecidable
              ? DecidableShareAttributeRequestItemRenderer(
                  controller: controller,
                  item: dvo,
                  itemIndex: itemIndex,
                  expandFileReference: expandFileReference,
                  openFileDetails: openFileDetails,
                )
              : ShareAttributeRequestItemRenderer(
                  item: dvo,
                  isRejected: isRejected,
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
        final RegisterAttributeListenerRequestItemDVO dvo =>
          dvo.isDecidable
              ? DecidableRegisterAttributeListenerRequestItemRenderer(controller: controller, item: dvo, itemIndex: itemIndex)
              : RegisterAttributeListenerRequestItemRenderer(item: dvo),
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
