import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class PeerSharedAttributeSucceededEvent extends Event {
  final LocalAttributeDTO predecessor;
  final LocalAttributeDTO successor;

  PeerSharedAttributeSucceededEvent({
    required this.predecessor,
    required this.successor,
    required super.eventTargetAddress,
  });
}
