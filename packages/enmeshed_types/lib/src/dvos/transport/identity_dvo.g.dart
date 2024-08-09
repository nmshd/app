// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityDVO _$IdentityDVOFromJson(Map<String, dynamic> json) => IdentityDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      publicKey: json['publicKey'] as String?,
      initials: json['initials'] as String,
      isSelf: json['isSelf'] as bool,
      hasRelationship: json['hasRelationship'] as bool,
      relationship: json['relationship'] == null ? null : RelationshipDVO.fromJson(json['relationship'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IdentityDVOToJson(IdentityDVO instance) {
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
  writeNotNull('publicKey', instance.publicKey);
  val['initials'] = instance.initials;
  val['isSelf'] = instance.isSelf;
  val['hasRelationship'] = instance.hasRelationship;
  writeNotNull('relationship', instance.relationship?.toJson());
  return val;
}
