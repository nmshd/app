import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class PeerDeletionCancelledEvent extends Event {
  final RelationshipDTO data;

  const PeerDeletionCancelledEvent({
    required this.data,
    required super.eventTargetAddress,
  });
}
