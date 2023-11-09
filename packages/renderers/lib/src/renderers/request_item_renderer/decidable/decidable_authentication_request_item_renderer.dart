import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';

class DecidableAuthenticationRequestItemRenderer extends StatelessWidget {
  final DecidableAuthenticationRequestItemDVO item;
  final RequestRendererController? controller;

  const DecidableAuthenticationRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
      child: Text(item.name, style: const TextStyle(fontSize: 16)),
    );
  }
}
