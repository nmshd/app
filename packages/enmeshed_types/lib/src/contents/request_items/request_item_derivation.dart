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

  const RequestItemDerivation({super.title, super.description, super.metadata, required this.mustBeAccepted, this.requireManualDecision});

  factory RequestItemDerivation.fromJson(Map json) {
    final type = json['@type'];

    return switch (type) {
      'ReadAttributeRequestItem' => ReadAttributeRequestItem.fromJson(json),
      'CreateAttributeRequestItem' => CreateAttributeRequestItem.fromJson(json),
      'ShareAttributeRequestItem' => ShareAttributeRequestItem.fromJson(json),
      'ProposeAttributeRequestItem' => ProposeAttributeRequestItem.fromJson(json),
      'ConsentRequestItem' => ConsentRequestItem.fromJson(json),
      'AuthenticationRequestItem' => AuthenticationRequestItem.fromJson(json),
      'RegisterAttributeListenerRequestItem' => RegisterAttributeListenerRequestItem.fromJson(json),
      'FreeTextRequestItem' => FreeTextRequestItem.fromJson(json),
      'DeleteAttributeRequestItem' => DeleteAttributeRequestItem.fromJson(json),
      'TransferFileOwnershipRequestItem' => TransferFileOwnershipRequestItem.fromJson(json),
      _ => throw Exception('Unknown type: $type'),
    };
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'mustBeAccepted': mustBeAccepted,
    if (requireManualDecision != null) 'requireManualDecision': requireManualDecision,
  };

  @override
  List<Object?> get props => [super.props, requireManualDecision, mustBeAccepted];
}
