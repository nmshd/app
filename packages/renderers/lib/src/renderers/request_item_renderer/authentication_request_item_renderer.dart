import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_list_tile.dart';

class AuthenticationRequestItemRenderer extends StatelessWidget {
  final AuthenticationRequestItemDVO item;

  const AuthenticationRequestItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: 'i18n://dvo.requestItem.DecidableAuthenticationRequestItem.name',
      thirdLine: item.name,
    );
  }
}
