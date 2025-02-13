import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class PeerDeletedEvent extends Event {
  final RelationshipDTO data;

  const PeerDeletedEvent({required this.data, required super.eventTargetAddress});
}
