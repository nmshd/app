// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
  id: json['id'] as String,
  items: (json['items'] as List<dynamic>).map((e) => NotificationItem.fromJson(e as Map<String, dynamic>)).toList(),
);

Map<String, dynamic> _$NotificationToJson(Notification instance) => <String, dynamic>{
  'id': instance.id,
  'items': instance.items.map((e) => e.toJson()).toList(),
};
