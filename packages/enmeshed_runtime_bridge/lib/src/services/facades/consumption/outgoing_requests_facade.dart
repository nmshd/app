import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../result.dart';

/// This facade lacks the functions createAndCompleteFromRelationshipTemplateResponse, sent and complete
/// because they are only usable in the automation of the actual JavaScript Enmeshed Runtime and shall not be used here.
class OutgoingRequestsFacade {
  final AbstractEvaluator _evaluator;
  OutgoingRequestsFacade(this._evaluator);

  Future<Result<RequestValidationResultDTO>> canCreate({
    required Request content,
    String? peer,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.outgoingRequests.canCreate(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'content': content.toJson(),
          if (peer != null) 'peer': peer,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => RequestValidationResultDTO.fromJson(x));
  }

  Future<Result<LocalRequestDTO>> create({
    required Request content,
    required String peer,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.outgoingRequests.create(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'content': content.toJson(),
          'peer': peer,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => LocalRequestDTO.fromJson(x));
  }

  Future<Result<LocalRequestDTO>> getRequest({
    required String requestId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.outgoingRequests.getRequest(request)
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

  Future<Result<List<LocalRequestDTO>>> getRequests({
    Map<String, QueryValue>? query,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.outgoingRequests.getRequests(request)
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

  Future<void> discard({
    required String requestId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.outgoingRequests.discard(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': requestId,
        },
      },
    );

    result.throwOnError();
  }
}
