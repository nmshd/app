import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class TokensFacade {
  final AbstractEvaluator _evaluator;
  TokensFacade(this._evaluator);

  Future<Result<TokenDTO>> createOwnToken({
    required Map<String, dynamic> content,
    required String expiresAt,
    required bool ephemeral,
    String? forIdentity,
    PasswordProtection? passwordProtection,
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
          if (forIdentity != null) 'forIdentity': forIdentity,
          if (passwordProtection != null) 'passwordProtection': passwordProtection.toJson(),
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => TokenDTO.fromJson(x));
  }

  Future<Result<TokenDTO>> loadPeerToken({required String reference, required bool ephemeral, String? password}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.tokens.loadPeerToken(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'reference': reference, 'ephemeral': ephemeral, if (password != null) 'password': password},
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
        'request': {if (query != null) 'query': query.toJson()},
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
        'request': {'id': id},
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => TokenDTO.fromJson(x));
  }

  Future<Result<CreateQRCodeResponse>> getQRCodeForToken(String id) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.tokens.getQRCodeForToken(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'id': id},
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => CreateQRCodeResponse.fromJson(x));
  }
}
