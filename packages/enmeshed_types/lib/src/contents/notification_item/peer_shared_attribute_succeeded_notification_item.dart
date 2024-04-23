part of 'notification_item.dart';

@JsonSerializable(includeIfNull: false)
class PeerSharedAttributeSucceededNotificationItem extends NotificationItem {
  final String predecessorId;
  final String successorId;
  final AbstractAttribute successorContent;

  const PeerSharedAttributeSucceededNotificationItem({
    required this.predecessorId,
    required this.successorId,
    required this.successorContent,
  });

  factory PeerSharedAttributeSucceededNotificationItem.fromJson(Map json) =>
      _$PeerSharedAttributeSucceededNotificationItemFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() => _$PeerSharedAttributeSucceededNotificationItemToJson(this);

  @override
  List<Object?> get props => [predecessorId, successorId, successorContent];
}
