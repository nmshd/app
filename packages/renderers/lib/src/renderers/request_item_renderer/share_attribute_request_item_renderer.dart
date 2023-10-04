import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';

class ShareAttributeRequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final ShareAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const ShareAttributeRequestItemRenderer({super.key, required this.request, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.type, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text.rich(TextSpan(
          text: 'SourceAttributeId: ',
          children: [TextSpan(text: item.sourceAttributeId)],
        )),
      ],
    );
  }
}
