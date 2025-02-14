import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class OwnSharedAttributeDeletedByOwnerEvent extends Event {
  final LocalAttributeDTO data;

  const OwnSharedAttributeDeletedByOwnerEvent({required this.data, required super.eventTargetAddress});
}
