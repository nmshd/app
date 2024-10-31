// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_attribute_share_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalAttributeShareInfo _$LocalAttributeShareInfoFromJson(Map<String, dynamic> json) => LocalAttributeShareInfo(
      requestReference: json['requestReference'] as String?,
      notificationReference: json['notificationReference'] as String?,
      peer: json['peer'] as String,
      sourceAttribute: json['sourceAttribute'] as String?,
      thirdPartyAddress: json['thirdPartyAddress'] as String?,
    );

Map<String, dynamic> _$LocalAttributeShareInfoToJson(LocalAttributeShareInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('requestReference', instance.requestReference);
  writeNotNull('notificationReference', instance.notificationReference);
  val['peer'] = instance.peer;
  writeNotNull('sourceAttribute', instance.sourceAttribute);
  writeNotNull('thirdPartyAddress', instance.thirdPartyAddress);
  return val;
}
