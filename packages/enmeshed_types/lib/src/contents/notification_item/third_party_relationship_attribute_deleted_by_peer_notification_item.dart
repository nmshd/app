part of 'notification_item.dart';

@JsonSerializable(includeIfNull: false)
class ThirdPartyRelationshipAttributeDeletedByPeerNotificationItem extends NotificationItem {
  final String attributeId;

  const ThirdPartyRelationshipAttributeDeletedByPeerNotificationItem({
    required this.attributeId,
  });

  factory ThirdPartyRelationshipAttributeDeletedByPeerNotificationItem.fromJson(Map json) =>
      _$ThirdPartyRelationshipAttributeDeletedByPeerNotificationItemFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => {
        ..._$ThirdPartyRelationshipAttributeDeletedByPeerNotificationItemToJson(this),
        '@type': 'ThirdPartyRelationshipAttributeDeletedByPeerNotificationItem',
      };

  @override
  List<Object?> get props => [attributeId];
}
