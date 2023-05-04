part of 'token_content.dart';

class TokenContentDeviceSharedSecret extends TokenContent {
  final DeviceSharedSecret sharedSecret;

  const TokenContentDeviceSharedSecret({required this.sharedSecret});

  factory TokenContentDeviceSharedSecret.fromJson(Map json) {
    final sharedSecret = json['sharedSecret'];
    sharedSecret['secretBaseKey'] = sharedSecret['secretBaseKey'].toBase64WithNoPadding();
    sharedSecret['synchronizationKey'] = sharedSecret['synchronizationKey'].toBase64WithNoPadding();
    sharedSecret['identityPrivateKey'] = sharedSecret['identityPrivateKey'].toBase64WithNoPadding();
    sharedSecret['identity']['publicKey'] = sharedSecret['identity']['publicKey'].toBase64WithNoPadding();

    return TokenContentDeviceSharedSecret(sharedSecret: DeviceSharedSecret.fromJson(json['sharedSecret']));
  }

  @override
  Map<String, dynamic> toJson() => {'@type': 'TokenContentDeviceSharedSecret', 'sharedSecret': sharedSecret.toJson()};
}

extension ToBase64WithNoPadding on dynamic {
  String toBase64WithNoPadding() {
    if (this is String) return this;

    return base64UrlEncode(convert.utf8.encode(convert.json.encode(this))).replaceAll(RegExp('=+\$'), '');
  }
}
