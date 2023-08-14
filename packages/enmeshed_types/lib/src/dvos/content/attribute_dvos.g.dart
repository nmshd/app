// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_dvos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DraftIdentityAttributeDVO _$DraftIdentityAttributeDVOFromJson(Map<String, dynamic> json) => DraftIdentityAttributeDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      content: AbstractAttribute.fromJson(json['content'] as Map<String, dynamic>),
      owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
      renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
      valueType: json['valueType'] as String,
      isOwn: json['isOwn'] as bool,
      isDraft: json['isDraft'] as bool,
      succeeds: json['succeeds'] as String?,
      succeededBy: json['succeededBy'] as String?,
      value: AttributeValue.fromJson(json['value'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DraftIdentityAttributeDVOToJson(DraftIdentityAttributeDVO instance) {
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
  val['content'] = instance.content.toJson();
  val['owner'] = instance.owner.toJson();
  val['renderHints'] = instance.renderHints.toJson();
  val['valueHints'] = instance.valueHints.toJson();
  val['valueType'] = instance.valueType;
  val['isOwn'] = instance.isOwn;
  val['isDraft'] = instance.isDraft;
  writeNotNull('succeeds', instance.succeeds);
  writeNotNull('succeededBy', instance.succeededBy);
  val['value'] = instance.value.toJson();
  val['tags'] = instance.tags;
  return val;
}

DraftRelationshipAttributeDVO _$DraftRelationshipAttributeDVOFromJson(Map<String, dynamic> json) => DraftRelationshipAttributeDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      content: AbstractAttribute.fromJson(json['content'] as Map<String, dynamic>),
      owner: IdentityDVO.fromJson(json['owner'] as Map<String, dynamic>),
      renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
      valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
      valueType: json['valueType'] as String,
      isOwn: json['isOwn'] as bool,
      isDraft: json['isDraft'] as bool,
      succeeds: json['succeeds'] as String?,
      succeededBy: json['succeededBy'] as String?,
      value: AttributeValue.fromJson(json['value'] as Map<String, dynamic>),
      key: json['key'] as String,
      isTechnical: json['isTechnical'] as bool,
      confidentiality: json['confidentiality'] as String,
    );

Map<String, dynamic> _$DraftRelationshipAttributeDVOToJson(DraftRelationshipAttributeDVO instance) {
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
  val['content'] = instance.content.toJson();
  val['owner'] = instance.owner.toJson();
  val['renderHints'] = instance.renderHints.toJson();
  val['valueHints'] = instance.valueHints.toJson();
  val['valueType'] = instance.valueType;
  val['isOwn'] = instance.isOwn;
  val['isDraft'] = instance.isDraft;
  writeNotNull('succeeds', instance.succeeds);
  writeNotNull('succeededBy', instance.succeededBy);
  val['value'] = instance.value.toJson();
  val['key'] = instance.key;
  val['isTechnical'] = instance.isTechnical;
  val['confidentiality'] = instance.confidentiality;
  return val;
}
