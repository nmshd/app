import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class OutgoingRequestCreatedEvent extends Event {
  final LocalRequestDTO data;

  const OutgoingRequestCreatedEvent({
    required this.data,
    required super.eventTargetAddress,
  });
}
