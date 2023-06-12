import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';
import 'result.dart';

class AttributeListenersFacade {
  final AbstractEvaluator _evaluator;
  AttributeListenersFacade(this._evaluator);

  Future<Result<LocalAttributeListenerDTO>> getAttributeListener({
    required String listenerId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributeListeners.getAttributeListener(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': listenerId,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => LocalAttributeListenerDTO.fromJson(x));
  }

  Future<Result<List<LocalAttributeListenerDTO>>> getAttributeListeners() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributeListeners.getAttributeListeners()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeListenerDTO>.from(value.map((e) => LocalAttributeListenerDTO.fromJson(e))));
  }
}
