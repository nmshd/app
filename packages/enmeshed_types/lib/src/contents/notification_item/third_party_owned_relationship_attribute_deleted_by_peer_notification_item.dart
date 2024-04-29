part of 'notification_item.dart';

@JsonSerializable(includeIfNull: false)
class ThirdPartyOwnedRelationshipAttributeDeletedByPeerNotificationItem extends NotificationItem {
  final String attributeId;

  const ThirdPartyOwnedRelationshipAttributeDeletedByPeerNotificationItem({
    required this.attributeId,
  });

  factory ThirdPartyOwnedRelationshipAttributeDeletedByPeerNotificationItem.fromJson(Map json) =>
      _$ThirdPartyOwnedRelationshipAttributeDeletedByPeerNotificationItemFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => {
        ..._$ThirdPartyOwnedRelationshipAttributeDeletedByPeerNotificationItemToJson(this),
        '@type': 'ThirdPartyOwnedRelationshipAttributeDeletedByPeerNotificationItem',
      };

  @override
  List<Object?> get props => [attributeId];
}
