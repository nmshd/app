import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';

class AnonymousTokensFacade {
  final AbstractEvaluator _evaluator;
  AnonymousTokensFacade(this._evaluator);

  Future<TokenDTO> loadPeerTokenByTruncatedReference(
    String tokenReference,
  ) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await runtime.anonymousServices.tokens.loadPeerTokenByTruncatedReference(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'reference': tokenReference,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final token = TokenDTO.fromJson(value);
    return token;
  }

  Future<TokenDTO> loadPeerTokenByIdAndKey(String id, String secretKey) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await runtime.anonymousServices.tokens.loadPeerTokenByIdAndKey(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': id,
          'secretKey': secretKey,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final token = TokenDTO.fromJson(value);
    return token;
  }
}
