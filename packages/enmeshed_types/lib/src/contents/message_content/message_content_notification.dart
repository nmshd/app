part of 'message_content.dart';

class MessageContentNotification extends MessageContent {
  final Notification notification;

  const MessageContentNotification({required this.notification});

  factory MessageContentNotification.fromJson(Map json) => MessageContentNotification(notification: Notification.fromJson(json));

  @override
  List<Object?> get props => [notification];

  @override
  Map<String, dynamic> toJson() => notification.toJson();
}
