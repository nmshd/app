import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../request_item_renderer.dart';

class RejectResponseItemRenderer extends StatelessWidget {
  final RequestItemDVO item;

  const RejectResponseItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return RequestItemRenderer(item: item, isRejected: true);
  }
}
