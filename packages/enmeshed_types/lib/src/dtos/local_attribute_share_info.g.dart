// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_attribute_share_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalAttributeShareInfo _$LocalAttributeShareInfoFromJson(
  Map<String, dynamic> json,
) => LocalAttributeShareInfo(
  requestReference: json['requestReference'] as String?,
  notificationReference: json['notificationReference'] as String?,
  peer: json['peer'] as String,
  sourceAttribute: json['sourceAttribute'] as String?,
  thirdPartyAddress: json['thirdPartyAddress'] as String?,
);

Map<String, dynamic> _$LocalAttributeShareInfoToJson(
  LocalAttributeShareInfo instance,
) => <String, dynamic>{
  'requestReference': ?instance.requestReference,
  'notificationReference': ?instance.notificationReference,
  'peer': instance.peer,
  'sourceAttribute': ?instance.sourceAttribute,
  'thirdPartyAddress': ?instance.thirdPartyAddress,
};
