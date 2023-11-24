import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_list_tile.dart';

class ErrorResponseItemRenderer extends StatelessWidget {
  final ErrorResponseItemDVO item;

  const ErrorResponseItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(title: item.message);
  }
}
