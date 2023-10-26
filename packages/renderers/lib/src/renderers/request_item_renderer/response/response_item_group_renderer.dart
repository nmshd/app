import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';
import 'response_item_renderer.dart';

class ResponseItemGroupRenderer extends StatelessWidget {
  final ResponseItemGroupDVO responseItemGroup;
  final List<RequestItemDVO> requestItems;
  final RequestRendererController? controller;
  final int groupIndex;

  const ResponseItemGroupRenderer({
    super.key,
    required this.responseItemGroup,
    required this.requestItems,
    this.controller,
    required this.groupIndex,
  });

  @override
  Widget build(BuildContext context) {
    final responseItems = responseItemGroup.items.asMap().entries.map((entry) {
      final itemIndex = entry.key;
      final item = entry.value;

      return ResponseItemRenderer(
        item: item,
        requestItems: requestItems,
        groupIndex: groupIndex,
        itemIndex: itemIndex,
        controller: controller,
      );
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: responseItems,
    );
  }
}
