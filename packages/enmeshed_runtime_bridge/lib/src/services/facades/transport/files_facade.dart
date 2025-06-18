import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class FilesFacade {
  final AbstractEvaluator _evaluator;
  FilesFacade(this._evaluator);

  Future<Result<List<FileDTO>>> getFiles({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.files.getFiles(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {if (query != null) 'query': query.toJson()},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<FileDTO>.from(value.map((e) => FileDTO.fromJson(e))));
  }

  Future<Result<FileDTO>> getOrLoadFile({required String reference, String? password}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.files.getOrLoadFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'reference': reference, 'password': ?password},
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => FileDTO.fromJson(x));
  }

  Future<Result<DownloadFileResponse>> downloadFile({required String fileId}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.files.downloadFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: { ...result.value, content: Array.from(result.value.content) } }''',
      arguments: {
        'request': {'id': fileId},
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => DownloadFileResponse.fromJson(x));
  }

  Future<Result<FileDTO>> getFile({required String fileId}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.files.getFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'id': fileId},
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => FileDTO.fromJson(x));
  }

  Future<Result<FileDTO>> uploadOwnFile({
    required List<int> content,
    required String filename,
    required String mimetype,
    String? expiresAt,
    String? title,
    String? description,
    List<String>? tags,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''request.content = new Uint8Array(request.content)
      const result = await session.transportServices.files.uploadOwnFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'content': content,
          'filename': filename,
          'mimetype': mimetype,
          'expiresAt': ?expiresAt,
          'title': ?title,
          'description': ?description,
          'tags': ?tags,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => FileDTO.fromJson(x));
  }

  Future<Result<TokenDTO>> createTokenForFile({
    required String fileId,
    String? expiresAt,
    bool? ephemeral,
    String? forIdentity,
    PasswordProtection? passwordProtection,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.files.createTokenForFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'fileId': fileId,
          'expiresAt': ?expiresAt,
          'ephemeral': ?ephemeral,
          'forIdentity': ?forIdentity,
          if (passwordProtection != null) 'passwordProtection': passwordProtection.toJson(),
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => TokenDTO.fromJson(x));
  }

  Future<VoidResult> deleteFile({required String fileId}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.files.deleteFile(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'fileId': fileId},
      },
    );

    return VoidResult.fromJson(result.valueToMap());
  }

  Future<Result<FileDTO>> markFileAsViewed({required String id}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.files.markFileAsViewed(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'id': id},
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => FileDTO.fromJson(x));
  }
}
