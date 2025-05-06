import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomSheetHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final bool canClose;

  const BottomSheetHeader({required this.title, this.onBackPressed, this.canClose = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, left: onBackPressed == null ? 24 : 8, right: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (onBackPressed != null) IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBackPressed),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 11),
              child: Text(
                title,
                maxLines: 2,
                style: onBackPressed == null ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.close), onPressed: canClose ? context.pop : null),
        ],
      ),
    );
  }
}
