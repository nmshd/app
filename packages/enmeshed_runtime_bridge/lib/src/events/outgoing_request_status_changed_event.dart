import 'package:enmeshed_types/enmeshed_types.dart';

import 'event.dart';

class OutgoingRequestStatusChangedEvent extends Event {
  final LocalRequestDTO request;
  final LocalRequestStatus oldStatus;
  final LocalRequestStatus newStatus;

  const OutgoingRequestStatusChangedEvent({
    required this.request,
    required this.oldStatus,
    required this.newStatus,
    required super.eventTargetAddress,
  });
}
