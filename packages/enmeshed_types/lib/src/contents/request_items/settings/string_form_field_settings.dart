import 'package:json_annotation/json_annotation.dart';

import 'form_field_settings_derivation.dart';

part 'string_form_field_settings.g.dart';

@JsonSerializable(includeIfNull: false)
class StringFormFieldSettings extends FormFieldSettingsDerivation {
  final bool? allowNewlines;
  final int? min;
  final int? max;

  const StringFormFieldSettings({this.allowNewlines, this.min, this.max}) : super(atType: 'StringFormFieldSettings');

  factory StringFormFieldSettings.fromJson(Map json) => _$StringFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$StringFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props, allowNewlines, min, max];
}
