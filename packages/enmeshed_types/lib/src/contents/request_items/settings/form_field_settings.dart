import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'form_field_settings_derivation.dart';

abstract class FormFieldSettings extends Equatable {
  @JsonKey(name: '@type', includeToJson: true)
  final String atType;

  const FormFieldSettings({required this.atType});

  factory FormFieldSettings.fromJson(Map json) {
    final type = json['@type'];
    if (type == null) throw Exception('missing @type on FormFieldSettings');

    if (type.endsWith('FormFieldSettings')) return FormFieldSettingsDerivation.fromJson(json);

    throw Exception('Unknown type: $type');
  }

  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props => [];
}
