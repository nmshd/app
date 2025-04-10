import 'package:json_annotation/json_annotation.dart';

import '../attribute_query/attribute_query.dart';
import 'request_item_derivation.dart';

part 'read_attribute_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class ReadAttributeRequestItem extends RequestItemDerivation {
  final AttributeQuery query;

  const ReadAttributeRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.query,
  }) : super(atType: 'ReadAttributeRequestItem');

  factory ReadAttributeRequestItem.fromJson(Map json) => _$ReadAttributeRequestItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$ReadAttributeRequestItemToJson(this);

  @override
  List<Object?> get props => [...super.props, query];
}
