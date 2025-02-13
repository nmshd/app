// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_hints_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHintsResponse _$GetHintsResponseFromJson(Map<String, dynamic> json) => GetHintsResponse(
  valueHints: ValueHints.fromJson(json['valueHints'] as Map<String, dynamic>),
  renderHints: RenderHints.fromJson(json['renderHints'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GetHintsResponseToJson(GetHintsResponse instance) => <String, dynamic>{
  'valueHints': instance.valueHints.toJson(),
  'renderHints': instance.renderHints.toJson(),
};
