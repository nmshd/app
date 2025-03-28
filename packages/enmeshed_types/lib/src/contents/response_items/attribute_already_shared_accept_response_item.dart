import 'package:json_annotation/json_annotation.dart';

import 'accept_response_item.dart';

part 'attribute_already_shared_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class AttributeAlreadySharedAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;

  const AttributeAlreadySharedAcceptResponseItem({required this.attributeId});

  factory AttributeAlreadySharedAcceptResponseItem.fromJson(Map json) =>
      _$AttributeAlreadySharedAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll(_$AttributeAlreadySharedAcceptResponseItemToJson(this));
    json['@type'] = 'AttributeAlreadySharedAcceptResponseItem';
    return json;
  }

  @override
  List<Object?> get props => [super.props, attributeId];
}
