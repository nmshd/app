import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../result.dart';

/// This facade lacks the functions received, requireManualDecision, complete and checkPrerequisites
/// because they are only usable in the automation of the actual JavaScript Enmeshed Runtime and shall not be used here.
class IncomingRequestsFacade {
  final AbstractEvaluator _evaluator;
  IncomingRequestsFacade(this._evaluator);

  Future<Result<RequestValidationResultDTO>> canAccept({
    required DecideRequestParameters params,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.incomingRequests.canAccept(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': params.toJson(),
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => RequestValidationResultDTO.fromJson(x));
  }

  Future<Result<LocalRequestDTO>> accept({
    required DecideRequestParameters params,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.incomingRequests.accept(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': params.toJson(),
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => LocalRequestDTO.fromJson(x));
  }

  Future<Result<RequestValidationResultDTO>> canReject({
    required DecideRequestParameters params,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.incomingRequests.canReject(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': params.toJson(),
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => RequestValidationResultDTO.fromJson(x));
  }

  Future<Result<LocalRequestDTO>> reject({
    required DecideRequestParameters params,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.incomingRequests.reject(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': params.toJson(),
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => LocalRequestDTO.fromJson(x));
  }

  Future<Result<LocalRequestDTO>> getRequest({
    required String requestId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.incomingRequests.getRequest(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': requestId,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => LocalRequestDTO.fromJson(x));
  }

  Future<Result<List<LocalRequestDTO>>> getRequests({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.incomingRequests.getRequests(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          if (query != null) 'query': query.toJson(),
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalRequestDTO>.from(value.map((e) => LocalRequestDTO.fromJson(e))));
  }
}
