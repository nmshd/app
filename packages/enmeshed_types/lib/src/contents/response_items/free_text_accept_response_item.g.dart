// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_text_accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreeTextAcceptResponseItem _$FreeTextAcceptResponseItemFromJson(Map<String, dynamic> json) =>
    FreeTextAcceptResponseItem(freeText: json['freeText'] as String);

Map<String, dynamic> _$FreeTextAcceptResponseItemToJson(FreeTextAcceptResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
  'freeText': instance.freeText,
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};
