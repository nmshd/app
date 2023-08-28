import 'package:enmeshed_types/enmeshed_types.dart';

import 'event.dart';

class ExternalEventReceivedEvent extends Event {
  final List<MessageDTO> messages;
  final List<RelationshipDTO> relationships;

  const ExternalEventReceivedEvent({
    required this.messages,
    required this.relationships,
    required super.eventTargetAddress,
  });
}
