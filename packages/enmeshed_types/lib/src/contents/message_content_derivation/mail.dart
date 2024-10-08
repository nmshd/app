part of 'message_content_derivation.dart';

class Mail extends MessageContentDerivation {
  final List<String> to;
  final List<String>? cc;
  final String subject;
  final String body;

  const Mail({
    required this.to,
    this.cc,
    required this.subject,
    required this.body,
  });

  factory Mail.fromJson(Map json) {
    return Mail(
      to: List<String>.from(json['to']),
      cc: json['cc'] != null ? List<String>.from(json['cc']) : null,
      subject: json['subject'],
      body: json['body'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '@type': 'Mail',
      'to': to,
      if (cc != null) 'cc': cc,
      'subject': subject,
      'body': body,
    };
  }

  @override
  List<Object?> get props => [to, cc, subject, body];
}
