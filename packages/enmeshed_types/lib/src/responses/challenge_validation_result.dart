import '../dtos/dtos.dart';

class ChallengeValidationResult {
  final bool isValid;
  final RelationshipDTO? correspondingRelationship;

  ChallengeValidationResult({
    required this.isValid,
    this.correspondingRelationship,
  });

  factory ChallengeValidationResult.fromJson(Map<String, dynamic> json) {
    return ChallengeValidationResult(
      isValid: json['isValid'],
      correspondingRelationship: json['correspondingRelationship'] != null ? RelationshipDTO.fromJson(json['correspondingRelationship']) : null,
    );
  }
}
