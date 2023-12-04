import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/request_item_index.dart';
import '../request_item_renderer.dart';

class RejectResponseItemRenderer extends StatelessWidget {
  final RequestItemDVO item;
  final RequestItemIndex itemIndex;

  const RejectResponseItemRenderer({super.key, required this.item, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return RequestItemRenderer(item: item, isRejected: true, itemIndex: itemIndex);
  }
}
