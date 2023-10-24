import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/src/renderers/request_item_renderer/request_item_renderer.dart';

import '../../renderers.dart';

class RequestItemGroupRenderer extends StatelessWidget {
  final RequestItemGroupDVO requestItemGroup;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;
  final int groupIndex;

  const RequestItemGroupRenderer({
    super.key,
    required this.requestItemGroup,
    this.controller,
    this.onEdit,
    required this.groupIndex,
  });

  @override
  Widget build(BuildContext context) {
    final requestItems = requestItemGroup.items.asMap().entries.map((entry) {
      final itemIndex = entry.key;
      final item = entry.value;

      return RequestItemRenderer(
        item: item,
        groupIndex: groupIndex,
        itemIndex: itemIndex,
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
