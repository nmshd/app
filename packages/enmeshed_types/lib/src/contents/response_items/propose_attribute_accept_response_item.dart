import 'package:json_annotation/json_annotation.dart';

import '../abstract_attribute.dart';
import 'accept_response_item.dart';

part 'propose_attribute_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class ProposeAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;
  final AbstractAttribute attribute;

  const ProposeAttributeAcceptResponseItem({required this.attributeId, required this.attribute})
    : super(atType: 'ProposeAttributeAcceptResponseItem');

  factory ProposeAttributeAcceptResponseItem.fromJson(Map json) => _$ProposeAttributeAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$ProposeAttributeAcceptResponseItemToJson(this);

  @override
  List<Object?> get props => [...super.props, attributeId, attribute];
}
