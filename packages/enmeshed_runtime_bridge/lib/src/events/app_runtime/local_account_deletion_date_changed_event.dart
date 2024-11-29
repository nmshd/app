import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class LocalAccountDeletionDateChangedEvent extends Event {
  final LocalAccountDTO data;

  const LocalAccountDeletionDateChangedEvent({
    required super.eventTargetAddress,
    required this.data,
  });
}
