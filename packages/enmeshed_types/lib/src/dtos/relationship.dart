import 'package:equatable/equatable.dart';

import 'identity.dart';
import 'relationship_change.dart';
import 'relationship_template.dart';

enum RelationshipStatus { Pending, Active, Rejected, Revoked, Terminating, Terminated }

class RelationshipDTO extends Equatable {
  final String id;
  final RelationshipTemplateDTO template;
  final RelationshipStatus status;
  final String peer;
  final IdentityDTO peerIdentity;
  final List<RelationshipChangeDTO> changes;

  const RelationshipDTO({
    required this.id,
    required this.template,
    required this.status,
    required this.peer,
    required this.peerIdentity,
    required this.changes,
  });

  factory RelationshipDTO.fromJson(Map json) => RelationshipDTO(
        id: json['id'],
        template: RelationshipTemplateDTO.fromJson(json['template']),
        status: RelationshipStatus.values.byName(json['status']),
        peer: json['peer'],
        peerIdentity: IdentityDTO.fromJson(json['peerIdentity']),
        changes: List<RelationshipChangeDTO>.from(json['changes'].map((x) => RelationshipChangeDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'template': template.toJson(),
        'status': status.name,
        'peer': peer,
        'peerIdentity': peerIdentity.toJson(),
        'changes': changes.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'RelationshipDTO(id: $id, template: $template, status: $status, peer: $peer, peerIdentity: $peerIdentity, changes: $changes)';
  }

  @override
  // TODO: correctly compare Relationships
  List<Object?> get props => [id];
}
