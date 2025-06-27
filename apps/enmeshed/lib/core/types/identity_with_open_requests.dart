import 'package:enmeshed_types/enmeshed_types.dart';

typedef IdentityWithOpenRequests = ({IdentityDVO contact, List<LocalRequestDVO> openRequests});

extension IdentityWithOpenRequestsExtension on IdentityWithOpenRequests {
  bool get requiresAttention {
    return switch (this.contact.relationship?.status) {
      null => false,
      RelationshipStatus.Terminated || RelationshipStatus.DeletionProposed => true,
      _ => this.openRequests.isNotEmpty,
    };
  }
}
