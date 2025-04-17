import 'package:json_annotation/json_annotation.dart';

import 'form_field_settings_derivation.dart';

part 'date_form_field_settings.g.dart';

@JsonSerializable(includeIfNull: false)
class DateFormFieldSettings extends FormFieldSettingsDerivation {
  const DateFormFieldSettings() : super(atType: 'DateFormFieldSettings');

  factory DateFormFieldSettings.fromJson(Map json) => _$DateFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$DateFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props];
}
