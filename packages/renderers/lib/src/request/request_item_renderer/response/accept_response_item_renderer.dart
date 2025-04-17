import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_item_index.dart';
import '../request_item_renderer.dart';

class AcceptResponseItemRenderer extends StatelessWidget {
  final RequestItemDVO item;
  final RequestItemIndex itemIndex;
  final String currentAddress;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;
  final void Function(FileDVO, [LocalAttributeDVO?]) openFileDetails;

  const AcceptResponseItemRenderer({
    super.key,
    required this.item,
    required this.itemIndex,
    required this.currentAddress,
    required this.expandFileReference,
    required this.chooseFile,
    required this.openFileDetails,
  });

  @override
  Widget build(BuildContext context) {
    return RequestItemRenderer(
      item: item,
      itemIndex: itemIndex,
      currentAddress: currentAddress,
      expandFileReference: expandFileReference,
      chooseFile: chooseFile,
      openFileDetails: openFileDetails,
    );
  }
}
