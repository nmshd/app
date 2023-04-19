import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';

class MessagesFacade {
  final AbstractEvaluator _evaluator;
  MessagesFacade(this._evaluator);

  Future<MessageDTO> sendMessage({
    required List<String> recipients,
    required Map<String, dynamic> content,
    List<String>? attachments,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.messages.sendMessage(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'recipients': recipients,
          'content': content,
          if (attachments != null) 'attachments': attachments,
        },
      },
    );

    final value = result.valueToMap();
    final message = MessageDTO.fromJson(value);
    return message;
  }

  Future<List<MessageDTO>> getMessages({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.messages.getMessages(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          if (query != null) 'query': query.toJson(),
        },
      },
    );

    final value = result.valueToList();
    final messages = value.map((e) => MessageDTO.fromJson(e)).toList();
    return messages;
  }

  Future<MessageWithAttachmentsDTO> getMessage(String messageId) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.messages.getMessage(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': messageId,
        },
      },
    );

    final value = result.valueToMap();
    final message = MessageWithAttachmentsDTO.fromJson(value);
    return message;
  }

  Future<DownloadFileResponse> downloadAttachment({
    required String messageId,
    required String attachmentId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.messages.downloadAttachment(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': messageId,
          'attachmentId': attachmentId,
        },
      },
    );

    final value = result.valueToMap();
    final response = DownloadFileResponse.fromJson(value);
    return response;
  }

  Future<FileDTO> getAttachmentMetadata({
    required String messageId,
    required String attachmentId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.messages.getAttachmentMetadata(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': messageId,
          'attachmentId': attachmentId,
        },
      },
    );

    final value = result.valueToMap();
    final file = FileDTO.fromJson(value);
    return file;
  }
}
