part of 'form_field_settings.dart';

@JsonSerializable(includeIfNull: false)
class StringFormFieldSettings extends FormFieldSettings {
  final bool? allowNewlines;
  final int? min;
  final int? max;

  const StringFormFieldSettings({this.allowNewlines, this.min, this.max}) : super(atType: 'StringFormFieldSettings');

  factory StringFormFieldSettings.fromJson(Map json) => _$StringFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$StringFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [allowNewlines, min, max];
}
