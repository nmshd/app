import 'package:json_annotation/json_annotation.dart';

part 'register_push_notification_token.g.dart';

@JsonSerializable(includeIfNull: false)
class RegisterPushNotificationTokenResponse {
  final String devicePushIdentifier;

  RegisterPushNotificationTokenResponse({
    required this.devicePushIdentifier,
  });

  factory RegisterPushNotificationTokenResponse.fromJson(Map<String, dynamic> json) => _$RegisterPushNotificationTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterPushNotificationTokenResponseToJson(this);
}
