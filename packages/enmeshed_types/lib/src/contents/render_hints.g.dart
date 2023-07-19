// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'render_hints.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RenderHints _$RenderHintsFromJson(Map<String, dynamic> json) => RenderHints(
      technicalType: $enumDecode(_$RenderHintsTechnicalTypeEnumMap, json['technicalType']),
      editType: $enumDecode(_$RenderHintsEditTypeEnumMap, json['editType']),
      dataType: $enumDecodeNullable(_$RenderHintsDataTypeEnumMap, json['dataType']),
      propertyHints: (json['propertyHints'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, RenderHints.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$RenderHintsToJson(RenderHints instance) {
  final val = <String, dynamic>{
    'technicalType': _$RenderHintsTechnicalTypeEnumMap[instance.technicalType]!,
    'editType': _$RenderHintsEditTypeEnumMap[instance.editType]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dataType', _$RenderHintsDataTypeEnumMap[instance.dataType]);
  writeNotNull('propertyHints', instance.propertyHints?.map((k, e) => MapEntry(k, e.toJson())));
  return val;
}

const _$RenderHintsTechnicalTypeEnumMap = {
  RenderHintsTechnicalType.Boolean: 'Boolean',
  RenderHintsTechnicalType.Float: 'Float',
  RenderHintsTechnicalType.Integer: 'Integer',
  RenderHintsTechnicalType.Object: 'Object',
  RenderHintsTechnicalType.String: 'String',
  RenderHintsTechnicalType.Unknown: 'Unknown',
};

const _$RenderHintsEditTypeEnumMap = {
  RenderHintsEditType.InputLike: 'InputLike',
  RenderHintsEditType.ButtonLike: 'ButtonLike',
  RenderHintsEditType.RadioButtonLike: 'RadioButtonLike',
  RenderHintsEditType.SelectLike: 'SelectLike',
  RenderHintsEditType.SliderLike: 'SliderLike',
  RenderHintsEditType.Complex: 'Complex',
  RenderHintsEditType.Secret: 'Secret',
  RenderHintsEditType.TextArea: 'TextArea',
  RenderHintsEditType.Upload: 'Upload',
};

const _$RenderHintsDataTypeEnumMap = {
  RenderHintsDataType.Country: 'Country',
  RenderHintsDataType.DataURL: 'DataURL',
  RenderHintsDataType.EMailAddress: 'EMailAddress',
  RenderHintsDataType.HEXColor: 'HEXColor',
  RenderHintsDataType.Language: 'Language',
  RenderHintsDataType.PhoneNumber: 'PhoneNumber',
  RenderHintsDataType.URL: 'URL',
  RenderHintsDataType.FileReference: 'FileReference',
  RenderHintsDataType.Date: 'Date',
  RenderHintsDataType.DatePeriod: 'DatePeriod',
  RenderHintsDataType.DateTime: 'DateTime',
  RenderHintsDataType.DateTimePeriod: 'DateTimePeriod',
  RenderHintsDataType.Time: 'Time',
  RenderHintsDataType.TimePeriod: 'TimePeriod',
  RenderHintsDataType.Day: 'Day',
  RenderHintsDataType.Month: 'Month',
  RenderHintsDataType.Year: 'Year',
};
