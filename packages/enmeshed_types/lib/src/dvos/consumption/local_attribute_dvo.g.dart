// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_attribute_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalAttributeDVO _$LocalAttributeDVOFromJson(Map<String, dynamic> json) =>
    LocalAttributeDVO(
      id: json['id'] as String,
      type: json['type'] as String,
    )
      ..name = json['name'] as String?
      ..description = json['description'] as String?
      ..image = json['image'] as String?
      ..date = json['date'] as String?
      ..error = json['error'] == null
          ? null
          : DVOError.fromJson(json['error'] as Map<String, dynamic>)
      ..warning = json['warning'] == null
          ? null
          : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>);

Map<String, dynamic> _$LocalAttributeDVOToJson(LocalAttributeDVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'type': instance.type,
      'date': instance.date,
      'error': instance.error,
      'warning': instance.warning,
    };
