import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../custom_list_tile.dart';

class FreeTextRequestItemRenderer extends StatelessWidget {
  final FreeTextRequestItemDVO item;

  const FreeTextRequestItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: item.name,
      description: item.description,
      thirdLine: item.freeText,
    );
  }
}
