import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class BackboneCompatibilityFacade {
  final AbstractEvaluator _evaluator;
  BackboneCompatibilityFacade(this._evaluator);

  Future<Result<CheckBackboneCompatibilityResponse>> checkBackboneCompatibility() async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await runtime.anonymousServices.backboneCompatibility.checkBackboneCompatibility()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => CheckBackboneCompatibilityResponse.fromJson(x));
  }
}
