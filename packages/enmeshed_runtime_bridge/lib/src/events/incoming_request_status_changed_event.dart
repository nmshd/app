import 'package:enmeshed_types/enmeshed_types.dart';

import 'event.dart';

class IncomingRequestStatusChangedEvent extends Event {
  final LocalRequestDTO request;
  final LocalRequestStatus oldStatus;
  final LocalRequestStatus newStatus;

  const IncomingRequestStatusChangedEvent({
    required this.request,
    required this.oldStatus,
    required this.newStatus,
    required super.namespace,
    required super.eventTargetAddress,
  });
}
