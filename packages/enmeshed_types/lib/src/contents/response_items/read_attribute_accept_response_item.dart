import 'package:json_annotation/json_annotation.dart';

import '../abstract_attribute.dart';
import 'accept_response_item.dart';

part 'read_attribute_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class ReadAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;
  final AbstractAttribute attribute;
  final String? thirdPartyAddress;

  const ReadAttributeAcceptResponseItem({required this.attributeId, required this.attribute, this.thirdPartyAddress})
    : super(atType: 'ReadAttributeAcceptResponseItem');

  factory ReadAttributeAcceptResponseItem.fromJson(Map json) => _$ReadAttributeAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$ReadAttributeAcceptResponseItemToJson(this);

  @override
  List<Object?> get props => [...super.props, attributeId, attribute, thirdPartyAddress];
}
