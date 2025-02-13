import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class MessageReceivedEvent extends Event {
  final MessageDTO data;

  const MessageReceivedEvent({required this.data, required super.eventTargetAddress});
}
