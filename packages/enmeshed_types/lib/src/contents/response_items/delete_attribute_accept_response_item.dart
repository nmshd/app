import 'package:json_annotation/json_annotation.dart';

import 'accept_response_item.dart';

part 'delete_attribute_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class DeleteAttributeAcceptResponseItem extends AcceptResponseItem {
  final String deletionDate;

  const DeleteAttributeAcceptResponseItem({required this.deletionDate}) : super(atType: 'DeleteAttributeAcceptResponseItem');

  factory DeleteAttributeAcceptResponseItem.fromJson(Map json) => _$DeleteAttributeAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$DeleteAttributeAcceptResponseItemToJson(this);

  @override
  List<Object?> get props => [...super.props, deletionDate];
}
