// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationshipDVO _$RelationshipDVOFromJson(Map<String, dynamic> json) => RelationshipDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      status: json['status'] as String,
      direction: $enumDecode(_$RelationshipDirectionEnumMap, json['direction']),
      statusText: json['statusText'] as String,
      isPinned: json['isPinned'] as bool,
      theme: json['theme'] == null ? null : RelationshipTheme.fromJson(json['theme'] as Map<String, dynamic>),
      creationContent: RelationshipCreationContent.fromJson(json['creationContent'] as Map<String, dynamic>),
      auditLog: (json['auditLog'] as List<dynamic>).map((e) => RelationshipAuditLogEntryDTO.fromJson(e as Map<String, dynamic>)).toList(),
      changeCount: const IntegerConverter().fromJson(json['changeCount']),
      items: (json['items'] as List<dynamic>).map((e) => LocalAttributeDVO.fromJson(e as Map<String, dynamic>)).toList(),
      attributeMap: (json['attributeMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as List<dynamic>).map((e) => LocalAttributeDVO.fromJson(e as Map<String, dynamic>)).toList()),
      ),
      nameMap: Map<String, String>.from(json['nameMap'] as Map),
      templateId: json['templateId'] as String,
    );

Map<String, dynamic> _$RelationshipDVOToJson(RelationshipDVO instance) {
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
  val['status'] = instance.status;
  val['direction'] = _$RelationshipDirectionEnumMap[instance.direction]!;
  val['statusText'] = instance.statusText;
  val['isPinned'] = instance.isPinned;
  writeNotNull('theme', instance.theme?.toJson());
  val['creationContent'] = instance.creationContent.toJson();
  val['auditLog'] = instance.auditLog.map((e) => e.toJson()).toList();
  writeNotNull('changeCount', const IntegerConverter().toJson(instance.changeCount));
  val['items'] = instance.items.map((e) => e.toJson()).toList();
  val['attributeMap'] = instance.attributeMap.map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList()));
  val['nameMap'] = instance.nameMap;
  val['templateId'] = instance.templateId;
  return val;
}

const _$RelationshipDirectionEnumMap = {
  RelationshipDirection.Incoming: 'Incoming',
  RelationshipDirection.Outgoing: 'Outgoing',
};

RelationshipTheme _$RelationshipThemeFromJson(Map<String, dynamic> json) => RelationshipTheme(
      image: json['image'] as String?,
      headerImage: json['headerImage'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      foregroundColor: json['foregroundColor'] as String?,
    );

Map<String, dynamic> _$RelationshipThemeToJson(RelationshipTheme instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('image', instance.image);
  writeNotNull('headerImage', instance.headerImage);
  writeNotNull('backgroundColor', instance.backgroundColor);
  writeNotNull('foregroundColor', instance.foregroundColor);
  return val;
}
