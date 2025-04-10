import 'package:json_annotation/json_annotation.dart';

import '../abstract_attribute.dart';
import '../attribute_query/attribute_query.dart';
import 'request_item_derivation.dart';

part 'propose_attribute_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class ProposeAttributeRequestItem extends RequestItemDerivation {
  final AttributeQuery query;
  final AbstractAttribute attribute;

  const ProposeAttributeRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.query,
    required this.attribute,
  }) : super(atType: 'ProposeAttributeRequestItem');

  factory ProposeAttributeRequestItem.fromJson(Map json) => _$ProposeAttributeRequestItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$ProposeAttributeRequestItemToJson(this);

  @override
  List<Object?> get props => [...super.props, query, attribute];
}
