import 'package:json_annotation/json_annotation.dart';

import '../abstract_attribute.dart';
import 'request_item_derivation.dart';

part 'share_attribute_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class ShareAttributeRequestItem extends RequestItemDerivation {
  final AbstractAttribute attribute;
  final String sourceAttributeId;
  final String? thirdPartyAddress;

  const ShareAttributeRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.attribute,
    required this.sourceAttributeId,
    this.thirdPartyAddress,
  }) : super(atType: 'ShareAttributeRequestItem');

  factory ShareAttributeRequestItem.fromJson(Map json) => _$ShareAttributeRequestItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$ShareAttributeRequestItemToJson(this);

  @override
  List<Object?> get props => [super.props, attribute, sourceAttributeId, thirdPartyAddress];
}
