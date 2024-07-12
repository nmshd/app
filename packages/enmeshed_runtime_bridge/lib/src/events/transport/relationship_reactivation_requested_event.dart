import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class RelationshipReactivationRequestedEvent extends Event {
  final RelationshipDTO data;

  const RelationshipReactivationRequestedEvent({
    required this.data,
    required super.eventTargetAddress,
  });
}
