import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

class FileReferenceRenderer extends StatelessWidget {
  final String fileReference;
  final String valueType;
  final bool showTitle;
  final Future<FileDVO> Function(String) expandFileReference;
  final Widget? trailing;

  const FileReferenceRenderer({
    super.key,
    required this.fileReference,
    required this.valueType,
    this.showTitle = true,
    required this.expandFileReference,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showTitle) TranslatedText('i18n://dvo.attribute.name.$valueType', style: const TextStyle(fontSize: 12, color: Color(0xFF42474E))),
              FutureBuilder(
                future: expandFileReference(fileReference),
                builder: (context, snapshot) => snapshot.hasData
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.title),
                          Text(snapshot.data!.filename),
                        ],
                      )
                    : const SizedBox(height: 20, width: 20, child: LinearProgressIndicator()),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing!
      ],
    );
  }
}
