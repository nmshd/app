import 'package:flutter/material.dart';

import '../core.dart';

void showSuccessSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      content: Row(
        children: [
          const CustomSuccessIcon(containerSize: 24, iconSize: 20),
          Gaps.w8,
          Expanded(child: Text(text)),
        ],
      ),
    ),
  );
}
