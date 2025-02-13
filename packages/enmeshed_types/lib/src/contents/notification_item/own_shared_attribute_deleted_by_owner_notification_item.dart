part of 'notification_item.dart';

@JsonSerializable(includeIfNull: false)
class OwnSharedAttributeDeletedByOwnerNotificationItem extends NotificationItem {
  final String attributeId;

  const OwnSharedAttributeDeletedByOwnerNotificationItem({required this.attributeId});

  factory OwnSharedAttributeDeletedByOwnerNotificationItem.fromJson(Map json) =>
      _$OwnSharedAttributeDeletedByOwnerNotificationItemFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => {
    ..._$OwnSharedAttributeDeletedByOwnerNotificationItemToJson(this),
    '@type': 'OwnSharedAttributeDeletedByOwnerNotificationItem',
  };

  @override
  List<Object?> get props => [attributeId];
}
