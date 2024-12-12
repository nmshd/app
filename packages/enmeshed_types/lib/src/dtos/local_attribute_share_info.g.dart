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

Map<String, dynamic> _$LocalAttributeShareInfoToJson(LocalAttributeShareInfo instance) => <String, dynamic>{
      if (instance.requestReference case final value?) 'requestReference': value,
      if (instance.notificationReference case final value?) 'notificationReference': value,
      'peer': instance.peer,
      if (instance.sourceAttribute case final value?) 'sourceAttribute': value,
      if (instance.thirdPartyAddress case final value?) 'thirdPartyAddress': value,
    };
