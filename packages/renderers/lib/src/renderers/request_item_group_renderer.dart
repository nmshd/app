import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/src/renderers/request_item_renderer/request_item_renderer.dart';

import '../../renderers.dart';

class RequestItemGroupRenderer extends StatelessWidget {
  final RequestItemGroupDVO requestItemGroup;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;
  final RequestItemIndex itemIndex;

  const RequestItemGroupRenderer({
    super.key,
    required this.requestItemGroup,
    this.controller,
    this.onEdit,
    required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    final requestItems = requestItemGroup.items.mapIndexed((index, item) {
      return RequestItemRenderer(
        item: item,
        itemIndex: (rootIndex: itemIndex.rootIndex, groupIndex: index),
        controller: controller,
        onEdit: onEdit,
      );
    }).toList();

    return ExpansionTile(
      title: Text(requestItemGroup.title ?? ''),
      //TODO: add description
      children: requestItems,
    );
  }
}
