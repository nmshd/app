import 'package:json_annotation/json_annotation.dart';

part 'delete_own_shared_attribute_and_notify_peer.g.dart';

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
