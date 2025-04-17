// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field_accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormFieldAcceptResponseType _$FormFieldAcceptResponseTypeFromJson(Map<String, dynamic> json) => FormFieldAcceptResponseType();

Map<String, dynamic> _$FormFieldAcceptResponseTypeToJson(FormFieldAcceptResponseType instance) => <String, dynamic>{};

FormFieldStringResponse _$FormFieldStringResponseFromJson(Map<String, dynamic> json) => FormFieldStringResponse(value: json['value'] as String);

Map<String, dynamic> _$FormFieldStringResponseToJson(FormFieldStringResponse instance) => <String, dynamic>{'value': instance.value};

FormFieldNumResponse _$FormFieldNumResponseFromJson(Map<String, dynamic> json) => FormFieldNumResponse(value: json['value'] as num);

Map<String, dynamic> _$FormFieldNumResponseToJson(FormFieldNumResponse instance) => <String, dynamic>{'value': instance.value};

FormFieldBoolResponse _$FormFieldBoolResponseFromJson(Map<String, dynamic> json) => FormFieldBoolResponse(value: json['value'] as bool);

Map<String, dynamic> _$FormFieldBoolResponseToJson(FormFieldBoolResponse instance) => <String, dynamic>{'value': instance.value};

FormFieldStringListResponse _$FormFieldStringListResponseFromJson(Map<String, dynamic> json) =>
    FormFieldStringListResponse(value: (json['value'] as List<dynamic>).map((e) => e as String).toList());

Map<String, dynamic> _$FormFieldStringListResponseToJson(FormFieldStringListResponse instance) => <String, dynamic>{'value': instance.value};

FormFieldAcceptResponseItem _$FormFieldAcceptResponseItemFromJson(Map<String, dynamic> json) =>
    FormFieldAcceptResponseItem(response: FormFieldAcceptResponseType.fromJson(json['response'] as Map<String, dynamic>));

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
