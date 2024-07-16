import '../event.dart';

class RelationshipDecomposedBySelfEvent extends Event {
  final String data;

  const RelationshipDecomposedBySelfEvent({
    required this.data,
    required super.eventTargetAddress,
  });
}
