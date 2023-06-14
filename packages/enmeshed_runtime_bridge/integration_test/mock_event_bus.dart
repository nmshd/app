import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';

class MockEventBus extends EventBus {
  final List<Event> _events = [];

  MockEventBus() {
    on<Event>().listen((event) => _events.add(event));
  }

  Future<T> waitForEvent<T extends Event>({
    required String eventTargetAddress,
    bool Function(T)? predicate,
    timeout = const Duration(minutes: 1),
  }) async {
    eventMatches(Event event) => event is T && event.eventTargetAddress == eventTargetAddress && (predicate == null || predicate(event));

    final alreadyTriggeredEvents = _events.where(eventMatches).cast<T>().toList();
    if (alreadyTriggeredEvents.isNotEmpty) return alreadyTriggeredEvents.first;

    final event = on<T>()
        .firstWhere(eventMatches)
        .timeout(timeout, onTimeout: () => throw Exception("Timeout on waiting for '$T' event for account '$eventTargetAddress'"));
    return event;
  }

  void reset() {
    _events.clear();
  }
}
