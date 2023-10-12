import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../renderers.dart';
import 'request_item_renderer/request_item_renderer.dart';

class RequestItemGroupRenderer extends StatelessWidget {
  final RequestItemGroupDVO requestItemGroup;
  final RequestRendererController? controller;
  final VoidCallback? onEdit;

  const RequestItemGroupRenderer({super.key, required this.requestItemGroup, this.controller, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (requestItemGroup.title != null) Text(requestItemGroup.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        for (final item in requestItemGroup.items) RequestItemRenderer(item: item, controller: controller, onEdit: onEdit),
      ],
    );
  }
}
