import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';
import 'result.dart';

class FilesFacade {
  final AbstractEvaluator _evaluator;
  FilesFacade(this._evaluator);

  Future<Result<List<FileDTO>>> getFiles({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.files.getFiles(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          if (query != null) 'query': query.toJson(),
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<FileDTO>.from(value.map((e) => FileDTO.fromJson(e))));
  }

  Future<Result<FileDTO>> getOrLoadFileByIdAndKey({
    required String fileId,
    required String secretKey,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.files.getOrLoadFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': fileId,
          'secretKey': secretKey,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => FileDTO.fromJson(x));
  }

  Future<Result<FileDTO>> getOrLoadFileByReference({
    required String reference,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.files.getOrLoadFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'reference': reference,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => FileDTO.fromJson(x));
  }

  Future<Result<DownloadFileResponse>> downloadFile({
    required String fileId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.files.downloadFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': fileId,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => DownloadFileResponse.fromJson(x));
  }

  Future<Result<FileDTO>> getFile({
    required String fileId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.files.getFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': fileId,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => FileDTO.fromJson(x));
  }

  Future<Result<FileDTO>> uploadOwnFile({
    required List<int> content,
    required String filename,
    required String mimetype,
    required String expiresAt,
    required String title,
    String? description,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''request.content = new Uint8Array(request.content)
      const result = await session.transportServices.files.uploadOwnFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'content': content,
          'filename': filename,
          'mimetype': mimetype,
          'expiresAt': expiresAt,
          'title': title,
          if (description != null) 'description': description,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => FileDTO.fromJson(x));
  }

  Future<Result<CreateQrCodeResponse>> createQrCodeForFile({
    required String fileId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.files.createQrCodeForFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'fileId': fileId,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => CreateQrCodeResponse.fromJson(x));
  }

  Future<Result<TokenDTO>> createTokenForFile({
    required String fileId,
    String? expiresAt,
    bool? ephemeral,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.files.createTokenForFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'fileId': fileId,
          if (expiresAt != null) 'expiresAt': expiresAt,
          if (ephemeral != null) 'ephemeral': ephemeral,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => TokenDTO.fromJson(x));
  }

  Future<Result<CreateQrCodeResponse>> createTokenQrCodeForFile({
    required String fileId,
    String? expiresAt,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.files.createTokenQrCodeForFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'fileId': fileId,
          if (expiresAt != null) 'expiresAt': expiresAt,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => CreateQrCodeResponse.fromJson(x));
  }
}
