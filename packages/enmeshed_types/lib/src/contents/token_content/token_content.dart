import 'dart:collection';

import '../arbitraty_json.dart';

abstract class TokenContent {
  const TokenContent();

  /// could support more types here, e.g.:
  /// TokenContentRelationshipTemplate, TokenContentFile, TokenContentDeviceSharedSecret
  /// these types are processed automatically by the Enmeshed runtime and do not have to be rendered
  factory TokenContent.fromJson(Map json) => ArbitraryTokenContent(json);

  Map<String, dynamic> toJson();
}

class ArbitraryTokenContent extends TokenContent with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryTokenContent(Map internalJson) : internalJson = Map<String, dynamic>.from(internalJson);
}
