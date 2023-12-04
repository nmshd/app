import 'package:enmeshed_types/enmeshed_types.dart';

import '../event.dart';

class IncomingRequestReceivedEvent extends Event {
  final LocalRequestDTO data;

  const IncomingRequestReceivedEvent({
    required this.data,
    required super.eventTargetAddress,
  });
}
