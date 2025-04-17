import 'package:json_annotation/json_annotation.dart';

import 'request_item_derivation.dart';
import 'settings/form_field_settings.dart';

part 'form_field_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class FormFieldRequestItem extends RequestItemDerivation {
  @override
  // ignore: overridden_fields
  final String title;

  final FormFieldSettings settings;

  const FormFieldRequestItem({
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.title,
    required this.settings,
  }) : super(atType: 'FormFieldRequestItem');

  factory FormFieldRequestItem.fromJson(Map json) => _$FormFieldRequestItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$FormFieldRequestItemToJson(this);

  @override
  List<Object?> get props => [...super.props, settings];
}
