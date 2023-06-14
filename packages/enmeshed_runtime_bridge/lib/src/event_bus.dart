import 'dart:async';

import 'events/events.dart';

class EventBus {
  final StreamController _streamController;

  EventBus({bool sync = false, StreamController? controller}) : _streamController = controller ?? StreamController.broadcast(sync: sync);

  Stream<T> on<T extends Event>({String? eventTargetAddress}) {
    Stream<T> stream = _streamController.stream.where((event) => event is T).cast<T>();
    if (eventTargetAddress != null) stream = stream.where((event) => event.eventTargetAddress == eventTargetAddress);

    return stream;
  }

  void publish(Event event) => _streamController.add(event);

  void close() => _streamController.close();
}
