import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

void showErrorSnackbar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      behavior: SnackBarBehavior.floating,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      content: Row(
        children: [
          Container(
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
  ScaffoldMessenger.of(context).showSuccessSnackbar(text: text);
}

extension ShowSuccessSnackbar on ScaffoldMessengerState {
  void showSuccessSnackbar({required String text}) {
    showSnackBar(
      SnackBar(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
        showCloseIcon: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        content: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(color: context.customColors.success, shape: BoxShape.circle),
              child: Center(child: Icon(Icons.check, color: context.customColors.onSuccess, size: 20)),
            ),
            Gaps.w8,
            Expanded(child: BoldStyledText(text)),
          ],
        ),
      ),
    );
  }
}
