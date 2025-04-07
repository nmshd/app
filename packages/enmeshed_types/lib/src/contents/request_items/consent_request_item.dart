import 'package:json_annotation/json_annotation.dart';

import 'request_item_derivation.dart';

part 'consent_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class ConsentRequestItem extends RequestItemDerivation {
  final String consent;
  final String? link;

  const ConsentRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.consent,
    this.link,
  });

  factory ConsentRequestItem.fromJson(Map json) => _$ConsentRequestItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => {..._$ConsentRequestItemToJson(this), '@type': 'ConsentRequestItem'};

  @override
  List<Object?> get props => [super.props, consent, link];
}
