import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../request_renderer.dart';

class AuthenticationRequestItemRenderer extends StatelessWidget {
  final AuthenticationRequestItemDVO item;
  final RequestRendererController? controller;

  const AuthenticationRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${item.type})', style: const TextStyle(fontStyle: FontStyle.italic)),
        Text(item.name),
        if (item.date != null) Text(item.date!),
        if (item.description != null) Text(item.description!),
        const SizedBox(height: 30),
      ],
    );
  }
}
