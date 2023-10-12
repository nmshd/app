import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../renderers.dart';
import 'request_item_renderer/request_item_renderer.dart';

class RequestItemGroupRenderer extends StatelessWidget {
  final RequestItemGroupDVO requestItemGroup;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const RequestItemGroupRenderer({super.key, required this.requestItemGroup, this.controller, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(requestItemGroup.title ?? ''),
      //TODO: add description
      children: [
        for (final item in requestItemGroup.items) RequestItemRenderer(item: item, controller: controller, onEdit: onEdit),
      ],
    );
  }
}
