import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'boolean_form_field_settings.dart';
part 'date_form_field_settings.dart';
part 'double_form_field_settings.dart';
part 'integer_form_field_settings.dart';
part 'rating_form_field_settings.dart';
part 'selection_form_field_settings.dart';
part 'string_form_field_settings.dart';
part 'form_field_settings.g.dart';

sealed class FormFieldSettings extends Equatable {
  @JsonKey(name: '@type', includeToJson: true)
  final String atType;

  const FormFieldSettings({required this.atType});

  factory FormFieldSettings.fromJson(Map json) {
    final type = json['@type'];
    if (type == null) throw Exception('missing @type on FormFieldSettings');

    return switch (type) {
      'BooleanFormFieldSettings' => BooleanFormFieldSettings.fromJson(json),
      'DateFormFieldSettings' => DateFormFieldSettings.fromJson(json),
      'DoubleFormFieldSettings' => DoubleFormFieldSettings.fromJson(json),
      'IntegerFormFieldSettings' => IntegerFormFieldSettings.fromJson(json),
      'RatingFormFieldSettings' => RatingFormFieldSettings.fromJson(json),
      'SelectionFormFieldSettings' => SelectionFormFieldSettings.fromJson(json),
      'StringFormFieldSettings' => StringFormFieldSettings.fromJson(json),
      _ => throw Exception('Unknown type: $type'),
    };
  }

  Map<String, dynamic> toJson();
}
