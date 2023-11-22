import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../arbitraty_json.dart';
import '../notification.dart';
import '../response.dart';

part 'mail.dart';
part 'message_content_notification.dart';
part 'response_wrapper.dart';

abstract class MessageContent extends Equatable {
  const MessageContent();

  factory MessageContent.fromJson(Map json) {
    final type = json['@type'];

    return switch (type) {
      'Mail' => Mail.fromJson(json),
      'ResponseWrapper' => ResponseWrapper.fromJson(json),
      'Notification' => MessageContentNotification.fromJson(json),
      _ => ArbitraryMessageContent(json),
    };
  }

  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props;
}

class ArbitraryMessageContent extends MessageContent with MapMixin<String, dynamic>, ArbitraryJSON {
  @override
  final Map<String, dynamic> internalJson;

  ArbitraryMessageContent(Map internalJson) : internalJson = Map<String, dynamic>.from(internalJson);

  @override
  List<Object?> get props => [internalJson];
}
