import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class ThirdPartyRelationshipAttributeSucceededEvent extends Event {
  final LocalAttributeDTO predecessor;
  final LocalAttributeDTO successor;

  const ThirdPartyRelationshipAttributeSucceededEvent({required this.predecessor, required this.successor, required super.eventTargetAddress});
}
