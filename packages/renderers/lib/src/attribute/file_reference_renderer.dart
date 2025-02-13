import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class FileReferenceRenderer extends StatefulWidget {
  final String fileReference;
  final String valueType;
  final Widget? extraLine;
  final bool showTitle;
  final String Function(String)? titleOverride;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;
  final Widget? trailing;

  const FileReferenceRenderer({
    super.key,
    required this.fileReference,
    required this.valueType,
    this.extraLine,
    this.showTitle = true,
    this.titleOverride,
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
    _reloadFileFromReference();
  }

  @override
  void didUpdateWidget(covariant FileReferenceRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.fileReference != widget.fileReference) {
      setState(() => expandedFileReference = null);
      _reloadFileFromReference();
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = FlutterI18n.translate(context, 'dvo.attribute.name.${widget.valueType}');

    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.showTitle)
                Text(
                  widget.titleOverride != null ? widget.titleOverride!(title) : title,
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              if (expandedFileReference == null)
                const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: SizedBox(width: 80, child: LinearProgressIndicator()))
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(expandedFileReference!.title),
                    Text(expandedFileReference!.filename),
                    if (widget.extraLine != null) ...[const SizedBox(height: 2), widget.extraLine!],
                  ],
                ),
            ],
          ),
        ),
        IconButton(
          onPressed: expandedFileReference != null ? () => widget.openFileDetails(expandedFileReference!) : null,
          icon: const Icon(Icons.info),
        ),
        if (widget.trailing != null)
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: widget.trailing!,
          )
      ],
    );
  }

  void _reloadFileFromReference() async {
    final file = await widget.expandFileReference(widget.fileReference);

    if (mounted) {
      setState(() {
        expandedFileReference = file;
      });
    }
  }
}
