// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_attribute_listener_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterAttributeListenerRequestItem _$RegisterAttributeListenerRequestItemFromJson(Map<String, dynamic> json) =>
    RegisterAttributeListenerRequestItem(
      title: json['title'] as String?,
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      mustBeAccepted: json['mustBeAccepted'] as bool,
      requireManualDecision: json['requireManualDecision'] as bool?,
      query: AttributeQuery.fromJson(json['query'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterAttributeListenerRequestItemToJson(RegisterAttributeListenerRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'title': ?instance.title,
  'description': ?instance.description,
  'metadata': ?instance.metadata,
  'mustBeAccepted': instance.mustBeAccepted,
  'requireManualDecision': ?instance.requireManualDecision,
  'query': instance.query.toJson(),
};
