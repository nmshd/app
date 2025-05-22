part of 'form_field_settings.dart';

@JsonSerializable(includeIfNull: false)
class DoubleFormFieldSettings extends FormFieldSettings {
  final String? unit;
  final double? min;
  final double? max;

  const DoubleFormFieldSettings({this.unit, this.min, this.max}) : super(atType: 'DoubleFormFieldSettings');

  factory DoubleFormFieldSettings.fromJson(Map json) => _$DoubleFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$DoubleFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [unit, min, max];
}
