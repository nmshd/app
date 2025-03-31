import 'package:json_annotation/json_annotation.dart';

import 'accept_response_item.dart';

part 'create_attribute_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class CreateAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;

  const CreateAttributeAcceptResponseItem({required this.attributeId});

  factory CreateAttributeAcceptResponseItem.fromJson(Map json) => _$CreateAttributeAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    ..._$CreateAttributeAcceptResponseItemToJson(this),
    '@type': 'CreateAttributeAcceptResponseItem',
  };

  @override
  List<Object?> get props => [super.props, attributeId];
}
