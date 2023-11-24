import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '/src/request_item_index.dart';
import '/src/request_renderer_controller.dart';
import 'response_item_renderer.dart';

class ResponseItemGroupRenderer extends StatelessWidget {
  final ResponseItemGroupDVO responseItemGroup;
  final RequestItemGroupDVO requestItemGroup;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const ResponseItemGroupRenderer({
    super.key,
    required this.responseItemGroup,
    this.controller,
    required this.itemIndex,
    required this.requestItemGroup,
  });

  @override
  Widget build(BuildContext context) {
    final responseItems = responseItemGroup.items.mapIndexed((index, item) {
      return ResponseItemRenderer(
        responseItem: item,
        requestItem: requestItemGroup.items[index],
        itemIndex: (rootIndex: itemIndex.rootIndex, innerIndex: index),
        controller: controller,
      );
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: responseItems,
    );
  }
}
