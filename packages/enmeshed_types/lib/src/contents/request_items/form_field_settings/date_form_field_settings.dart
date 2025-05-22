part of 'form_field_settings.dart';

@JsonSerializable(includeIfNull: false)
class DateFormFieldSettings extends FormFieldSettings {
  const DateFormFieldSettings() : super(atType: 'DateFormFieldSettings');

  factory DateFormFieldSettings.fromJson(Map json) => _$DateFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$DateFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [];
}
