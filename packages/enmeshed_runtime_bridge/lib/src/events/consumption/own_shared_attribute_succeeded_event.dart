import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class OwnSharedAttributeSucceededEvent extends Event {
  final LocalAttributeDTO predecessor;
  final LocalAttributeDTO successor;

  OwnSharedAttributeSucceededEvent({required this.predecessor, required this.successor, required super.eventTargetAddress});
}
