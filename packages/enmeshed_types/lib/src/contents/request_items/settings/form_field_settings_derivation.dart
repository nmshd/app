import 'boolean_form_field_settings.dart';
import 'date_form_field_settings.dart';
import 'double_form_field_settings.dart';
import 'form_field_settings.dart';
import 'integer_form_field_settings.dart';
import 'rating_form_field_settings.dart';
import 'selection_form_field_settings.dart';
import 'string_form_field_settings.dart';

abstract class FormFieldSettingsDerivation extends FormFieldSettings {
  const FormFieldSettingsDerivation({required super.atType});

  factory FormFieldSettingsDerivation.fromJson(Map json) {
    final type = json['@type'];

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

  @override
  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [...super.props];
}
