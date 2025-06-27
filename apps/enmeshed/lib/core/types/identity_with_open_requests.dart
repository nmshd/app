import 'package:enmeshed_types/enmeshed_types.dart';

typedef IdentityWithOpenRequests = ({IdentityDVO contact, List<LocalRequestDVO> openRequests});

extension IdentityWithOpenRequestsExtension on IdentityWithOpenRequests {
  bool get requiresAttention => switch (this.contact.relationship?.status) {
    null => true,
    RelationshipStatus.Terminated || RelationshipStatus.DeletionProposed => true,
    _ => this.openRequests.isNotEmpty,
  };
}
