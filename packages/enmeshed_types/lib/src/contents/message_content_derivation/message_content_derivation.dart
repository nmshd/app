import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../arbitrary_content_json.dart';
import '../notification.dart';
import '../request.dart';
import '../response.dart';

part 'mail.dart';
part 'message_content_notification.dart';
part 'message_content_request.dart';
part 'response_wrapper.dart';

abstract class MessageContentDerivation extends Equatable {
  const MessageContentDerivation();

  factory MessageContentDerivation.fromJson(Map json) {
    final type = json['@type'];

    return switch (type) {
      'Mail' => Mail.fromJson(json),
      'ResponseWrapper' => ResponseWrapper.fromJson(json),
      'Notification' => MessageContentNotification.fromJson(json),
      'Request' => MessageContentRequest.fromJson(json),
      'ArbitraryMessageContent' => ArbitraryMessageContent.fromJson(json),
      _ => throw Exception('Unknown type: $type'),
    };
  }

  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props;
}

class ArbitraryMessageContent extends MessageContentDerivation with MapMixin<String, dynamic>, ArbitraryContentJSON {
  @override
  final Map<String, dynamic> value;

  ArbitraryMessageContent(Map internalJson) : value = Map<String, dynamic>.from(internalJson);

  factory ArbitraryMessageContent.fromJson(Map json) => ArbitraryMessageContent(json['value']);

  @override
  Map<String, dynamic> toJson() => {'@type': 'ArbitraryMessageContent', 'value': value};

  @override
  List<Object?> get props => [value];
}
