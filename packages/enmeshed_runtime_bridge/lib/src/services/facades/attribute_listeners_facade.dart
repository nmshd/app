import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';

class AttributeListenersFacade {
  final AbstractEvaluator _evaluator;
  AttributeListenersFacade(this._evaluator);

  Future<LocalAttributeListenerDTO> getAttributeListener({
    required String listenerId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributeListeners.getAttributeListener(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': listenerId,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final listener = LocalAttributeListenerDTO.fromJson(value);
    return listener;
  }

  Future<List<LocalAttributeListenerDTO>> getAttributeListeners() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributeListeners.getAttributeListeners()
      if (result.isError) throw new Error(result.error)
      return result.value''',
    );

    final value = result.toValue<List<dynamic>>();
    final listeners = value.map((e) => LocalAttributeListenerDTO.fromJson(e)).toList();
    return listeners;
  }
}
