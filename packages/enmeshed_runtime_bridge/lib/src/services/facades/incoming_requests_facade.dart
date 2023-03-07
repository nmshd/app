import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';

class IncomingRequestsFacade {
  final AbstractEvaluator _evaluator;
  IncomingRequestsFacade(this._evaluator);

  Future<LocalRequestDTO> received({
    required Request receivedRequest,
    required String requestSourceId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.incomingRequests.received(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'receivedRequest': receivedRequest,
          'requestSourceId': requestSourceId,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final request = LocalRequestDTO.fromJson(value);
    return request;
  }

  Future<LocalRequestDTO> checkPrerequisites({
    required String requestId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.incomingRequests.checkPrerequisites(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'requestId': requestId,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final request = LocalRequestDTO.fromJson(value);
    return request;
  }

  Future<LocalRequestDTO> requireManualDecision({
    required String requestId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.incomingRequests.requireManualDecision(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'requestId': requestId,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final request = LocalRequestDTO.fromJson(value);
    return request;
  }

  Future<RequestValidationResultDTO> canAccept({
    required DecideRequestParameters params,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.incomingRequests.canAccept(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': params.toJson(),
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final validationResult = RequestValidationResultDTO.fromJson(value);
    return validationResult;
  }

  Future<LocalRequestDTO> accept({
    required DecideRequestParameters params,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.incomingRequests.accept(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': params.toJson(),
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final request = LocalRequestDTO.fromJson(value);
    return request;
  }

  Future<RequestValidationResultDTO> canReject({
    required DecideRequestParameters params,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.incomingRequests.canReject(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': params.toJson(),
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final validationResult = RequestValidationResultDTO.fromJson(value);
    return validationResult;
  }

  Future<LocalRequestDTO> reject({
    required DecideRequestParameters params,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.incomingRequests.reject(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': params.toJson(),
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final request = LocalRequestDTO.fromJson(value);
    return request;
  }

  Future<LocalRequestDTO> complete({
    required String requestId,
    String? responseSourceId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.incomingRequests.complete(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'requestId': requestId,
          if (responseSourceId != null) 'responseSourceId': responseSourceId,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final request = LocalRequestDTO.fromJson(value);
    return request;
  }

  Future<LocalRequestDTO> getRequest({
    required String requestId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.incomingRequests.getRequest(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': requestId,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final request = LocalRequestDTO.fromJson(value);
    return request;
  }

  Future<List<LocalRequestDTO>> getRequests({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.incomingRequests.getRequests(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          if (query != null) 'query': query.toJson(),
        },
      },
    );

    final value = result.toValue<List<dynamic>>();
    final requests = value.map((e) => LocalRequestDTO.fromJson(e)).toList();
    return requests;
  }
}
