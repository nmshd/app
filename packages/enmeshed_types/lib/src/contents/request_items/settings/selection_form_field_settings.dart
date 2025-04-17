import 'package:json_annotation/json_annotation.dart';

import 'form_field_settings_derivation.dart';

part 'selection_form_field_settings.g.dart';

@JsonSerializable(includeIfNull: false)
class SelectionFormFieldSettings extends FormFieldSettingsDerivation {
  final List<String> options;
  final bool? allowMultipleSelection;

  const SelectionFormFieldSettings({required this.options, this.allowMultipleSelection}) : super(atType: 'SelectionFormFieldSettings');

  factory SelectionFormFieldSettings.fromJson(Map json) => _$SelectionFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$SelectionFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props, options, allowMultipleSelection];
}
