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
          Text(widget.item.name, style: Theme.of(context).textTheme.titleMedium),
          if (widget.item.description != null) Text(widget.item.description!, style: Theme.of(context).textTheme.bodySmall),
          if ((widget.item.requireManualDecision != null && widget.item.requireManualDecision!) || true && widget.item.consent.isNotEmpty) ...[
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
                        children: [
                          if (widget.item.requireManualDecision == true) ...[
                            Switch(
                              thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                                (Set<WidgetState> states) =>
                                    states.contains(WidgetState.selected) ? const Icon(Icons.check) : const Icon(Icons.close),
                              ),
                              activeColor: context.customColors.onSuccess,
                              value: _isChecked,
                              activeTrackColor: context.customColors.success,
                              onChanged: widget.item.checkboxEnabled ? onUpdateCheckbox : null,
                            ),
                            Gaps.w8,
                          ],
                          Expanded(child: Text(widget.item.consent)),
                        ],
                      ),
                      if (widget.item.link != null)
                        Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                            left: widget.item.requireManualDecision == true && widget.item.consent.isNotEmpty ? 68 : 0,
                          ),
                          child: _LinkButton(link: widget.item.link!, linkDisplayText: widget.item.linkDisplayText),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ] else if (widget.item.link != null) ...[
            Gaps.h8,
            _LinkButton(link: widget.item.link!, linkDisplayText: widget.item.linkDisplayText),
          ],
        ],
      ),
    );
  }

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() {
      _isChecked = value;
    });

    handleCheckboxChange(isChecked: _isChecked, controller: widget.controller, itemIndex: widget.itemIndex);
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
            linkDisplayText ?? 'i18n://requestRenderer.defaultLinkDisplayText',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Gaps.w8,
          Icon(Icons.arrow_outward, color: Theme.of(context).colorScheme.primary, size: 12),
        ],
      ),
    );
  }
}
