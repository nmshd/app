part of 'message_content.dart';

class MessageContentRequest extends MessageContent {
  final Request request;

  const MessageContentRequest({required this.request});

  factory MessageContentRequest.fromJson(Map json) => MessageContentRequest(request: Request.fromJson(json));

  @override
  List<Object?> get props => [request];

  @override
  Map<String, dynamic> toJson() => request.toJson();
}
