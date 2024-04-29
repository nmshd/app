part of 'notification_item.dart';

@JsonSerializable(includeIfNull: false)
class PeerSharedAttributeDeletedByPeerNotificationItem extends NotificationItem {
  final String attributeId;

  const PeerSharedAttributeDeletedByPeerNotificationItem({
    required this.attributeId,
  });

  factory PeerSharedAttributeDeletedByPeerNotificationItem.fromJson(Map json) =>
      _$PeerSharedAttributeDeletedByPeerNotificationItemFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => {
        ..._$PeerSharedAttributeDeletedByPeerNotificationItemToJson(this),
        '@type': 'PeerSharedAttributeDeletedByPeerNotificationItem',
      };

  @override
  List<Object?> get props => [attributeId];
}
