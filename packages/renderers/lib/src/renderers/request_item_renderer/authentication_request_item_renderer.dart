import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../widgets/request_renderer_controller.dart';

class AuthenticationRequestItemRenderer extends StatelessWidget {
  final AuthenticationRequestItemDVO item;
  final RequestRendererController? controller;

  const AuthenticationRequestItemRenderer({super.key, required this.item, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(item.name, style: const TextStyle(fontSize: 16)),
    );
  }
}
