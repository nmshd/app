import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

enum BannerCardType { neutral, info, warning, alert, error, success }

class BannerCard extends StatelessWidget {
  final String title;
  final BannerCardType type;
  final ({String title, VoidCallback onPressed})? actionButton;
  final VoidCallback? onClosePressed;
  final bool isFullWidth;

  const BannerCard({required this.title, required this.type, this.onClosePressed, this.actionButton, this.isFullWidth = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(context, type),
        borderRadius: isFullWidth ? BorderRadius.zero : const BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: onClosePressed != null ? 0 : 16, top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _BannerCardIcon(type: type),
            Gaps.w8,
            Expanded(child: Text(title)),
            if (actionButton != null) ...[
              Gaps.w8,
              TextButton(
                onPressed: actionButton!.onPressed,
                child: Text(
                  actionButton!.title,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: _getActionButtonColor(context, type)),
                ),
              ),
            ],
            if (onClosePressed != null) ...[Gaps.w8, IconButton(onPressed: onClosePressed, icon: const Icon(Icons.close))],
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context, BannerCardType type) => switch (type) {
    BannerCardType.neutral => Theme.of(context).colorScheme.surfaceContainer,
    BannerCardType.info => Theme.of(context).colorScheme.secondaryContainer,
    BannerCardType.warning => context.customColors.warningContainer,
    BannerCardType.alert || BannerCardType.error => Theme.of(context).colorScheme.errorContainer,
    BannerCardType.success => context.customColors.successContainer,
  };

  Color _getActionButtonColor(BuildContext context, BannerCardType type) => switch (type) {
    BannerCardType.neutral => Theme.of(context).colorScheme.onSurface,
    BannerCardType.info => Theme.of(context).colorScheme.onSecondaryContainer,
    BannerCardType.warning => context.customColors.onWarningContainer,
    BannerCardType.alert || BannerCardType.error => Theme.of(context).colorScheme.onErrorContainer,
    BannerCardType.success => context.customColors.onSuccessContainer,
  };
}

class _BannerCardIcon extends StatelessWidget {
  final BannerCardType type;
  const _BannerCardIcon({required this.type});

  @override
  Widget build(BuildContext context) => switch (type) {
    BannerCardType.neutral || BannerCardType.info => Icon(Icons.info, color: Theme.of(context).colorScheme.secondary),
    BannerCardType.warning => Icon(Icons.warning_rounded, color: context.customColors.warning),
    BannerCardType.alert => Icon(Icons.error, color: Theme.of(context).colorScheme.error),
    BannerCardType.error => Icon(Icons.cancel, color: Theme.of(context).colorScheme.error),
    BannerCardType.success => Icon(Icons.check_circle, color: context.customColors.success),
  };
}
