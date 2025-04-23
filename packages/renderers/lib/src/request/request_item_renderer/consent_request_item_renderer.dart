import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '../../abstract_url_launcher.dart';
import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'decidable/checkbox_enabled_extension.dart';
import 'decidable/widgets/handle_checkbox_change.dart';
import 'decidable/widgets/validation_error_box.dart';

class ConsentRequestItemRenderer extends StatefulWidget {
  final RequestItemDVODerivation item;
  final String consent;
  final String? link;
  final String? linkDisplayText;

  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  final RequestValidationResultDTO? validationResult;

  bool get isDecidable => item is DecidableConsentRequestItemDVO;

  const ConsentRequestItemRenderer({
    super.key,
    required this.item,
    required this.consent,
    required this.link,
    required this.linkDisplayText,
    this.controller,
    required this.itemIndex,
    this.validationResult,
  }) : assert(
         item is ConsentRequestItemDVO || item is DecidableConsentRequestItemDVO,
         'item must be of type ConsentRequestItemDVO or DecidableConsentRequestItemDVO',
       );

  @override
  State<ConsentRequestItemRenderer> createState() => _ConsentRequestItemRendererState();
}

class _ConsentRequestItemRendererState extends State<ConsentRequestItemRenderer> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();

    _isChecked = widget.item.initiallyChecked || widget.item.response is AcceptResponseItemDVO;

    if (_isChecked) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
    }
  }

  @override
  Widget build(BuildContext context) {
    final translatedTitle = widget.item.name.startsWith('i18n://') ? FlutterI18n.translate(context, widget.item.name.substring(7)) : widget.item.name;
    final title = widget.item.mustBeAccepted && widget.item.response == null ? '$translatedTitle*' : translatedTitle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          if (widget.item.description != null) Text(widget.item.description!, style: Theme.of(context).textTheme.bodySmall),
          Material(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: InkWell(
              onTap: _isSwitchDisabled ? null : () => onUpdateCheckbox(!_isChecked),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Switch(
                          thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                            (Set<WidgetState> states) => states.contains(WidgetState.selected) ? const Icon(Icons.check) : const Icon(Icons.close),
                          ),
                          activeColor: context.customColors.onSuccess,
                          value: _isChecked,
                          activeTrackColor: _isSwitchDisabled ? context.customColors.success.withValues(alpha: 0.16) : context.customColors.success,
                          onChanged: _isSwitchDisabled ? null : onUpdateCheckbox,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.consent, maxLines: 4, overflow: TextOverflow.ellipsis),
                                if (_isTextOverflowing()) _ShowFullConsentButton(consent: widget.consent, description: widget.item.description),
                                if (widget.link != null) _LinkButton(link: widget.link!, linkDisplayText: widget.linkDisplayText),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!(widget.validationResult?.isSuccess ?? true)) ValidationErrorBox(validationResult: widget.validationResult!),
        ],
      ),
    );
  }

  bool get _isSwitchDisabled => !widget.isDecidable || (widget.item.mustBeAccepted && widget.item.requireManualDecision == false);

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() => _isChecked = value);
    handleCheckboxChange(isChecked: _isChecked, controller: widget.controller, itemIndex: widget.itemIndex);
  }

  bool _isTextOverflowing() {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.consent, style: Theme.of(context).textTheme.bodyMedium),
      maxLines: 4,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.sizeOf(context).width - 116);
    return textPainter.didExceedMaxLines;
  }
}

class _ShowFullConsentButton extends StatelessWidget {
  final String consent;
  final String? description;

  const _ShowFullConsentButton({required this.consent, required this.description});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => showDialog(
            context: context,
            useRootNavigator: true,
            useSafeArea: false,
            builder: (context) => _FullConsentDialog(consent: consent, description: description),
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TranslatedText(
            'i18n://requestRenderer.consent.showFullConsent',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Gaps.w8,
          Icon(Icons.article_outlined, color: Theme.of(context).colorScheme.primary, size: 14),
        ],
      ),
    );
  }
}

class _FullConsentDialog extends StatelessWidget {
  final String consent;
  final String? description;

  const _FullConsentDialog({required this.consent, required this.description});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Scaffold(
        appBar: AppBar(leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()), title: Text('Einverständniserklärung')),
        body: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).copyWith(bottom: MediaQuery.of(context).viewPadding.bottom + 24),
            child: Column(
              spacing: 32,
              children: [
                if (description != null) Text(description!, style: Theme.of(context).textTheme.bodyMedium),
                Text(consent, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  final String link;
  final String? linkDisplayText;

  const _LinkButton({required this.link, required this.linkDisplayText});
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
            linkDisplayText ?? 'i18n://requestRenderer.consent.defaultLinkDisplayText',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Gaps.w8,
          Icon(Icons.arrow_outward, color: Theme.of(context).colorScheme.primary, size: 14),
        ],
      ),
    );
  }
}
