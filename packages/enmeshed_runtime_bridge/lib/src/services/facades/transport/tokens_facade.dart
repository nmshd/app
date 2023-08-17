import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../result.dart';

class TokensFacade {
  final AbstractEvaluator _evaluator;
  TokensFacade(this._evaluator);

  Future<Result<TokenDTO>> createOwnToken({
    required Map<String, dynamic> content,
    required String expiresAt,
    required bool ephemeral,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.tokens.createOwnToken(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'content': content,
          'expiresAt': expiresAt,
          'ephemeral': ephemeral,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => TokenDTO.fromJson(x));
  }

  Future<Result<TokenDTO>> loadPeerTokenByIdAndKey({
    required String id,
    required String secretKey,
    required bool ephemeral,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.tokens.loadPeerToken(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': id,
          'secretKey': secretKey,
          'ephemeral': ephemeral,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => TokenDTO.fromJson(x));
  }

  Future<Result<TokenDTO>> loadPeerTokenByReference({
    required String reference,
    required bool ephemeral,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.tokens.loadPeerToken(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'reference': reference,
          'ephemeral': ephemeral,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => TokenDTO.fromJson(x));
  }

  Future<Result<List<TokenDTO>>> getTokens({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.tokens.getTokens(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          if (query != null) 'query': query.toJson(),
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<TokenDTO>.from(value.map((e) => TokenDTO.fromJson(e))));
  }

  Future<Result<TokenDTO>> getToken(String id) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.tokens.getToken(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': id,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => TokenDTO.fromJson(x));
  }

  Future<Result<CreateQrCodeResponse>> getQRCodeForToken(String id) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.tokens.getQRCodeForToken(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': id,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => CreateQrCodeResponse.fromJson(x));
  }
}
