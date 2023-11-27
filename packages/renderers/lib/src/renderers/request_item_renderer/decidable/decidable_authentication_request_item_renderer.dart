import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/custom_list_tile.dart';
import '/renderers.dart';

class DecidableAuthenticationRequestItemRenderer extends StatelessWidget {
  final DecidableAuthenticationRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableAuthenticationRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(title: 'i18n://dvo.requestItem.DecidableAuthenticationRequestItem.name', description: item.name);
  }
}
