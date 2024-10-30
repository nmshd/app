// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'can_create_relationship_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CanCreateRelationshipSuccessResponse _$CanCreateRelationshipSuccessResponseFromJson(Map<String, dynamic> json) =>
    CanCreateRelationshipSuccessResponse(
      isSuccess: json['isSuccess'] as bool? ?? true,
    );

Map<String, dynamic> _$CanCreateRelationshipSuccessResponseToJson(CanCreateRelationshipSuccessResponse instance) => <String, dynamic>{
      'isSuccess': instance.isSuccess,
    };

CanCreateRelationshipFailureResponse _$CanCreateRelationshipFailureResponseFromJson(Map<String, dynamic> json) =>
    CanCreateRelationshipFailureResponse(
      isSuccess: json['isSuccess'] as bool? ?? false,
      code: json['code'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$CanCreateRelationshipFailureResponseToJson(CanCreateRelationshipFailureResponse instance) => <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
    };
