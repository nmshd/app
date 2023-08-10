import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';
import 'result.dart';

class AnonymousTokensFacade {
  final AbstractEvaluator _evaluator;
  AnonymousTokensFacade(this._evaluator);

  Future<Result<TokenDTO>> loadPeerTokenByTruncatedReference(
    String tokenReference,
  ) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await runtime.anonymousServices.tokens.loadPeerTokenByTruncatedReference(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'reference': tokenReference,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => TokenDTO.fromJson(x));
  }

  Future<Result<TokenDTO>> loadPeerTokenByIdAndKey(String id, String secretKey) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await runtime.anonymousServices.tokens.loadPeerTokenByIdAndKey(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': id,
          'secretKey': secretKey,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => TokenDTO.fromJson(x));
  }
}
