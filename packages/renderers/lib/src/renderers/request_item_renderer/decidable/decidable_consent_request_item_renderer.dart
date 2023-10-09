import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';

class DecidableConsentRequestItemRenderer extends StatelessWidget {
  final DecidableConsentRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableConsentRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('(${item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        Text(item.consent),
        if (item.link != null) Text(item.link!),
      ],
    );
  }
}
