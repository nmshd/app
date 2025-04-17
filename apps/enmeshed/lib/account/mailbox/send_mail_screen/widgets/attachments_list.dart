import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

import '/core/core.dart';

class AttachmentsList extends StatefulWidget {
  final List<FileDVO> attachments;
  final void Function(FileDVO)? removeFile;
  final String accountId;
  final Widget? trailing;

  const AttachmentsList({required this.attachments, required this.accountId, super.key, this.removeFile, this.trailing});

  @override
  State<AttachmentsList> createState() => _AttachmentsListState();
}

class _AttachmentsListState extends State<AttachmentsList> {
  bool _showAll = false;
  Iterable<FileDVO> get _visibleAttachments => _showAll ? widget.attachments : widget.attachments.take(5);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.attachments.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodySmall,
                children: [
                  TextSpan(text: context.l10n.mailbox_attachments(widget.attachments.length)),
                  const TextSpan(text: ' - '),
                  TextSpan(text: bytesText(bytes: widget.attachments.fold(0, (filesizeSum, e) => filesizeSum + e.filesize), context: context)),
                  const TextSpan(text: ' '),
                  TextSpan(text: context.l10n.mailbox_attachments_total),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        Gaps.h8,
        Wrap(
          spacing: 8,
          children:
              _visibleAttachments
                  .map(
                    (e) => _AttachmentItem(
                      attachment: e,
                      accountId: widget.accountId,
                      onDeleted: widget.removeFile != null ? () => widget.removeFile!(e) : null,
                    ),
                  )
                  .toList(),
        ),
        Row(
          children: [
            if (widget.attachments.length > 5)
              TextButton(
                onPressed: () => setState(() => _showAll = !_showAll),
                child: Text(
                  _showAll ? context.l10n.mailbox_attachments_showLess : context.l10n.mailbox_attachments_showMore(widget.attachments.length - 5),
                ),
              ),
            const Spacer(),
            if (widget.trailing != null) widget.trailing!,
          ],
        ),
      ],
    );
  }
}

class _AttachmentItem extends StatelessWidget {
  final FileDVO attachment;

  final String accountId;
  final VoidCallback? onDeleted;

  const _AttachmentItem({required this.attachment, required this.accountId, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return RawChip(
      avatar: FileIcon(filename: attachment.filename, color: Theme.of(context).colorScheme.primary),
      label: TranslatedText(attachment.title),
      onDeleted: onDeleted,
      deleteIcon: const Icon(Icons.close, size: 18),
      onPressed: () => context.push('/account/$accountId/my-data/files/${attachment.id}', extra: createFileRecord(file: attachment)),
    );
  }
}
