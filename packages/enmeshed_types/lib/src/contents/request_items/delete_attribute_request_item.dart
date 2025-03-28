import 'package:json_annotation/json_annotation.dart';

import 'request_item_derivation.dart';

part 'delete_attribute_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class DeleteAttributeRequestItem extends RequestItemDerivation {
  final String attributeId;

  const DeleteAttributeRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.attributeId,
  });

  factory DeleteAttributeRequestItem.fromJson(Map json) => _$DeleteAttributeRequestItemFromJson(Map<String, dynamic>.from(json));
  
  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll(_$DeleteAttributeRequestItemToJson(this));
    json['@type'] = 'DeleteAttributeRequestItem';
    return json;
  }

  // TODO: do we need this?
  @override
  String toString() => 'DeleteAttributeRequestItem(attributeId: $attributeId)';

  @override
  List<Object?> get props => [super.props, attributeId];
}
