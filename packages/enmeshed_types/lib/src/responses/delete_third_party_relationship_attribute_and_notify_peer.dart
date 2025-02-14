import 'package:json_annotation/json_annotation.dart';

part 'delete_third_party_relationship_attribute_and_notify_peer.g.dart';

@JsonSerializable(includeIfNull: false)
class DeleteThirdPartyRelationshipAttributeAndNotifyPeerResponse {
  final String? notificationId;

  DeleteThirdPartyRelationshipAttributeAndNotifyPeerResponse({this.notificationId});

  factory DeleteThirdPartyRelationshipAttributeAndNotifyPeerResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteThirdPartyRelationshipAttributeAndNotifyPeerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteThirdPartyRelationshipAttributeAndNotifyPeerResponseToJson(this);
}
