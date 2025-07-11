import 'package:json_annotation/json_annotation.dart';

import 'request_item_derivation.dart';

part 'consent_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class ConsentRequestItem extends RequestItemDerivation {
  final String consent;
  final String? link;
  final String? linkDisplayText;

  const ConsentRequestItem({
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.consent,
    this.link,
    this.linkDisplayText,
  }) : super(atType: 'ConsentRequestItem');

  factory ConsentRequestItem.fromJson(Map json) => _$ConsentRequestItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$ConsentRequestItemToJson(this);

  @override
  List<Object?> get props => [...super.props, consent, link, linkDisplayText];
}
