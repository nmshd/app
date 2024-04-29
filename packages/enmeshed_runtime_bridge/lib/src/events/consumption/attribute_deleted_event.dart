import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class AttributeDeletedEvent extends Event {
  final LocalAttributeDTO data;

  const AttributeDeletedEvent({
    required this.data,
    required super.eventTargetAddress,
  });
}
