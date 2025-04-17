part of 'form_field_settings.dart';

@JsonSerializable(includeIfNull: false)
class BooleanFormFieldSettings extends FormFieldSettings {
  const BooleanFormFieldSettings() : super(atType: 'BooleanFormFieldSettings');

  factory BooleanFormFieldSettings.fromJson(Map json) => _$BooleanFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$BooleanFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [];
}
