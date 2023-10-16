import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';
import '../widgets/custom_list_tile.dart';

class ConsentRequestItemRenderer extends StatelessWidget {
  final ConsentRequestItemDVO item;
  final RequestRendererController? controller;

  const ConsentRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: '',
      subTitle: item.consent,
      description: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (item.link != null) Text(item.link!),
          if (item.description != null) Text(item.description!),
        ],
      ),
    );
  }
}
