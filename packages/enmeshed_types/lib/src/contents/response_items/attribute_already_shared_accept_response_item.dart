import 'package:json_annotation/json_annotation.dart';

import 'accept_response_item.dart';

part 'attribute_already_shared_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class AttributeAlreadySharedAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;

  const AttributeAlreadySharedAcceptResponseItem({required this.attributeId}) : super(atType: 'AttributeAlreadySharedAcceptResponseItem');

  factory AttributeAlreadySharedAcceptResponseItem.fromJson(Map json) =>
      _$AttributeAlreadySharedAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$AttributeAlreadySharedAcceptResponseItemToJson(this);

  @override
  List<Object?> get props => [super.props, attributeId];
}
