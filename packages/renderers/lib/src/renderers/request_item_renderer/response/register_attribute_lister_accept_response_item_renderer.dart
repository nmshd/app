import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_list_tile.dart';

class RegisterAttributeListenerAcceptResponseItemRenderer extends StatelessWidget {
  final RegisterAttributeListenerAcceptResponseItemDVO item;

  const RegisterAttributeListenerAcceptResponseItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: item.type,
      description: item.listener.name,
    );
  }
}
