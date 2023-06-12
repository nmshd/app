abstract class Event {
  final String namespace;
  final String eventTargetAddress;

  const Event({required this.eventTargetAddress, required this.namespace});
}

class ArbitraryEvent extends Event {
  final Map<String, dynamic> data;

  const ArbitraryEvent({
    required super.namespace,
    required super.eventTargetAddress,
    required this.data,
  });
}
