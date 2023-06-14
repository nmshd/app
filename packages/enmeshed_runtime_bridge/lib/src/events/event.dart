abstract class Event {
  final String eventTargetAddress;

  const Event({required this.eventTargetAddress});
}

class ArbitraryEvent extends Event {
  final String namespace;
  final Map<String, dynamic> data;

  const ArbitraryEvent({
    required this.namespace,
    required super.eventTargetAddress,
    required this.data,
  });
}
