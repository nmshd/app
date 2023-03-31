import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../arbitraty_json.dart';
import '../response.dart';

part 'mail.dart';
part 'response_wrapper.dart';

abstract class MessageContent extends Equatable {
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

  @mustCallSuper
  @override
  List<Object?> get props;
}

class ArbitraryMessageContent extends MessageContent with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryMessageContent(this.internalJson);

  @override
  List<Object?> get props => [internalJson];
}
