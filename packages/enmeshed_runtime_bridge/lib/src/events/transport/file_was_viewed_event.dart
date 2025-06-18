import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class FileWasViewedEvent extends Event {
  final FileDTO data;

  const FileWasViewedEvent({required this.data, required super.eventTargetAddress});
}
