import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../abstract_attribute.dart';

part 'notification_item.g.dart';

abstract class NotificationItem extends Equatable {
  const NotificationItem();

  factory NotificationItem.fromJson(Map json) => switch (json['type']) {
        'NotificationItemGroup' => PeerSharedAttributeSucceededNotificationItem.fromJson(json),
        final String type => GenericNotificationItem(type: type, data: Map<String, dynamic>.from(json)),
        _ => throw ArgumentError('Unknown type: ${json['type']}'),
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
  List<Object?> get props => [predecessorId, successorId];
}
