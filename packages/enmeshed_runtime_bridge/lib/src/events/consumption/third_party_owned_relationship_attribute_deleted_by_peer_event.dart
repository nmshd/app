import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class ThirdPartyOwnedRelationshipAttributeDeletedByPeerEvent extends Event {
  final LocalAttributeDTO data;

  const ThirdPartyOwnedRelationshipAttributeDeletedByPeerEvent({
    required this.data,
    required super.eventTargetAddress,
  });
}
