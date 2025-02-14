// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'can_create_relationship_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CanCreateRelationshipSuccessResponse _$CanCreateRelationshipSuccessResponseFromJson(Map<String, dynamic> json) =>
    CanCreateRelationshipSuccessResponse();

Map<String, dynamic> _$CanCreateRelationshipSuccessResponseToJson(CanCreateRelationshipSuccessResponse instance) => <String, dynamic>{};

CanCreateRelationshipFailureResponse _$CanCreateRelationshipFailureResponseFromJson(Map<String, dynamic> json) =>
    CanCreateRelationshipFailureResponse(code: json['code'] as String, message: json['message'] as String);

Map<String, dynamic> _$CanCreateRelationshipFailureResponseToJson(CanCreateRelationshipFailureResponse instance) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
};
