import 'package:enmeshed_types/enmeshed_types.dart';

import 'endpoint.dart';
import 'transformers.dart';

class MessagesEndpoint extends Endpoint {
  MessagesEndpoint(super.dio);

  Future<ConnectorResponse<List<MessageDTO>>> getMessages([Map<String, dynamic>? query]) => get(
        '/api/v2/Messages',
        transformer: (v) => List<MessageDTO>.from(v.map((e) => MessageDTO.fromJson(e))),
        query: query,
      );

  Future<ConnectorResponse<MessageDTO>> sendMessage({
    required List<String> recipients,
    required Map<String, dynamic> content,
    List<String>? attachments,
  }) =>
      post(
        '/api/v2/Messages',
        data: {
          'recipients': recipients,
          'content': content,
          'attachments': attachments,
        },
        transformer: (v) => MessageDTO.fromJson(v),
      );

  Future<ConnectorResponse<MessageWithAttachmentsDTO>> getMessage(String messageId) => get(
        '/api/v2/Messages/$messageId',
        transformer: (v) => MessageWithAttachmentsDTO.fromJson(v),
      );

  Future<ConnectorResponse<FileDTO>> getAttachment(String messageId, String attachmentId) => get(
        '/api/v2/Messages/$messageId/Attachments/$attachmentId',
        transformer: fileTransformer,
      );

  Future<ConnectorResponse<List<int>>> downloadAttachment(String messageId, String attachmentId) => download(
        '/api/v2/Messages/$messageId/Attachments/$attachmentId/Download',
      );
}
