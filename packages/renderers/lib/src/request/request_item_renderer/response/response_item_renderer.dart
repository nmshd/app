import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../request_item_index.dart';
import 'error_response_item_renderer.dart';
import 'reject_response_item_renderer.dart';
import 'response.dart';

class ResponseItemRenderer extends StatelessWidget {
  final ResponseItemDVO responseItem;
  final RequestItemDVO requestItem;
  final RequestItemIndex itemIndex;
  final String currentAddress;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;

  const ResponseItemRenderer({
    super.key,
    required this.itemIndex,
    required this.responseItem,
    required this.requestItem,
    required this.currentAddress,
    required this.expandFileReference,
    required this.chooseFile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: switch (responseItem) {
        final ReadAttributeAcceptResponseItemDVO dvo => ReadAttributeAcceptResponseItemRenderer(
            item: dvo,
            expandFileReference: expandFileReference,
          ),
        final ProposeAttributeAcceptResponseItemDVO dvo => ProposeAttributeAcceptResponseItemRenderer(
            item: dvo,
            expandFileReference: expandFileReference,
          ),
        final CreateAttributeAcceptResponseItemDVO dvo => CreateAttributeAcceptResponseItemRenderer(
            item: dvo,
            expandFileReference: expandFileReference,
          ),
        final ShareAttributeAcceptResponseItemDVO dvo => ShareAttributeAcceptResponseItemRenderer(
            item: dvo,
            expandFileReference: expandFileReference,
          ),
        final RegisterAttributeListenerAcceptResponseItemDVO dvo => RegisterAttributeListenerAcceptResponseItemRenderer(item: dvo),
        final RejectResponseItemDVO _ => RejectResponseItemRenderer(
            item: requestItem,
            itemIndex: itemIndex,
            currentAddress: currentAddress,
            expandFileReference: expandFileReference,
            chooseFile: chooseFile,
          ),
        final ErrorResponseItemDVO dvo => ErrorResponseItemRenderer(item: dvo),
        final AcceptResponseItemDVO _ => AcceptResponseItemRenderer(
            item: requestItem,
            itemIndex: itemIndex,
            currentAddress: currentAddress,
            expandFileReference: expandFileReference,
            chooseFile: chooseFile,
          ),
        _ => throw Exception("Invalid type '${responseItem.type}'"),
      },
    );
  }
}
