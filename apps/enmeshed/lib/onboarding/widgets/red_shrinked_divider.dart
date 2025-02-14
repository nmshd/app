import 'package:flutter/material.dart';

class RedShrinkedDivider extends StatelessWidget {
  final double width;

  const RedShrinkedDivider({required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: width,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary, borderRadius: BorderRadius.circular(3)),
    );
  }
}
