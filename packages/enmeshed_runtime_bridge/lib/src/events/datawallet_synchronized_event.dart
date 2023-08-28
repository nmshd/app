import 'package:enmeshed_runtime_bridge/src/events/event.dart';

class DatawalletSynchronizedEvent extends Event {
  const DatawalletSynchronizedEvent({required super.eventTargetAddress});
}
