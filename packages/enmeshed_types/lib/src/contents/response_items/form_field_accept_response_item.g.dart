// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field_accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormFieldAcceptResponseItem _$FormFieldAcceptResponseItemFromJson(Map<String, dynamic> json) =>
    FormFieldAcceptResponseItem(response: FormFieldAcceptResponseType.fromJson(json['response']));

Map<String, dynamic> _$FormFieldAcceptResponseItemToJson(FormFieldAcceptResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
  'response': instance.response.toJson(),
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};
