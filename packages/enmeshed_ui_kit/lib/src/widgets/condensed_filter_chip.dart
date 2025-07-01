import 'package:flutter/material.dart';

class CondensedFilterChip extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CondensedFilterChip({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.isSelected,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerHighest;
    final foregroundColor = this.foregroundColor ?? Theme.of(context).colorScheme.onSurface;

    final icon = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Icon(this.icon, size: 18, color: foregroundColor),
    );
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: isSelected ? null : onPressed,
        child: Container(
          decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: isSelected
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    icon,
                    Text(label, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: foregroundColor)),
                  ],
                )
              : icon,
        ),
      ),
    );
  }
}
