import 'package:enmeshed_types/enmeshed_types.dart';

typedef RequestOrRelationship = ({IdentityDVO contact, List<LocalRequestDVO> openRequests});

extension RequestOrRelationshipExtension on RequestOrRelationship {
  bool get requiresAttention {
    if (this.openRequests.isNotEmpty) return true;

    return switch (this.contact.relationship?.status) {
      null || RelationshipStatus.Terminated || RelationshipStatus.DeletionProposed => true,
      _ => false,
    };
  }
}
