import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';

class FreeTextRequestItemRenderer extends StatelessWidget {
  final LocalRequestDVO request;
  final RequestItemDVO item;
  final RequestRendererController? controller;

  const FreeTextRequestItemRenderer({super.key, required this.request, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.type, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
      ],
    );
  }
}
