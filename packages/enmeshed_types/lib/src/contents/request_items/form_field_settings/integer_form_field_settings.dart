part of 'form_field_settings.dart';

@JsonSerializable(includeIfNull: false)
class IntegerFormFieldSettings extends FormFieldSettings {
  final String? unit;
  final int? min;
  final int? max;

  const IntegerFormFieldSettings({this.unit, this.min, this.max}) : super(atType: 'IntegerFormFieldSettings');

  factory IntegerFormFieldSettings.fromJson(Map json) => _$IntegerFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$IntegerFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [unit, min, max];
}
