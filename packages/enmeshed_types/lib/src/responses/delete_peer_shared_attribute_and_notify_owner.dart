import 'package:json_annotation/json_annotation.dart';

part 'delete_peer_shared_attribute_and_notify_owner.g.dart';

@JsonSerializable(includeIfNull: false)
class DeletePeerSharedAttributeAndNotifyOwnerResponse {
  final String? notificationId;

  DeletePeerSharedAttributeAndNotifyOwnerResponse({
    this.notificationId,
  });

  factory DeletePeerSharedAttributeAndNotifyOwnerResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePeerSharedAttributeAndNotifyOwnerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePeerSharedAttributeAndNotifyOwnerResponseToJson(this);
}
