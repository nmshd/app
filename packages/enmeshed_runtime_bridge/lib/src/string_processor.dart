import 'package:enmeshed_types/enmeshed_types.dart';

import 'services/facades/abstract_evaluator.dart';
import 'services/facades/handle_call_async_js_result.dart';
import 'services/facades/result.dart';

class StringProcessor {
  final AbstractEvaluator _evaluator;

  StringProcessor(this._evaluator);

  Future<Result<void>> processURL({required String url, LocalAccountDTO? account}) async {
    final result = await _evaluator.evaluateJavascript(
      '''final result = await runtime.stringProcessor.processURL(url, account ?? undefined)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: {} }''',
      arguments: {
        'url': url,
        if (account != null) 'account': account.toJson(),
      },
    );

    return Result.fromJson(result.valueToMap(), (_) {});
  }

  Future<Result<void>> processTruncatedReference({required String truncatedReference, LocalAccountDTO? account}) async {
    final result = await _evaluator.evaluateJavascript(
      '''final result = await runtime.stringProcessor.processTruncatedReference(truncatedReference, account ?? undefined)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: {} }''',
      arguments: {
        'truncatedReference': truncatedReference,
        if (account != null) 'account': account.toJson(),
      },
    );

    return Result.fromJson(result.valueToMap(), (_) {});
  }
}
