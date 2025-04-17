part of 'form_field_settings.dart';

@JsonSerializable(includeIfNull: false)
class RatingFormFieldSettings extends FormFieldSettings {
  final int maxRating;

  const RatingFormFieldSettings({required this.maxRating}) : super(atType: 'RatingFormFieldSettings');

  factory RatingFormFieldSettings.fromJson(Map json) => _$RatingFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$RatingFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [maxRating];
}
