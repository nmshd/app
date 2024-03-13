import 'package:flutter/material.dart';
import 'package:value_renderer/value_renderer.dart';

class StreetAddressAttributeRenderer extends StatelessWidget {
  final ValueRendererController? controller;
  final String? fieldName;

  const StreetAddressAttributeRenderer({super.key, this.controller, this.fieldName});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }
}
