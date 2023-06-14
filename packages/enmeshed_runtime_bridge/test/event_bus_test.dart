import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart' show EventBus, Event;
import 'package:test/test.dart';

class EventA extends Event {
  String text;

  EventA(this.text, {super.eventTargetAddress = 'id1'});
}

class EventB extends Event {
  String text;

  EventB(this.text, {super.eventTargetAddress = 'id1'});
}

class EventWithMap extends Event {
  Map myMap;

  EventWithMap(this.myMap, {super.eventTargetAddress = 'id1'});
}

main() {
  group('[EventBus]', () {
    test('publish one event', () async {
      final eventBus = EventBus();
      final Future f = eventBus.on<EventA>().toList();

      eventBus.publish(EventA('a1'));
      eventBus.close();

      final events = await f;
      expect(events.length, 1);
    });

    test('publish two events of same type', () async {
      final eventBus = EventBus();
      final Future f = eventBus.on<EventA>().toList();

      eventBus.publish(EventA('a1'));
      eventBus.publish(EventA('a2'));
      eventBus.close();

      final events = await f;
      expect(events.length, 2);
    });

    test('publish events of different type', () async {
      final eventBus = EventBus();
      final Future f1 = eventBus.on<EventA>().toList();
      final Future f2 = eventBus.on<EventB>().toList();

      eventBus.publish(EventA('a1'));
      eventBus.publish(EventB('b1'));
      eventBus.close();

      final aEvents = await f1;
      final bEvents = await f2;

      expect(aEvents.length, 1);
      expect(bEvents.length, 1);
    });

    test('publish events of different type, receive all types', () async {
      final eventBus = EventBus();
      final Future f = eventBus.on().toList();

      eventBus.publish(EventA('a1'));
      eventBus.publish(EventB('b1'));
      eventBus.publish(EventB('b2'));
      eventBus.close();

      final events = await f;
      expect(events.length, 3);
    });

    test('publish event with a map type', () async {
      final eventBus = EventBus();
      final Future f = eventBus.on<EventWithMap>().toList();

      eventBus.publish(EventWithMap({'a': 'test'}));
      eventBus.close();

      final events = await f;
      expect(events.length, 1);
    });

    test('filters the eventTargetAddress', () async {
      final eventBus = EventBus();
      final Future f = eventBus.on<Event>(eventTargetAddress: 'id2').toList();

      eventBus.publish(EventA('a1', eventTargetAddress: 'id1'));
      eventBus.publish(EventA('a1', eventTargetAddress: 'id2'));
      eventBus.close();

      final events = await f;
      expect(events.length, 1);
    });
  });
}
