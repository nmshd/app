// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_dvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDVO _$ResponseDVOFromJson(Map<String, dynamic> json) => ResponseDVO(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String,
      date: json['date'] as String?,
      error: json['error'] == null ? null : DVOError.fromJson(json['error'] as Map<String, dynamic>),
      warning: json['warning'] == null ? null : DVOWarning.fromJson(json['warning'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>).map((e) => ResponseItemDVO.fromJson(e as Map<String, dynamic>)).toList(),
      result: $enumDecode(_$ResponseResultEnumMap, json['result']),
    );

Map<String, dynamic> _$ResponseDVOToJson(ResponseDVO instance) {
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
  val['items'] = instance.items.map((e) => e.toJson()).toList();
  val['result'] = _$ResponseResultEnumMap[instance.result]!;
  return val;
}

const _$ResponseResultEnumMap = {
  ResponseResult.Accepted: 'Accepted',
  ResponseResult.Rejected: 'Rejected',
};
