import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/request_item_index.dart';
import '../request_item_renderer.dart';

class AcceptResponseItemRenderer extends StatelessWidget {
  final RequestItemDVO item;
  final RequestItemIndex itemIndex;
  final String currentAddress;

  const AcceptResponseItemRenderer({
    super.key,
    required this.item,
    required this.itemIndex,
    required this.currentAddress,
  });

  @override
  Widget build(BuildContext context) {
    return RequestItemRenderer(
      item: item,
      itemIndex: itemIndex,
      currentAddress: currentAddress,
    );
  }
}
