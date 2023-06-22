import 'package:json_annotation/json_annotation.dart';

part 'render_hints.g.dart';

enum RenderHintsTechnicalType {
  Boolean,
  Float,
  Integer,
  Object,
  String,
  Unknown,
}

enum RenderHintsEditType {
  InputLike,
  ButtonLike,
  RadioButtonLike,
  SelectLike,
  SliderLike,
  Complex,
  Secret,
  TextArea,
  Upload,
}

enum RenderHintsDataType {
  Country,
  DataURL,
  EMailAddress,
  HEXColor,
  Language,
  PhoneNumber,
  URL,
  FileReference,
  Date,
  DatePeriod,
  DateTime,
  DateTimePeriod,
  Time,
  TimePeriod,
  Day,
  Month,
  Year,
}

@JsonSerializable(includeIfNull: false)
class RenderHints {
  final RenderHintsTechnicalType technicalType;
  final RenderHintsEditType editType;
  final RenderHintsDataType? dataType;
  final Map<String, RenderHints>? propertyHints;

  RenderHints({
    required this.technicalType,
    required this.editType,
    this.dataType,
    this.propertyHints,
  });

  factory RenderHints.fromJson(Map<String, dynamic> json) => _$RenderHintsFromJson(json);
  Map<String, dynamic> toJson() => _$RenderHintsToJson(this);
}
