import 'package:json_annotation/json_annotation.dart';

part 'delete_third_party_owned_relationship_attribute_and_notify_peer.g.dart';

@JsonSerializable(includeIfNull: false)
class DeleteThirdPartyOwnedRelationshipAttributeAndNotifyPeerResponse {
  final String notificationId;

  DeleteThirdPartyOwnedRelationshipAttributeAndNotifyPeerResponse({
    required this.notificationId,
  });

  factory DeleteThirdPartyOwnedRelationshipAttributeAndNotifyPeerResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteThirdPartyOwnedRelationshipAttributeAndNotifyPeerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteThirdPartyOwnedRelationshipAttributeAndNotifyPeerResponseToJson(this);
}
