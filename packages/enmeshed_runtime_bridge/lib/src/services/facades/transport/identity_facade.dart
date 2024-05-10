import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class IdentityFacade {
  final AbstractEvaluator _evaluator;
  IdentityFacade(this._evaluator);

  Future<Result<CheckIdentityResponse>> getIdentityDeletionProcess(String identityAddress) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.identity.checkIdentity(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'address': identityAddress,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => CheckIdentityResponse.fromJson(x));
  }
}
