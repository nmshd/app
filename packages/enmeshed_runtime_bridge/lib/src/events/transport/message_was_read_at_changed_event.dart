import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class MessageWasReadAtChangedEvent extends Event {
  final MessageDTO data;

  const MessageWasReadAtChangedEvent({
    required this.data,
    required super.eventTargetAddress,
  });
}
