import 'package:flutter/material.dart';

class FilterChipBar extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback onInfoPressed;

  const FilterChipBar({required this.children, required this.onInfoPressed, super.key}) : assert(children.length != 0, 'children must not be empty');

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [
              Padding(padding: const EdgeInsets.only(left: 16), child: children.first),
              ...children.skip(1),
              const SizedBox(width: 52),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
              color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: IconButton(onPressed: onInfoPressed, icon: const Icon(Icons.info)),
            ),
          ),
        ),
      ],
    );
  }
}
