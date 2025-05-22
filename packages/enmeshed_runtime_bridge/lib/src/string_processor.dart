import 'package:enmeshed_types/enmeshed_types.dart';

import 'services/facades/abstract_evaluator.dart';
import 'services/facades/handle_call_async_js_result.dart';
import 'services/facades/utilities/utilities.dart';

class StringProcessor {
  final AbstractEvaluator _evaluator;

  StringProcessor(this._evaluator);

  Future<VoidResult> processURL({required String url, LocalAccountDTO? account}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await runtime.stringProcessor.processURL(url, account ?? undefined)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: {} }''',
      arguments: {'url': url, 'account': account?.toJson()},
    );

    return VoidResult.fromJson(result.valueToMap());
  }

  Future<VoidResult> processReference({required String reference, LocalAccountDTO? account}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await runtime.stringProcessor.processReference(reference, account ?? undefined)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: {} }''',
      arguments: {'reference': reference, 'account': account?.toJson()},
    );

    return VoidResult.fromJson(result.valueToMap());
  }

  Future<VoidResult> processDeviceOnboardingReference({required String url}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await runtime.stringProcessor.processDeviceOnboardingReference(url)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: {} }''',
      arguments: {'url': url},
    );

    return VoidResult.fromJson(result.valueToMap());
  }
}
