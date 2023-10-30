import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_list_tile.dart';

class ShareAttributeAcceptResponseItemRenderer extends StatelessWidget {
  final ShareAttributeAcceptResponseItemDVO item;

  const ShareAttributeAcceptResponseItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final attributeValue = item.attribute.value.toJson()['value'];

    return CustomListTile(
      title: item.type,
      description: attributeValue,
    );
  }
}
