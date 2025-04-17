import 'package:json_annotation/json_annotation.dart';

import 'form_field_settings_derivation.dart';

part 'integer_form_field_settings.g.dart';

@JsonSerializable(includeIfNull: false)
class IntegerFormFieldSettings extends FormFieldSettingsDerivation {
  final String? unit;
  final int? min;
  final int? max;

  const IntegerFormFieldSettings({this.unit, this.min, this.max}) : super(atType: 'IntegerFormFieldSettings');

  factory IntegerFormFieldSettings.fromJson(Map json) => _$IntegerFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$IntegerFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props, unit, min, max];
}
