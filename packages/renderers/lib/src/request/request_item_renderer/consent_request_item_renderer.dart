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
import 'widgets/validation_error_box.dart';

class ConsentRequestItemRenderer extends StatefulWidget {
  final ConsentRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  final RequestValidationResultDTO? validationResult;

  const ConsentRequestItemRenderer({super.key, required this.item, this.controller, required this.itemIndex, this.validationResult});

  @override
  State<ConsentRequestItemRenderer> createState() => _ConsentRequestItemRendererState();
}

class _ConsentRequestItemRendererState extends State<ConsentRequestItemRenderer> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();

    if (widget.item.response != null) {
      _isChecked = widget.item.response is AcceptResponseItemDVO;
    } else {
      _isChecked = widget.item.initiallyChecked;
    }

    if (_isChecked) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.item.name.startsWith('i18n://') ? FlutterI18n.translate(context, widget.item.name.substring(7)) : widget.item.name;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: title),
                if (widget.item.isDecidable && widget.item.mustBeAccepted) TextSpan(text: '*'),
              ],
            ),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (widget.item.description != null) Text(widget.item.description!, style: Theme.of(context).textTheme.bodySmall),
          Gaps.h8,
          _ConsentBox(item: widget.item, isChecked: _isChecked, onUpdateCheckbox: _onUpdateCheckbox),
          if (!(widget.validationResult?.isSuccess ?? true)) ...[Gaps.h8, ValidationErrorBox(validationResult: widget.validationResult!)],
        ],
      ),
    );
  }

  void _onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() => _isChecked = value);
    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: value ? const AcceptRequestItemParameters() : const RejectRequestItemParameters(),
    );
  }
}

class _ConsentBox extends StatelessWidget {
  final ConsentRequestItemDVO item;
  final bool isChecked;
  final void Function(bool?) onUpdateCheckbox;

  const _ConsentBox({required this.item, required this.isChecked, required this.onUpdateCheckbox});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(4),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: InkWell(
        onTap: _isSwitchDisabled ? null : () => onUpdateCheckbox(!isChecked),
        child: Table(
          columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
          children: [
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Switch(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                      (Set<WidgetState> states) => states.contains(WidgetState.selected) ? const Icon(Icons.check) : const Icon(Icons.close),
                    ),
                    activeColor: context.customColors.onSuccess,
                    value: isChecked,
                    activeTrackColor: _isSwitchDisabled ? context.customColors.success.withValues(alpha: 0.16) : context.customColors.success,
                    onChanged: _isSwitchDisabled ? null : onUpdateCheckbox,
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(item.consent, maxLines: 4, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                SizedBox.shrink(),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isTextOverflowing(context, constraints)) _ShowFullConsentButton(item: item),
                        if (item.link != null) _LinkButton(item: item),
                        if (_isTextOverflowing(context, constraints) || item.link != null) SizedBox.shrink(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool get _isSwitchDisabled => !item.isDecidable || item.initiallyChecked;

  bool _isTextOverflowing(BuildContext context, BoxConstraints constraints) {
    final textPainter = TextPainter(
      text: TextSpan(text: item.consent, style: Theme.of(context).textTheme.bodyMedium),
      maxLines: 4,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: constraints.maxWidth - 8);

    return textPainter.didExceedMaxLines;
  }
}

class _ShowFullConsentButton extends StatelessWidget {
  final ConsentRequestItemDVO item;

  const _ShowFullConsentButton({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        useRootNavigator: true,
        useSafeArea: false,
        builder: (context) => _FullConsentDialog(consent: item.consent, description: item.description),
      ),
      child: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          TranslatedText(
            'i18n://requestRenderer.consent.showFullConsent',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Icon(Icons.article_outlined, color: Theme.of(context).colorScheme.primary, size: 18),
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
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
          title: Text('Einverständniserklärung'),
        ),
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
  final ConsentRequestItemDVO item;

  const _LinkButton({required this.item});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final url = Uri.parse(item.link!);
        await GetIt.I.get<AbstractUrlLauncher>().launchSafe(url);
      },
      child: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          TranslatedText(
            item.linkDisplayText ?? 'i18n://requestRenderer.consent.defaultLinkDisplayText',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Icon(Icons.arrow_outward, color: Theme.of(context).colorScheme.primary, size: 20),
        ],
      ),
    );
  }
}
