import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import 'request_item_renderer/request_item_renderer.dart';

class RequestItemGroupRenderer extends StatelessWidget {
  final RequestItemGroupDVO requestItemGroup;
  const RequestItemGroupRenderer({super.key, required this.requestItemGroup});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in requestItemGroup.items) RequestItemRenderer(item: item),
      ],
    );
  }
}
