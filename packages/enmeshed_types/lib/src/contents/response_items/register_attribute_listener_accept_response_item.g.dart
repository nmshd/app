// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_attribute_listener_accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterAttributeListenerAcceptResponseItem _$RegisterAttributeListenerAcceptResponseItemFromJson(Map<String, dynamic> json) =>
    RegisterAttributeListenerAcceptResponseItem(listenerId: json['listenerId'] as String);

Map<String, dynamic> _$RegisterAttributeListenerAcceptResponseItemToJson(RegisterAttributeListenerAcceptResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
  'listenerId': instance.listenerId,
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};
