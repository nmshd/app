import 'package:enmeshed_types/enmeshed_types.dart';

typedef RequestOrRelationship = ({IdentityDVO contact, LocalRequestDVO? openContactRequest});

extension RequestOrRelationshipExtension on RequestOrRelationship {
  bool get requiresAttention {
    if (this.openContactRequest != null) return true;

    return switch (this.contact.relationship?.status) {
      null || RelationshipStatus.Terminated || RelationshipStatus.DeletionProposed => true,
      _ => false,
    };
  }
}
