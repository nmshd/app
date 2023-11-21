import 'package:collection/collection.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import 'response_item_renderer.dart';

class ResponseItemGroupRenderer extends StatelessWidget {
  final ResponseItemGroupDVO responseItemGroup;
  final RequestItemGroupDVO requestItemGroup;

  const ResponseItemGroupRenderer({super.key, required this.responseItemGroup, required this.requestItemGroup});

  @override
  Widget build(BuildContext context) {
    final responseItems = responseItemGroup.items
        .mapIndexed((index, item) => ResponseItemRenderer(
              responseItem: item,
              requestItem: requestItemGroup.items[index],
            ))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: responseItems,
    );
  }
}
