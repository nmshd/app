part of 'token_content.dart';

class TokenContentDeviceSharedSecret extends TokenContent {
  final DeviceSharedSecret sharedSecret;

  const TokenContentDeviceSharedSecret({required this.sharedSecret});

  factory TokenContentDeviceSharedSecret.fromJson(Map json) => TokenContentDeviceSharedSecret(
        sharedSecret: DeviceSharedSecret.fromJson(json['sharedSecret']),
      );

  @override
  Map<String, dynamic> toJson() => {'@type': 'TokenContentDeviceSharedSecret', 'sharedSecret': sharedSecret.toJson()};
}
