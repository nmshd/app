// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptResponseItem _$AcceptResponseItemFromJson(Map<String, dynamic> json) => AcceptResponseItem(atType: json['@type'] as String);

Map<String, dynamic> _$AcceptResponseItemToJson(AcceptResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};
