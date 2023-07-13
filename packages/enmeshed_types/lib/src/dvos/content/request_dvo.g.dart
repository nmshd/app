// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestDVO _$RequestDVOFromJson(Map<String, dynamic> json) => RequestDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      expiresAt: json['expiresAt'] as String?,
      items: (json['items'] as List<dynamic>).map((e) => RequestItemDVO.fromJson(e as Map<String, dynamic>)).toList(),
      response: json['response'] == null ? null : ResponseDVO.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestDVOToJson(RequestDVO instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  val['type'] = instance.type;
  writeNotNull('date', instance.date);
  writeNotNull('error', instance.error?.toJson());
  writeNotNull('warning', instance.warning?.toJson());
  writeNotNull('expiresAt', instance.expiresAt);
  val['items'] = instance.items.map((e) => e.toJson()).toList();
  writeNotNull('response', instance.response?.toJson());
  return val;
}
