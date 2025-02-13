import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class IdentityDeletionProcessStatusChangedEvent extends Event {
  final IdentityDeletionProcessDTO data;

  const IdentityDeletionProcessStatusChangedEvent({required this.data, required super.eventTargetAddress});
}
