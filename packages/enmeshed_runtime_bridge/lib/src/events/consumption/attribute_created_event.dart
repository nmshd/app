import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class AttributeCreatedEvent extends Event {
  final LocalAttributeDTO data;

  const AttributeCreatedEvent({required this.data, required super.eventTargetAddress});
}
