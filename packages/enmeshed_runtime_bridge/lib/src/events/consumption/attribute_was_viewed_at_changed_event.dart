import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class AttributeWasViewedAtChangedEvent extends Event {
  final LocalAttributeDTO data;

  const AttributeWasViewedAtChangedEvent({required this.data, required super.eventTargetAddress});
}
