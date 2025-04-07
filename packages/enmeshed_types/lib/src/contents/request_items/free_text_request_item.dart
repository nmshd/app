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
  });

  factory FreeTextRequestItem.fromJson(Map json) => _$FreeTextRequestItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => {..._$FreeTextRequestItemToJson(this), '@type': 'FreeTextRequestItem'};

  @override
  List<Object?> get props => [super.props];
}
