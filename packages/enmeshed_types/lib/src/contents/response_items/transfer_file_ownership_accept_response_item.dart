import 'package:json_annotation/json_annotation.dart';

import '../abstract_attribute.dart';
import 'accept_response_item.dart';

part 'transfer_file_ownership_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class TransferFileOwnershipAcceptResponseItem extends AcceptResponseItem {
  final String attributeId;
  final AbstractAttribute attribute;

  const TransferFileOwnershipAcceptResponseItem({required this.attributeId, required this.attribute});

  factory TransferFileOwnershipAcceptResponseItem.fromJson(Map json) =>
      _$TransferFileOwnershipAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll(_$TransferFileOwnershipAcceptResponseItemToJson(this));
    json['@type'] = 'TransferFileOwnershipAcceptResponseItem';
    return json;
  }

  @override
  List<Object?> get props => [super.props, attributeId, attribute];
}
