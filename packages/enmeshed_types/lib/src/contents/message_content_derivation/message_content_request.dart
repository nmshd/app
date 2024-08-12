part of 'message_content_derivation.dart';

class MessageContentRequest extends MessageContentDerivation {
  final Request request;

  const MessageContentRequest({required this.request});

  factory MessageContentRequest.fromJson(Map json) => MessageContentRequest(request: Request.fromJson(json));

  @override
  List<Object?> get props => [request];

  @override
  Map<String, dynamic> toJson() => request.toJson();
}
