import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../abstract_attribute.dart';

part 'notification_item.g.dart';
part 'peer_shared_attribute_succeeded_notification_item.dart';
part 'own_shared_attribute_deleted_by_owner_notification_item.dart';
part 'peer_shared_attribute_deleted_by_peer_notification_item.dart';
part 'third_party_relationship_attribute_deleted_by_peer_notification_item.dart';

abstract class NotificationItem extends Equatable {
  const NotificationItem();

  factory NotificationItem.fromJson(Map json) => switch (json['@type']) {
    'PeerSharedAttributeSucceededNotificationItem' => PeerSharedAttributeSucceededNotificationItem.fromJson(json),
    'OwnSharedAttributeDeletedByOwnerNotificationItem' => OwnSharedAttributeDeletedByOwnerNotificationItem.fromJson(json),
    'PeerSharedAttributeDeletedByPeerNotificationItem' => PeerSharedAttributeDeletedByPeerNotificationItem.fromJson(json),
    'ThirdPartyRelationshipAttributeDeletedByPeerNotificationItem' => ThirdPartyRelationshipAttributeDeletedByPeerNotificationItem.fromJson(json),
    final String type => GenericNotificationItem(type: type, data: Map<String, dynamic>.from(json)),
    _ => throw ArgumentError('Unknown type: ${json['@type']}'),
  };
  Map<String, dynamic> toJson();
}

class GenericNotificationItem extends NotificationItem {
  final String type;
  final Map<String, dynamic> data;

  const GenericNotificationItem({required this.type, required this.data});

  @override
  List<Object?> get props => [type, data];

  @override
  Map<String, dynamic> toJson() => data;
}
