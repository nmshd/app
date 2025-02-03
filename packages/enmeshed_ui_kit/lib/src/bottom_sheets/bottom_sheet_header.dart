import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomSheetHeader extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final String title;
  final bool canClose;

  const BottomSheetHeader({
    this.onBackPressed,
    required this.title,
    required this.canClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, left: onBackPressed == null ? 24 : 8, right: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (onBackPressed != null) IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBackPressed),
          Text(title, style: onBackPressed == null ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.titleMedium),
          IconButton(icon: const Icon(Icons.close), onPressed: canClose ? context.pop : null),
        ],
      ),
    );
  }
}
