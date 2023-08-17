import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../result.dart';

class MessagesFacade {
  final AbstractEvaluator _evaluator;
  MessagesFacade(this._evaluator);

  Future<Result<MessageDTO>> sendMessage({
    required List<String> recipients,
    required Map<String, dynamic> content,
    List<String>? attachments,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.messages.sendMessage(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'recipients': recipients,
          'content': content,
          if (attachments != null) 'attachments': attachments,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => MessageDTO.fromJson(x));
  }

  Future<Result<List<MessageDTO>>> getMessages({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.messages.getMessages(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          if (query != null) 'query': query.toJson(),
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<MessageDTO>.from(value.map((e) => MessageDTO.fromJson(e))));
  }

  Future<Result<MessageWithAttachmentsDTO>> getMessage(String messageId) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.messages.getMessage(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': messageId,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => MessageWithAttachmentsDTO.fromJson(x));
  }

  Future<Result<DownloadFileResponse>> downloadAttachment({
    required String messageId,
    required String attachmentId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.messages.downloadAttachment(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: { ...result.value, content: Array.from(result.value.content) } }''',
      arguments: {
        'request': {
          'id': messageId,
          'attachmentId': attachmentId,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => DownloadFileResponse.fromJson(x));
  }

  Future<Result<FileDTO>> getAttachmentMetadata({
    required String messageId,
    required String attachmentId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.messages.getAttachmentMetadata(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': messageId,
          'attachmentId': attachmentId,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => FileDTO.fromJson(x));
  }
}
