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
  final TransferFileOwnershipRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO, [LocalAttributeDVO?]) openFileDetails;

  final RequestValidationResultDTO? validationResult;

  const TransferFileOwnershipRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    required this.expandFileReference,
    required this.openFileDetails,
    this.validationResult,
  });

  @override
  State<TransferFileOwnershipRequestItemRenderer> createState() => _DecidableTransferFileOwnershipRequestItemRendererState();
}

class _DecidableTransferFileOwnershipRequestItemRendererState extends State<TransferFileOwnershipRequestItemRenderer> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();

    _isChecked = widget.item.initiallyChecked || (widget.item.response is TransferFileOwnershipAcceptResponseItemDVO);

    if (_isChecked) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
    }
  }

  @override
  Widget build(BuildContext context) {
    final translatedTitle =
        widget.item.file.name.startsWith('i18n://') ? FlutterI18n.translate(context, widget.item.file.name.substring(7)) : widget.item.file.name;
    final title = widget.item.mustBeAccepted && widget.item.response == null ? '$translatedTitle*' : translatedTitle;

    return InkWell(
      onTap: () async {
        if (widget.item.response is TransferFileOwnershipAcceptResponseItemDVO) {
          final response = widget.item.response as TransferFileOwnershipAcceptResponseItemDVO;
          final attribute = response.repositoryAttribute ?? response.sharedAttribute;
          final fileDvo = await widget.expandFileReference((attribute.value as IdentityFileReferenceAttributeValue).value);

          widget.openFileDetails(fileDvo, attribute);
          return;
        }

        widget.openFileDetails(widget.item.file);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          spacing: 8,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card.filled(
                margin: EdgeInsets.only(left: widget.item.isDecidable ? 48 + 8 : 0),
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: TranslatedText('i18n://requestRenderer.description.transferFileOwnership'),
                ),
              ),
            ),
            Row(
              spacing: 8,
              children: [
                if (widget.item.isDecidable)
                  Checkbox(
                    value: _isChecked || (widget.item.requireManualDecision ?? false),
                    onChanged: widget.item.mustBeAccepted || (widget.item.requireManualDecision ?? false) ? null : _onUpdateDecision,
                  ),
                FileIcon(filename: widget.item.file.filename, color: Theme.of(context).colorScheme.primary, size: 32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.labelMedium),
                      Text(widget.item.file.filename, style: Theme.of(context).textTheme.bodyLarge),
                      if (widget.item.file.description != null) Text(widget.item.file.description!, style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
            if (widget.item.requireManualDecision ?? false)
              ManualDecisionRequired(
                isManualDecisionAccepted: _isChecked,
                onUpdateManualDecision: widget.item.isDecidable ? _onUpdateDecision : null,
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
      ),
    );
  }

  void _onUpdateDecision(bool? value) {
    if (value == null) return;

    setState(() => _isChecked = value);

    handleCheckboxChange(isChecked: _isChecked, controller: widget.controller, itemIndex: widget.itemIndex);
  }
}
