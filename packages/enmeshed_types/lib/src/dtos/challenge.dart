enum ChallengeType { Relationship, Identity, Device }

class ChallengeDTO {
  final String id;
  final String expiresAt;
  final String? createdBy;
  final String? createdByDevice;
  final ChallengeType type;
  final String signature;
  final String challengeString;

  ChallengeDTO({
    required this.id,
    required this.expiresAt,
    this.createdBy,
    this.createdByDevice,
    required this.type,
    required this.signature,
    required this.challengeString,
  });

  factory ChallengeDTO.fromJson(Map<String, dynamic> json) {
    return ChallengeDTO(
      id: json['id'],
      expiresAt: json['expiresAt'],
      createdBy: json['createdBy'],
      createdByDevice: json['createdByDevice'],
      type: ChallengeType.values.byName(json['type']),
      signature: json['signature'],
      challengeString: json['challengeString'],
    );
  }
}
