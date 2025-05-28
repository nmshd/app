import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class ModalLoadingOverlay extends StatelessWidget {
  final String text;
  final bool isDialog;
  final bool expand;
  final EdgeInsets padding;
  final String? subline;
  final Color? headlineColor;

  const ModalLoadingOverlay({
    required this.text,
    this.subline,
    this.headlineColor,
    this.isDialog = false,
    this.expand = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: const Radius.circular(28), bottom: isDialog ? const Radius.circular(28) : Radius.zero),
        color: Theme.of(context).colorScheme.surface,
      ),
      width: double.infinity,
      padding: isDialog ? padding : padding.add(EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom)),
      child: Column(
        spacing: 24,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: headlineColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 147,
            height: 147,
            child: CircularProgressIndicator(
              strokeWidth: 8,
              color: context.customColors.success,
              backgroundColor: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          if (subline != null) Text(subline!, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );

    if (!expand) return widget;

    return Positioned.fill(child: widget);
  }
}
