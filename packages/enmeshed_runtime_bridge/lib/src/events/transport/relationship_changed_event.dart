import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class RelationshipChangedEvent extends Event {
  final RelationshipDTO data;

  const RelationshipChangedEvent({required this.data, required super.eventTargetAddress});
}
