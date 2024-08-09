import 'package:flutter/material.dart';

import '/core/utils/extensions.dart';
import '../constants.dart';

void showErrorSnackbar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      padding: const EdgeInsets.all(16),
      content: Row(
        children: [
          Container(
            padding: EdgeInsets.zero,
            width: 24,
            height: 24,
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.error, shape: BoxShape.circle),
            child: Center(child: Icon(Icons.priority_high_outlined, color: Theme.of(context).colorScheme.surface, size: 14)),
          ),
          Gaps.w8,
          Expanded(child: Text(text)),
        ],
      ),
    ),
  );
}

void showSuccessSnackbar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      content: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(color: context.customColors.successIcon, shape: BoxShape.circle),
            child: Center(child: Icon(Icons.check, color: context.customColors.onSuccess, size: 20)),
          ),
          Gaps.w8,
          Expanded(child: Text(text)),
        ],
      ),
    ),
  );
}
