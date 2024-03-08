import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_item_index.dart';
import 'response_item_renderer.dart';

class ResponseItemGroupRenderer extends StatelessWidget {
  final ResponseItemGroupDVO responseItemGroup;
  final RequestItemGroupDVO requestItemGroup;
  final RequestItemIndex itemIndex;
  final String currentAddress;

  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;

  const ResponseItemGroupRenderer({
    super.key,
    required this.responseItemGroup,
    required this.itemIndex,
    required this.requestItemGroup,
    required this.currentAddress,
    required this.expandFileReference,
    required this.chooseFile,
  });

  @override
  Widget build(BuildContext context) {
    final responseItems = responseItemGroup.items.mapIndexed((index, item) {
      return ResponseItemRenderer(
        responseItem: item,
        requestItem: requestItemGroup.items[index],
        itemIndex: (rootIndex: itemIndex.rootIndex, innerIndex: index),
        currentAddress: currentAddress,
        expandFileReference: expandFileReference,
        chooseFile: chooseFile,
      );
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: responseItems,
    );
  }
}
