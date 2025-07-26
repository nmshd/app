import 'package:flutter/material.dart';

enum FilesFilterOption {
  all(Icons.format_list_bulleted, Icons.format_list_bulleted),
  unviewed(Icons.new_releases, Icons.new_releases_outlined),
  expired(Icons.error, Icons.error_outline),
  type(Icons.insert_drive_file, null),
  tag(Icons.bookmark, null);

  final IconData filterIcon;
  final IconData? emptyListIcon;

  const FilesFilterOption(this.filterIcon, this.emptyListIcon);
}
