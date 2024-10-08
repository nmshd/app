import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class AnonymousTokensFacade {
  final AbstractEvaluator _evaluator;
  AnonymousTokensFacade(this._evaluator);

  Future<Result<TokenDTO>> loadPeerToken(
    String tokenReference,
  ) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await runtime.anonymousServices.tokens.loadPeerToken(request)
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
}
