import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';

class DecidableAuthenticationRequestItemRenderer extends StatelessWidget {
  final DecidableAuthenticationRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableAuthenticationRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        Text(item.name),
        const SizedBox(height: 30),
      ],
    );
  }
}
