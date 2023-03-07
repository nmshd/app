import 'package:enmeshed_types/enmeshed_types.dart';

void main() {
  final mail = Mail(to: ['A recipient'], subject: 'subject', body: 'body');

  final messageContent = MessageContent.fromJson(mail.toJson());
  if (messageContent is! Mail) {
    throw Exception('Expected Mail, got ${messageContent.runtimeType}');
  }
}
