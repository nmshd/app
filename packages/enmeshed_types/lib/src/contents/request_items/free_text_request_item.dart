import 'package:json_annotation/json_annotation.dart';

import 'request_item_derivation.dart';

part 'free_text_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class FreeTextRequestItem extends RequestItemDerivation {
  final String freeText;

  const FreeTextRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.freeText,
  }) : super(atType: 'FreeTextRequestItem');

  factory FreeTextRequestItem.fromJson(Map json) => _$FreeTextRequestItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$FreeTextRequestItemToJson(this);

  @override
  List<Object?> get props => [super.props];
}
