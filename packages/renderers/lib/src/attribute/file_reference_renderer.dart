import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

class FileReferenceRenderer extends StatefulWidget {
  final String fileReference;
  final String valueType;
  final bool showTitle;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;
  final Widget? trailing;

  const FileReferenceRenderer({
    super.key,
    required this.fileReference,
    required this.valueType,
    this.showTitle = true,
    required this.expandFileReference,
    required this.openFileDetails,
    this.trailing,
  });

  @override
  State<FileReferenceRenderer> createState() => _FileReferenceRendererState();
}

class _FileReferenceRendererState extends State<FileReferenceRenderer> {
  FileDVO? expandedFileReference;

  @override
  void initState() {
    super.initState();

    widget.expandFileReference(widget.fileReference).then((value) {
      if (mounted) {
        setState(() {
          expandedFileReference = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.showTitle)
                TranslatedText('i18n://dvo.attribute.name.${widget.valueType}', style: const TextStyle(fontSize: 12, color: Color(0xFF42474E))),
              if (expandedFileReference == null)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(width: 80, child: LinearProgressIndicator()),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(expandedFileReference!.title),
                    Text(expandedFileReference!.filename),
                  ],
                ),
            ],
          ),
        ),
        IconButton(
          onPressed: expandedFileReference != null ? () => widget.openFileDetails(expandedFileReference!) : null,
          icon: const Icon(Icons.info),
        ),
        if (widget.trailing != null) widget.trailing!
      ],
    );
  }
}
