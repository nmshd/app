import 'dart:collection';

import '../arbitraty_json.dart';
import '../response.dart';

part 'mail.dart';
part 'response_wrapper.dart';

abstract class MessageContent {
  const MessageContent();

  factory MessageContent.fromJson(Map<String, dynamic> json) {
    final type = json['@type'];

    switch (type) {
      case 'Mail':
        return Mail.fromJson(json);
      case 'ResponseWrapper':
        return ResponseWrapper.fromJson(json);
      default:
        return ArbitraryMessageContent(json);
    }
  }

  Map<String, dynamic> toJson();
}

class ArbitraryMessageContent extends MessageContent with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryMessageContent(this.internalJson);
}
