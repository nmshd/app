// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectResponseItem _$RejectResponseItemFromJson(Map<String, dynamic> json) =>
    RejectResponseItem(code: json['code'] as String?, message: json['message'] as String?);

Map<String, dynamic> _$RejectResponseItemToJson(RejectResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.code case final value?) 'code': value,
  if (instance.message case final value?) 'message': value,
};
