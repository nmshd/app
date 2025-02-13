import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class PeerToBeDeletedEvent extends Event {
  final RelationshipDTO data;

  const PeerToBeDeletedEvent({required this.data, required super.eventTargetAddress});
}
