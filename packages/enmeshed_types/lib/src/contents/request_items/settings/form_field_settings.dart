import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'form_field_settings.g.dart';

@JsonSerializable(includeIfNull: false)
sealed class FormFieldSettings extends Equatable {
  @JsonKey(name: '@type', includeToJson: true)
  final String atType;

  const FormFieldSettings({required this.atType});

  factory FormFieldSettings.fromJson(Map json) {
    final type = json['@type'];
    if (type == null) throw Exception('missing @type on FormFieldSettings');

    return switch (type) {
      'StringFormFieldSettings' => StringFormFieldSettings.fromJson(json),
      'IntegerFormFieldSettings' => IntegerFormFieldSettings.fromJson(json),
      'DoubleFormFieldSettings' => DoubleFormFieldSettings.fromJson(json),
      'BooleanFormFieldSettings' => BooleanFormFieldSettings.fromJson(json),
      'DateFormFieldSettings' => DateFormFieldSettings.fromJson(json),
      'RatingFormFieldSettings' => RatingFormFieldSettings.fromJson(json),
      'SelectionFormFieldSettings' => SelectionFormFieldSettings.fromJson(json),
      _ => throw Exception('Unknown type: $type'),
    };
  }

  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props => [];
}

@JsonSerializable(includeIfNull: false)
class StringFormFieldSettings extends FormFieldSettings {
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
  List<Object?> get props => [...super.props, unit, min, max];
}

@JsonSerializable(includeIfNull: false)
class DoubleFormFieldSettings extends FormFieldSettings {
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

@JsonSerializable(includeIfNull: false)
class BooleanFormFieldSettings extends FormFieldSettings {
  const BooleanFormFieldSettings() : super(atType: 'BooleanFormFieldSettings');

  factory BooleanFormFieldSettings.fromJson(Map json) => _$BooleanFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$BooleanFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props];
}

@JsonSerializable(includeIfNull: false)
class DateFormFieldSettings extends FormFieldSettings {
  const DateFormFieldSettings() : super(atType: 'DateFormFieldSettings');

  factory DateFormFieldSettings.fromJson(Map json) => _$DateFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$DateFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props];
}

@JsonSerializable(includeIfNull: false)
class RatingFormFieldSettings extends FormFieldSettings {
  final int maxRating;

  const RatingFormFieldSettings({required this.maxRating}) : super(atType: 'RatingFormFieldSettings');

  factory RatingFormFieldSettings.fromJson(Map json) => _$RatingFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$RatingFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props, maxRating];
}

@JsonSerializable(includeIfNull: false)
class SelectionFormFieldSettings extends FormFieldSettings {
  final List<String> options;
  final bool? allowMultipleSelection;

  const SelectionFormFieldSettings({required this.options, this.allowMultipleSelection}) : super(atType: 'SelectionFormFieldSettings');

  factory SelectionFormFieldSettings.fromJson(Map json) => _$SelectionFormFieldSettingsFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$SelectionFormFieldSettingsToJson(this);

  @override
  List<Object?> get props => [...super.props, options, allowMultipleSelection];
}
