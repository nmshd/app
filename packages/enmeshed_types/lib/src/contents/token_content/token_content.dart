import 'dart:collection';

import '../../dtos/device_shared_secret.dart';
import '../arbitraty_json.dart';

part 'token_content_device_shared_secret.dart';

abstract class TokenContent {
  const TokenContent();

  /// could support more types here, e.g.:
  /// TokenContentRelationshipTemplate, TokenContentFile
  /// these types are processed automatically by the Enmeshed runtime and do not have to be rendered
  factory TokenContent.fromJson(Map json) {
    final type = json['@type'];

    switch (type) {
      case 'TokenContentDeviceSharedSecret':
        return TokenContentDeviceSharedSecret.fromJson(json);
      default:
        return ArbitraryTokenContent(json);
    }
  }

  Map<String, dynamic> toJson();
}

class ArbitraryTokenContent extends TokenContent with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryTokenContent(Map internalJson) : internalJson = Map<String, dynamic>.from(internalJson);
}
