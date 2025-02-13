import 'package:equatable/equatable.dart';

import '../dtos/dtos.dart';

class ChallengeValidationResult extends Equatable {
  final bool isValid;
  final RelationshipDTO? correspondingRelationship;

  const ChallengeValidationResult({required this.isValid, this.correspondingRelationship});

  factory ChallengeValidationResult.fromJson(Map json) {
    return ChallengeValidationResult(
      isValid: json['isValid'],
      correspondingRelationship: json['correspondingRelationship'] != null ? RelationshipDTO.fromJson(json['correspondingRelationship']) : null,
    );
  }

  @override
  List<Object?> get props => [isValid, correspondingRelationship];
}
