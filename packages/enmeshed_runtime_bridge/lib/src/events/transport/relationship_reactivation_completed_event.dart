import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class RelationshipReactivationCompletedEvent extends Event {
  final RelationshipDTO data;

  const RelationshipReactivationCompletedEvent({required this.data, required super.eventTargetAddress});
}
