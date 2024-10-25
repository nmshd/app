import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class ThirdPartyRelationshipAttributeDeletedByPeerEvent extends Event {
  final LocalAttributeDTO data;

  const ThirdPartyRelationshipAttributeDeletedByPeerEvent({
    required this.data,
    required super.eventTargetAddress,
  });
}
