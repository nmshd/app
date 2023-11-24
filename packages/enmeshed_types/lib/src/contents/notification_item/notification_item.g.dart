// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeerSharedAttributeSucceededNotificationItem _$PeerSharedAttributeSucceededNotificationItemFromJson(Map<String, dynamic> json) =>
    PeerSharedAttributeSucceededNotificationItem(
      predecessorId: json['predecessorId'] as String,
      successorId: json['successorId'] as String,
      successorContent: AbstractAttribute.fromJson(json['successorContent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PeerSharedAttributeSucceededNotificationItemToJson(PeerSharedAttributeSucceededNotificationItem instance) => <String, dynamic>{
      'predecessorId': instance.predecessorId,
      'successorId': instance.successorId,
      'successorContent': instance.successorContent.toJson(),
    };
