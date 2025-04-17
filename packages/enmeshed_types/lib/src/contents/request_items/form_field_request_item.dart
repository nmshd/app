import 'package:json_annotation/json_annotation.dart';

import 'request_item_derivation.dart';
import 'settings/form_field_settings_derivation.dart';

part 'form_field_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class FormFieldRequestItem extends RequestItemDerivation {
  final FormFieldSettingsDerivation settings;

  const FormFieldRequestItem({
    required super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.settings,
  }) : super(atType: 'FormFieldRequestItem');

  factory FormFieldRequestItem.fromJson(Map json) => _$FormFieldRequestItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$FormFieldRequestItemToJson(this);

  @override
  List<Object?> get props => [...super.props];
}
