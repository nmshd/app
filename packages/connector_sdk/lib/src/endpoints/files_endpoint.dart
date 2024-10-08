import 'package:dio/dio.dart';
import 'package:enmeshed_types/enmeshed_types.dart';

import 'endpoint.dart';
import 'transformers.dart';

class FilesEndpoint extends Endpoint {
  FilesEndpoint(super.dio);

  Future<ConnectorResponse<List<FileDTO>>> getFiles([Map<String, dynamic>? query]) => get(
        '/api/v2/Files',
        transformer: fileListTransformer,
        query: query,
      );

  Future<ConnectorResponse<FileDTO>> uploadOwnFile({
    required String title,
    String? description,
    required String expiresAt,
    required List<int> file,
    required String filename,
  }) async =>
      post(
        '/api/v2/Files/Own',
        transformer: fileTransformer,
        data: FormData.fromMap({
          'title': title,
          if (description != null) 'description': description,
          'expiresAt': expiresAt,
          'file': MultipartFile.fromBytes(file, filename: filename),
        }),
      );

  Future<ConnectorResponse<List<FileDTO>>> getOwnFiles([Map<String, dynamic>? query]) => get(
        '/api/v2/Files/Own',
        transformer: fileListTransformer,
        query: query,
      );

  Future<ConnectorResponse<FileDTO>> loadPeerFile({required String truncatedReference}) => post(
        '/api/v2/Files/Peer',
        transformer: fileTransformer,
        data: {
          'reference': truncatedReference,
        },
      );

  Future<ConnectorResponse<List<FileDTO>>> getPeerFiles([Map<String, dynamic>? query]) => get(
        '/api/v2/Files/Peer',
        transformer: fileListTransformer,
        query: query,
      );

  Future<ConnectorResponse<FileDTO>> getFile(String fileIdOrReference) async => get(
        '/api/v2/Files/$fileIdOrReference',
        transformer: fileTransformer,
      );

  Future<ConnectorResponse<List<int>>> downloadFile(String fileId) => download('/api/v2/Files/$fileId/Download');

  Future<ConnectorResponse<List<int>>> getQRCodeForFile(String fileId) => downloadQRCode('GET', '/api/v2/Files/$fileId');

  Future<ConnectorResponse<TokenDTO>> createTokenForFile(String fileId, {String? expiresAt, bool? ephemeral, String? forIdentity}) => post(
        '/api/v2/Files/$fileId/Token',
        transformer: tokenTransformer,
        data: {
          if (expiresAt != null) 'expiresAt': expiresAt,
          if (ephemeral != null) 'ephemeral': ephemeral,
          if (forIdentity != null) 'forIdentity': forIdentity,
        },
      );

  Future<ConnectorResponse<List<int>>> createTokenQRCodeForFile(String fileId, {String? expiresAt, String? forIdentity}) =>
      downloadQRCode('POST', '/api/v2/Files/$fileId/Token', request: {
        if (expiresAt != null) 'expiresAt': expiresAt,
        if (forIdentity != null) 'forIdentity': forIdentity,
      });
}
