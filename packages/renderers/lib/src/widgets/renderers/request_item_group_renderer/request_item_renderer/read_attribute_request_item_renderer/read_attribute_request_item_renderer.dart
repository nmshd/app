import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../../request_renderer.dart';

class ReadAttributeRequestItemRenderer extends StatelessWidget {
  final RequestItemDVO item;
  final RequestRendererController? controller;
  const ReadAttributeRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return Text(item.name);
  }
}
