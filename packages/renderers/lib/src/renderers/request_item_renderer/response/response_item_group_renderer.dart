import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import 'response_item_renderer.dart';

class ResponseItemGroupRenderer extends StatelessWidget {
  final ResponseItemGroupDVO responseItemGroup;
  final List<RequestItemDVO> requestItems;

  const ResponseItemGroupRenderer({super.key, required this.responseItemGroup, required this.requestItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in responseItemGroup.items) ResponseItemRenderer(item: item, requestItems: requestItems),
      ],
    );
  }
}
