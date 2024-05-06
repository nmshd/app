import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class FileIcon extends StatelessWidget {
  final String filename;
  final Color? color;
  final double? size;

  const FileIcon({required this.filename, super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(
      switch (path.extension(filename)) {
        '.pdf' => Icons.picture_as_pdf,
        '.jpg' || '.jpeg' || '.png' => Icons.image,
        _ => Icons.question_mark,
      },
      color: color,
      size: size,
    );
  }
}
