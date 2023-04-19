import 'package:equatable/equatable.dart';

enum ChallengeType { Relationship, Identity, Device }

class ChallengeDTO extends Equatable {
  final String id;
  final String expiresAt;
  final String? createdBy;
  final String? createdByDevice;
  final ChallengeType type;
  final String signature;
  final String challengeString;

  const ChallengeDTO({
    required this.id,
    required this.expiresAt,
    this.createdBy,
    this.createdByDevice,
    required this.type,
    required this.signature,
    required this.challengeString,
  });

  factory ChallengeDTO.fromJson(Map json) => ChallengeDTO(
        id: json['id'],
        expiresAt: json['expiresAt'],
        createdBy: json['createdBy'],
        createdByDevice: json['createdByDevice'],
        type: ChallengeType.values.byName(json['type']),
        signature: json['signature'],
        challengeString: json['challengeString'],
      );

  @override
  List<Object?> get props => [id, expiresAt, createdBy, createdByDevice, type, signature, challengeString];
}
