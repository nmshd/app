import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';

class ConsentRequestItemRenderer extends StatelessWidget {
  final ConsentRequestItemDVO item;
  final RequestRendererController? controller;

  const ConsentRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        Text.rich(TextSpan(text: 'Consent: ', children: [TextSpan(text: item.consent)])),
        Text.rich(TextSpan(text: 'Link: ', children: [TextSpan(text: item.link)])),
        const SizedBox(height: 30),
      ],
    );
  }
}
