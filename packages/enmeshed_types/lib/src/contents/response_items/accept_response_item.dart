import 'package:json_annotation/json_annotation.dart';

import 'attribute_already_shared_accept_response_item.dart';
import 'attribute_succession_accept_response_item.dart';
import 'create_attribute_accept_response_item.dart';
import 'delete_attribute_accept_response_item.dart';
import 'form_field_accept_response_item.dart';
import 'propose_attribute_accept_response_item.dart';
import 'read_attribute_accept_response_item.dart';
import 'register_attribute_listener_accept_response_item.dart';
import 'response_item.dart';
import 'response_item_derivation.dart';
import 'share_attribute_accept_response_item.dart';
import 'transfer_file_ownership_accept_response_item.dart';

export 'response_item_result.dart';

part 'accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class AcceptResponseItem extends ResponseItemDerivation {
  const AcceptResponseItem({required super.atType}) : super(result: ResponseItemResult.Accepted);

  factory AcceptResponseItem.fromJson(Map json) {
    final type = json['@type'];

    if (type == 'AcceptResponseItem') return _$AcceptResponseItemFromJson(Map<String, dynamic>.from(json));

    return switch (type) {
      'AttributeAlreadySharedAcceptResponseItem' => AttributeAlreadySharedAcceptResponseItem.fromJson(json),
      'AttributeSuccessionAcceptResponseItem' => AttributeSuccessionAcceptResponseItem.fromJson(json),
      'CreateAttributeAcceptResponseItem' => CreateAttributeAcceptResponseItem.fromJson(json),
      'DeleteAttributeAcceptResponseItem' => DeleteAttributeAcceptResponseItem.fromJson(json),
      'FormFieldAcceptResponseItem' => FormFieldAcceptResponseItem.fromJson(json),
      'ProposeAttributeAcceptResponseItem' => ProposeAttributeAcceptResponseItem.fromJson(json),
      'ReadAttributeAcceptResponseItem' => ReadAttributeAcceptResponseItem.fromJson(json),
      'RegisterAttributeListenerAcceptResponseItem' => RegisterAttributeListenerAcceptResponseItem.fromJson(json),
      'ShareAttributeAcceptResponseItem' => ShareAttributeAcceptResponseItem.fromJson(json),
      'TransferFileOwnershipAcceptResponseItem' => TransferFileOwnershipAcceptResponseItem.fromJson(json),
      _ => throw Exception('Unknown type: $type'),
    };
  }

  @override
  Map<String, dynamic> toJson() => _$AcceptResponseItemToJson(this);
}
