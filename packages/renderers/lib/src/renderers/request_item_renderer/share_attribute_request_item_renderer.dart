import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';
import 'widgets/identity_attribute_renderer.dart';

class ShareAttributeRequestItemRenderer extends StatelessWidget {
  final ShareAttributeRequestItemDVO item;
  final RequestRendererController? controller;

  const ShareAttributeRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        if (item.description != null) Text(item.description!),
        DraftIdentityAttributeRenderer(attribute: item.attribute),
        if (item.date != null) Text(item.date!),
        const SizedBox(height: 30),
      ],
    );
  }
}
