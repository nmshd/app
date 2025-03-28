import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';

class DecidableTransferFileOwnershipRequestItemRenderer extends StatefulWidget {
  final DecidableTransferFileOwnershipRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;

  const DecidableTransferFileOwnershipRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    required this.expandFileReference,
    required this.openFileDetails,
  });

  @override
  State<DecidableTransferFileOwnershipRequestItemRenderer> createState() => _DecidableTransferFileOwnershipRequestItemRendererState();
}

class _DecidableTransferFileOwnershipRequestItemRendererState extends State<DecidableTransferFileOwnershipRequestItemRenderer> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
