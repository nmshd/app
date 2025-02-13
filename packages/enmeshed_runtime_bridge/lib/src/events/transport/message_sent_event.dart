import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class MessageSentEvent extends Event {
  final MessageDTO data;

  const MessageSentEvent({required this.data, required super.eventTargetAddress});
}
