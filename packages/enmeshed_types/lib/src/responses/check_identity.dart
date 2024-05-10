import 'package:equatable/equatable.dart';

import '../dtos/dtos.dart';

class CheckIdentityResponse extends Equatable {
  final bool? unknown;
  final bool? self;
  final bool? peer;
  final bool? relationshipPending;
  final bool? relationshipActive;
  final bool? relationshipTerminated;
  final RelationshipDTO? relationship;

  const CheckIdentityResponse(
      {this.unknown, this.self, this.peer, this.relationshipPending, this.relationshipActive, this.relationshipTerminated, this.relationship});

  factory CheckIdentityResponse.fromJson(Map json) {
    return CheckIdentityResponse(
      unknown: json['unknown'],
      self: json['self'],
      peer: json['peer'],
      relationshipPending: json['relationshipPending'],
      relationshipActive: json['relationshipActive'],
      relationshipTerminated: json['relationshipTerminated'],
      relationship: json['relationship'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (unknown != null) 'unknown': unknown,
        if (self != null) 'self': self,
        if (peer != null) 'peer': peer,
        if (relationshipPending != null) 'relationshipPending': relationshipPending,
        if (relationshipActive != null) 'relationshipActive': relationshipActive,
        if (relationshipTerminated != null) 'relationshipTerminated': relationshipTerminated,
        if (relationship != null) 'relationship': relationship,
      };

  @override
  List<Object?> get props => [unknown, self, peer, relationshipPending, relationshipActive, relationshipTerminated, relationship];
}
