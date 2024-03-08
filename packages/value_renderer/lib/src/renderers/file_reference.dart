import 'dart:async';

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

import '../utils/utils.dart';
import '../value_renderer_controller.dart';

class FileReferenceRenderer extends StatefulWidget {
  final ValueRendererController? controller;
  final String? fieldName;
  final AttributeValue? initialValue;
  final bool mustBeFilledOut;
  final ValueHints valueHints;
  final Future<FileDVO> Function(String) expandFileReference;
  final Future<FileDVO?> Function() chooseFile;

  const FileReferenceRenderer({
    super.key,
    this.controller,
    this.fieldName,
    this.initialValue,
    required this.mustBeFilledOut,
    required this.valueHints,
    required this.expandFileReference,
    required this.chooseFile,
  });

  @override
  State<FileReferenceRenderer> createState() => _FileReferenceRendererState();
}

class _FileReferenceRendererState extends State<FileReferenceRenderer> {
  FileDVO? selectedFile;
  bool initialLoadComplete = false;

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      final truncatedReference = switch (widget.initialValue) {
        final IdentityFileReferenceAttributeValue fileReference => fileReference.value,
        final ProprietaryFileReferenceAttributeValue fileReference => fileReference.value,
        _ => throw Exception('Invalid file reference type'),
      };

      widget.expandFileReference(truncatedReference).then((value) {
        if (mounted) {
          setState(() {
            selectedFile = value;
            initialLoadComplete = true;
          });
        }

        widget.controller?.value = ValueRendererInputValueString(value.truncatedReference);
      });
    } else {
      initialLoadComplete = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.fieldName != null ? TranslatedText(widget.fieldName!) : null;
    final subtitle = !initialLoadComplete
        ? const LinearProgressIndicator()
        : selectedFile != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(selectedFile!.title),
                  Text(selectedFile!.filename),
                ],
              )
            : const TranslatedText('i18n://valueRenderer.fileReference.noFileSelected');

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: title ?? subtitle,
      subtitle: title != null ? subtitle : null,
      trailing: TextButton(
        child: const TranslatedText('i18n://valueRenderer.fileReference.selectFile'),
        onPressed: () async {
          final file = await widget.chooseFile();
          if (file != null) {
            setState(() {
              selectedFile = file;
            });

            widget.controller?.value = ValueRendererInputValueString(file.truncatedReference);
          }
        },
      ),
    );
  }
}
