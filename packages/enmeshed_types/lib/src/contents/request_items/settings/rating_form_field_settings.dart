import 'package:json_annotation/json_annotation.dart';

import 'form_field_settings_derivation.dart';

part 'rating_form_field_settings.g.dart';

@JsonSerializable(includeIfNull: false)
class RatingFormFieldSettings extends FormFieldSettingsDerivation {
  final int maxRating;

  const RatingFormFieldSettings({required this.maxRating}) : super(atType: 'RatingFormFieldSettings');

  factory RatingFormFieldSettings.fromJson(Map json) => _$RatingFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$RatingFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props, maxRating];
}
