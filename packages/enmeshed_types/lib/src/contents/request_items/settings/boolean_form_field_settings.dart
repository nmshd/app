import 'package:json_annotation/json_annotation.dart';

import 'form_field_settings_derivation.dart';

part 'boolean_form_field_settings.g.dart';

@JsonSerializable(includeIfNull: false)
class BooleanFormFieldSettings extends FormFieldSettingsDerivation {
  const BooleanFormFieldSettings() : super(atType: 'BooleanFormFieldSettings');

  factory BooleanFormFieldSettings.fromJson(Map json) => _$BooleanFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$BooleanFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props];
}
