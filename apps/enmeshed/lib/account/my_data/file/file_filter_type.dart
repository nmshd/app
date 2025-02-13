import 'package:flutter/widgets.dart';

import '/core/core.dart';

sealed class FileFilterType {
  const FileFilterType();

  String toLabel(BuildContext context);

  factory FileFilterType.fromMimetype(String mimetype) => switch (mimetype) {
    'image/jpeg' => const JPGFileFilterType(),
    'application/pdf' => const PDFFileFilterType(),
    'image/png' => const PNGFileFilterType(),
    'application/vnd.ms-powerpoint' ||
    'application/vnd.openxmlformats-officedocument.presentationml.presentation' => const PowerPointDocumentFileFilterType(),
    'application/msword' || 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => const WordDocumentFileFilterType(),
    _ => const OtherFileFilterType(),
  };
}

@immutable
class JPGFileFilterType extends FileFilterType {
  const JPGFileFilterType();

  @override
  bool operator ==(Object other) => other is JPGFileFilterType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toLabel(BuildContext context) => context.l10n.files_fileType_jpg;
}

@immutable
class PDFFileFilterType extends FileFilterType {
  const PDFFileFilterType();

  @override
  bool operator ==(Object other) => other is PDFFileFilterType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toLabel(BuildContext context) => context.l10n.files_fileType_pdf;
}

@immutable
class PNGFileFilterType extends FileFilterType {
  const PNGFileFilterType();

  @override
  bool operator ==(Object other) => other is PNGFileFilterType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toLabel(BuildContext context) => context.l10n.files_fileType_png;
}

@immutable
class PowerPointDocumentFileFilterType extends FileFilterType {
  const PowerPointDocumentFileFilterType();

  @override
  bool operator ==(Object other) => other is PowerPointDocumentFileFilterType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toLabel(BuildContext context) => context.l10n.files_fileType_powerPoint;
}

@immutable
class WordDocumentFileFilterType extends FileFilterType {
  const WordDocumentFileFilterType();

  @override
  bool operator ==(Object other) => other is WordDocumentFileFilterType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toLabel(BuildContext context) => context.l10n.files_fileType_word;
}

@immutable
class OtherFileFilterType extends FileFilterType {
  const OtherFileFilterType();

  @override
  bool operator ==(Object other) => other is OtherFileFilterType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toLabel(BuildContext context) => context.l10n.files_fileType_other;
}
