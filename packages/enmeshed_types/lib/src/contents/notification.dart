import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'notification_item/notification_item.dart';

part 'notification.g.dart';

@JsonSerializable(includeIfNull: false)
class Notification extends Equatable {
  final String id;
  final List<NotificationItem> items;

  const Notification({required this.id, required this.items});

  factory Notification.fromJson(Map json) => _$NotificationFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  @override
  List<Object?> get props => [id, items];
}
