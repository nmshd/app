import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';
import 'package:renderers/src/request/request_item_renderer/decidable/checkbox_enabled_extension.dart';

import '../../../abstract_url_launcher.dart';
import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableConsentRequestItemRenderer extends StatefulWidget {
  final DecidableConsentRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const DecidableConsentRequestItemRenderer({super.key, required this.item, this.controller, required this.itemIndex});

  @override
  State<DecidableConsentRequestItemRenderer> createState() => _DecidableConsentRequestItemRendererState();
}

class _DecidableConsentRequestItemRendererState extends State<DecidableConsentRequestItemRenderer> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();

    _isChecked = widget.item.initiallyChecked;

    if (_isChecked) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TranslatedText(widget.item.name, style: Theme.of(context).textTheme.titleMedium),
          if (widget.item.description != null) Text(widget.item.description!, style: Theme.of(context).textTheme.bodySmall),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Switch(
                          thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                            (Set<WidgetState> states) => states.contains(WidgetState.selected) ? const Icon(Icons.check) : const Icon(Icons.close),
                          ),
                          activeColor: context.customColors.onSuccess,
                          value: _isChecked,
                          activeTrackColor: _isSwitchDisabled ? context.customColors.success.withAlpha(84) : context.customColors.success,
                          onChanged: _isSwitchDisabled ? null : onUpdateCheckbox,
                        ),
                        Gaps.w8,
                        Expanded(
                          child: Column(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.item.consent, maxLines: 4, overflow: TextOverflow.ellipsis),
                              if (_isTextOverflowing()) _ShowFullConsentButton(),
                              if (widget.item.link != null) _LinkButton(link: widget.item.link!, linkDisplayText: widget.item.linkDisplayText),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (widget.item.mustBeAccepted && widget.item.requireManualDecision == true && !_isChecked) _AlertContainer(),
        ],
      ),
    );
  }

  bool get _isSwitchDisabled => widget.item.mustBeAccepted && widget.item.requireManualDecision == false;

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;
    setState(() {
      _isChecked = value;
    });
    handleCheckboxChange(isChecked: _isChecked, controller: widget.controller, itemIndex: widget.itemIndex);
  }

  bool _isTextOverflowing() {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.item.consent, style: Theme.of(context).textTheme.bodyMedium),
      maxLines: 4,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.sizeOf(context).width - 116);
    return textPainter.didExceedMaxLines;
  }
}

class _ShowFullConsentButton extends StatelessWidget {
  const _ShowFullConsentButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // TODO: open full screen dialog
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TranslatedText(
            'i18n://requestRenderer.showFullConsent',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Gaps.w8,
          Icon(Icons.article_outlined, color: Theme.of(context).colorScheme.primary, size: 14),
        ],
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  final String link;
  final String? linkDisplayText;

  const _LinkButton({required this.link, this.linkDisplayText});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final url = Uri.parse(link);
        await GetIt.I.get<AbstractUrlLauncher>().launchSafe(url);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TranslatedText(
            linkDisplayText ?? 'i18n://requestRenderer.defaultLinkDisplayText',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Gaps.w8,
          Icon(Icons.arrow_outward, color: Theme.of(context).colorScheme.primary, size: 14),
        ],
      ),
    );
  }
}

class _AlertContainer extends StatelessWidget {
  const _AlertContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.error, borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
          Gaps.w4,
          Expanded(
            child: TranslatedText(
              'i18n://requestRenderer.consentRequired',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onError),
            ),
          ),
        ],
      ),
    );
  }
}
