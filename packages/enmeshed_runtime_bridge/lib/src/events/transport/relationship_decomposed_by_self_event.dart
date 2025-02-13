import '../event.dart';

class RelationshipDecomposedBySelfEvent extends Event {
  final String relationshipId;

  const RelationshipDecomposedBySelfEvent({required super.eventTargetAddress, required this.relationshipId});
}
