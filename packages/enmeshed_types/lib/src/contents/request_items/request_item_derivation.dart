import 'authentication_request_item.dart';
import 'consent_request_item.dart';
import 'create_attribute_request_item.dart';
import 'delete_attribute_request_item.dart';
import 'free_text_request_item.dart';
import 'propose_attribute_request_item.dart';
import 'read_attribute_request_item.dart';
import 'register_attribute_listener_request_item.dart';
import 'request_item.dart';
import 'share_attribute_request_item.dart';
import 'transfer_file_ownership_request_item.dart';

abstract class RequestItemDerivation extends RequestItem {
  final bool mustBeAccepted;
  final bool? requireManualDecision;

  const RequestItemDerivation({
    super.title,
    super.description,
    super.metadata,
    required this.mustBeAccepted,
    this.requireManualDecision,
    required super.atType,
  });

  factory RequestItemDerivation.fromJson(Map json) {
    final type = json['@type'];

    return switch (type) {
      'AuthenticationRequestItem' => AuthenticationRequestItem.fromJson(json),
      'ConsentRequestItem' => ConsentRequestItem.fromJson(json),
      'CreateAttributeRequestItem' => CreateAttributeRequestItem.fromJson(json),
      'DeleteAttributeRequestItem' => DeleteAttributeRequestItem.fromJson(json),
      'FreeTextRequestItem' => FreeTextRequestItem.fromJson(json),
      'ProposeAttributeRequestItem' => ProposeAttributeRequestItem.fromJson(json),
      'ReadAttributeRequestItem' => ReadAttributeRequestItem.fromJson(json),
      'RegisterAttributeListenerRequestItem' => RegisterAttributeListenerRequestItem.fromJson(json),
      'ShareAttributeRequestItem' => ShareAttributeRequestItem.fromJson(json),
      'TransferFileOwnershipRequestItem' => TransferFileOwnershipRequestItem.fromJson(json),
      _ => throw Exception('Unknown type: $type'),
    };
  }

  @override
  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [...super.props, requireManualDecision, mustBeAccepted];
}
