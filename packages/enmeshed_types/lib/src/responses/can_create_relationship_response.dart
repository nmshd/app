import 'package:json_annotation/json_annotation.dart';

part 'can_create_relationship_response.g.dart';

sealed class CanCreateRelationshipResponse {
  final bool isSuccess;

  CanCreateRelationshipResponse({required this.isSuccess});

  factory CanCreateRelationshipResponse.fromJson(Map<String, dynamic> json) => switch (json['isSuccess']) {
    true => CanCreateRelationshipSuccessResponse.fromJson(json),
    false => CanCreateRelationshipFailureResponse.fromJson(json),
    _ => throw Exception('A CanCreateRelationshipResponse is either a CreateRelationshipSuccessResponse or a CreateRelationshipFailureResponse.'),
  };

  Map<String, dynamic> toJson();
}

@JsonSerializable(includeIfNull: false)
class CanCreateRelationshipSuccessResponse extends CanCreateRelationshipResponse {
  CanCreateRelationshipSuccessResponse() : super(isSuccess: true);

  factory CanCreateRelationshipSuccessResponse.fromJson(Map<String, dynamic> json) => _$CanCreateRelationshipSuccessResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CanCreateRelationshipSuccessResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CanCreateRelationshipFailureResponse extends CanCreateRelationshipResponse {
  final String code;
  final String message;

  CanCreateRelationshipFailureResponse({required this.code, required this.message}) : super(isSuccess: false);

  factory CanCreateRelationshipFailureResponse.fromJson(Map<String, dynamic> json) => _$CanCreateRelationshipFailureResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CanCreateRelationshipFailureResponseToJson(this);
}
