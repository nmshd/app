import 'package:json_annotation/json_annotation.dart';

import 'form_field_settings_derivation.dart';

part 'double_form_field_settings.g.dart';

@JsonSerializable(includeIfNull: false)
class DoubleFormFieldSettings extends FormFieldSettingsDerivation {
  final String? unit;
  final double? min;
  final double? max;

  const DoubleFormFieldSettings({this.unit, this.min, this.max}) : super(atType: 'DoubleFormFieldSettings');

  factory DoubleFormFieldSettings.fromJson(Map json) => _$DoubleFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$DoubleFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props, unit, min, max];
}
