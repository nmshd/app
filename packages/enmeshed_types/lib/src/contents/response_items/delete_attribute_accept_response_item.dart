import 'package:json_annotation/json_annotation.dart';

import 'accept_response_item.dart';

part 'delete_attribute_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class DeleteAttributeAcceptResponseItem extends AcceptResponseItem {
  final String deletionDate;

  const DeleteAttributeAcceptResponseItem({required this.deletionDate});

  factory DeleteAttributeAcceptResponseItem.fromJson(Map json) => _$DeleteAttributeAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll(_$DeleteAttributeAcceptResponseItemToJson(this));
    json['@type'] = 'DeleteAttributeAcceptResponseItem';
    return json;
  }

  @override
  List<Object?> get props => [super.props, deletionDate];
}
