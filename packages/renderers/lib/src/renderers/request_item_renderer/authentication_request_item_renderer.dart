import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';
import '../widgets/custom_list_tile.dart';

class AuthenticationRequestItemRenderer extends StatelessWidget {
  final AuthenticationRequestItemDVO item;
  final RequestRendererController? controller;

  const AuthenticationRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(title: '', subTitle: item.name);
  }
}
