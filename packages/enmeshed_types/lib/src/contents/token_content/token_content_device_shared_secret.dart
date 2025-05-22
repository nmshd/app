part of 'token_content.dart';

class TokenContentDeviceSharedSecret extends TokenContent {
  final DeviceSharedSecret sharedSecret;

  const TokenContentDeviceSharedSecret({required this.sharedSecret});

  factory TokenContentDeviceSharedSecret.fromJson(Map json) {
    final sharedSecret = json['sharedSecret'];
    sharedSecret['secretBaseKey'] = _toBase64WithNoPadding(sharedSecret['secretBaseKey']);
    sharedSecret['synchronizationKey'] = _toBase64WithNoPadding(sharedSecret['synchronizationKey']);
    sharedSecret['identityPrivateKey'] = sharedSecret['identityPrivateKey'] != null
        ? _toBase64WithNoPadding(sharedSecret['identityPrivateKey'])
        : null;
    sharedSecret['identity']['publicKey'] = _toBase64WithNoPadding(sharedSecret['identity']['publicKey']);

    return TokenContentDeviceSharedSecret(sharedSecret: DeviceSharedSecret.fromJson(sharedSecret));
  }

  @override
  Map<String, dynamic> toJson() => {'@type': 'TokenContentDeviceSharedSecret', 'sharedSecret': sharedSecret.toJson()};

  static String _toBase64WithNoPadding(dynamic content) {
    if (content is String) return content;

    return convert.base64UrlEncode(convert.utf8.encode(convert.json.encode(content))).replaceAll(RegExp('=+\$'), '');
  }
}
