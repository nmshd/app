import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;

import '/core/core.dart';

class AttachmentsList extends StatefulWidget {
  final List<FileDVO> attachments;
  final void Function(int)? removeFile;
  final String accountId;

  const AttachmentsList({
    required this.attachments,
    required this.accountId,
    super.key,
    this.removeFile,
  });

  @override
  State<AttachmentsList> createState() => _AttachmentsListState();
}

class _AttachmentsListState extends State<AttachmentsList> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      scrollbarOrientation: ScrollbarOrientation.bottom,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 45,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.attachments.length,
            itemBuilder: (context, index) => _AttachmentItem(
              attachment: widget.attachments[index],
              accountId: widget.accountId,
              removeFile: widget.removeFile != null ? () => widget.removeFile!(index) : null,
            ),
            separatorBuilder: (context, index) => Gaps.w8,
          ),
        ),
      ),
    );
  }
}

class _AttachmentItem extends StatelessWidget {
  final FileDVO attachment;
  final String accountId;
  final void Function()? removeFile;

  const _AttachmentItem({required this.attachment, required this.accountId, required this.removeFile});

  @override
  Widget build(BuildContext context) {
    var ext = path.extension(attachment.filename);
    if (ext.isNotEmpty) ext = ext.substring(1, ext.length);

    return Container(
      padding: const EdgeInsets.only(left: 8, right: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FileIcon(filename: attachment.filename, color: Theme.of(context).colorScheme.primary),
            Gaps.w8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  attachment.filename,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${ext.isNotEmpty ? '$ext - ' : ''}${bytesText(bytes: attachment.filesize, context: context)}',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            if (removeFile != null) IconButton(icon: const Icon(Icons.cancel_outlined), iconSize: 22, onPressed: removeFile),
          ],
        ),
        onTap: () => context.push('/account/$accountId/my-data/files/${attachment.id}', extra: attachment),
      ),
    );
  }
}
