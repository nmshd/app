part of 'form_field_settings.dart';

@JsonSerializable(includeIfNull: false)
class SelectionFormFieldSettings extends FormFieldSettings {
  final List<String> options;
  final bool? allowMultipleSelection;

  const SelectionFormFieldSettings({required this.options, this.allowMultipleSelection}) : super(atType: 'SelectionFormFieldSettings');

  factory SelectionFormFieldSettings.fromJson(Map json) => _$SelectionFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$SelectionFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [options, allowMultipleSelection];
}
