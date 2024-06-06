import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class ThirdPartyOwnedRelationshipAttributeSucceededEvent extends Event {
  final LocalAttributeDTO predecessor;
  final LocalAttributeDTO successor;

  const ThirdPartyOwnedRelationshipAttributeSucceededEvent({
    required this.predecessor,
    required this.successor,
    required super.eventTargetAddress,
  });
}
