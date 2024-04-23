import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class PeerSharedAttributeDeletedByPeerEvent extends Event {
  final LocalAttributeDTO data;

  const PeerSharedAttributeDeletedByPeerEvent({
    required this.data,
    required super.eventTargetAddress,
  });
}
