import 'package:json_annotation/json_annotation.dart';

part 'delete_attribute_and_notify.g.dart';

@JsonSerializable(includeIfNull: false)
class DeleteOwnSharedAttributeAndNotifyPeerResponse {
  final String notificationId;

  DeleteOwnSharedAttributeAndNotifyPeerResponse({
    required this.notificationId,
  });

  factory DeleteOwnSharedAttributeAndNotifyPeerResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteOwnSharedAttributeAndNotifyPeerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteOwnSharedAttributeAndNotifyPeerResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DeletePeerSharedAttributeAndNotifyOwnerResponse {
  final String notificationId;

  DeletePeerSharedAttributeAndNotifyOwnerResponse({
    required this.notificationId,
  });

  factory DeletePeerSharedAttributeAndNotifyOwnerResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePeerSharedAttributeAndNotifyOwnerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePeerSharedAttributeAndNotifyOwnerResponseToJson(this);
}

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
