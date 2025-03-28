import 'package:json_annotation/json_annotation.dart';

import 'accept_response_item.dart';

part 'share_attribute_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class ShareAttributeAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;

  const ShareAttributeAcceptResponseItem({required this.attributeId});

  factory ShareAttributeAcceptResponseItem.fromJson(Map json) => _$ShareAttributeAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll(_$ShareAttributeAcceptResponseItemToJson(this));
    json['@type'] = 'ShareAttributeAcceptResponseItem';
    return json;
  }

  @override
  List<Object?> get props => [super.props, attributeId];
}
