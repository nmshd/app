import 'package:enmeshed_types/enmeshed_types.dart';

typedef IdentityWithOpenRequests = ({IdentityDVO contact, List<LocalRequestDVO> openRequests});

extension IdentityWithOpenRequestsExtension on IdentityWithOpenRequests {
  bool get requiresAttention {
    if (this.openRequests.isNotEmpty) return true;

    return switch (this.contact.relationship?.status) {
      null || RelationshipStatus.Terminated || RelationshipStatus.DeletionProposed => true,
      _ => false,
    };
  }
}
