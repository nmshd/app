import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import './decidable/checkbox_enabled_extension.dart';
import './decidable/widgets/handle_checkbox_change.dart';
import './decidable/widgets/manual_decision_required.dart';

class TransferFileOwnershipRequestItemRenderer extends StatefulWidget {
  final RequestItemDVODerivation item;
  final FileDVO file;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;

  final RequestValidationResultDTO? validationResult;

  bool get isDecidable => item is DecidableTransferFileOwnershipRequestItemDVO;

  const TransferFileOwnershipRequestItemRenderer({
    super.key,
    required this.item,
    required this.file,
    this.controller,
    required this.itemIndex,
    required this.expandFileReference,
    required this.openFileDetails,
    this.validationResult,
  }) : assert(
         item is TransferFileOwnershipRequestItemDVO || item is DecidableTransferFileOwnershipRequestItemDVO,
         'item must be of type TransferFileOwnershipRequestItemDVO or DecidableTransferFileOwnershipRequestItemDVO',
       );

  @override
  State<TransferFileOwnershipRequestItemRenderer> createState() => _DecidableTransferFileOwnershipRequestItemRendererState();
}

class _DecidableTransferFileOwnershipRequestItemRendererState extends State<TransferFileOwnershipRequestItemRenderer> {
  late bool _isChecked;
  bool _isManualDecisionAccepted = false;

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
    final translatedTitle = widget.file.name.startsWith('i18n://') ? FlutterI18n.translate(context, widget.file.name.substring(7)) : widget.file.name;
    final title = widget.item.mustBeAccepted ? '$translatedTitle*' : translatedTitle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              Checkbox(
                value: _isChecked || (widget.item.requireManualDecision ?? false),
                onChanged:
                    widget.isDecidable && (widget.item.mustBeAccepted || (widget.item.requireManualDecision ?? false)) ? null : _onUpdateDecision,
              ),
              FileIcon(filename: widget.file.filename, color: Theme.of(context).colorScheme.primary, size: 32),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.labelMedium),
                    Text(widget.file.filename, style: Theme.of(context).textTheme.bodyLarge),
                    if (widget.file.description != null) Text(widget.file.description!, style: Theme.of(context).textTheme.labelMedium),
                  ],
                ),
              ),
            ],
          ),
          if (widget.item.requireManualDecision ?? false)
            ManualDecisionRequired(
              isManualDecisionAccepted: _isManualDecisionAccepted,
              onUpdateManualDecision: widget.isDecidable ? _onUpdateDecision : null,
              i18nKey: 'i18n://requestRenderer.manualDecisionRequired.description.fileTransfer',
            ),
          if (!(widget.validationResult?.isSuccess ?? true))
            Material(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.error,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: 4,
                  children: [
                    Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
                    Expanded(
                      child: TranslatedText(
                        'i18n://requestRenderer.errors.${widget.validationResult!.code!}',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onError),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onUpdateDecision(bool? value) {
    if (value == null) return;

    setState(() {
      if (widget.item.requireManualDecision ?? false) {
        _isManualDecisionAccepted = value;
      } else {
        _isChecked = value;
      }
    });

    handleCheckboxChange(
      isChecked: (widget.item.requireManualDecision ?? false) ? _isManualDecisionAccepted : _isChecked,
      controller: widget.controller,
      itemIndex: widget.itemIndex,
    );
  }
}
