import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';
import 'result.dart';

class AttributesFacade {
  final AbstractEvaluator _evaluator;
  AttributesFacade(this._evaluator);

  Future<Result<LocalAttributeDTO>> createAttribute({
    required Map<String, dynamic> content,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.createAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'content': content,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalAttributeDTO.fromJson(value));
  }

  Future<Result<LocalAttributeDTO>> createSharedAttributeCopy({
    required String attributeId,
    required String peer,
    required String requestReference,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.createSharedAttributeCopy(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'attributeId': attributeId,
          'peer': peer,
          'requestReference': requestReference,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalAttributeDTO.fromJson(value));
  }

  Future<void> deleteAttribute({
    required String attributeId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.deleteAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': attributeId,
        },
      },
    );

    result.throwOnError();
  }

  Future<Result<List<LocalAttributeDTO>>> getPeerAttributes({
    required String peer,
    bool? onlyValid,
    bool? hideTechnical,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getPeerAttributes(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'peer': peer,
          if (onlyValid != null) 'onlyValid': onlyValid,
          if (hideTechnical != null) 'hideTechnical': hideTechnical,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<List<LocalAttributeDTO>>> getSharedToPeerAttributes({
    required String peer,
    bool? onlyValid,
    bool? hideTechnical,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getSharedToPeerAttributes(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'peer': peer,
          if (onlyValid != null) 'onlyValid': onlyValid,
          if (hideTechnical != null) 'hideTechnical': hideTechnical,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<LocalAttributeDTO>> getAttribute({
    required String attributeId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': attributeId,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalAttributeDTO.fromJson(value));
  }

  Future<Result<List<LocalAttributeDTO>>> getAttributes({
    Map<String, QueryValue>? query,
    bool? onlyValid,
    bool? hideTechnical,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getAttributes(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          if (query != null) 'query': query.toJson(),
          if (onlyValid != null) 'onlyValid': onlyValid,
          if (hideTechnical != null) 'hideTechnical': hideTechnical,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<List<LocalAttributeDTO>>> executeIdentityAttributeQuery({
    required IdentityAttributeQuery query,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.executeIdentityAttributeQuery(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'query': query.toJson(),
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<LocalAttributeDTO>> executeRelationshipAttributeQuery({
    required RelationshipAttributeQuery query,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.executeRelationshipAttributeQuery(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'query': query.toJson(),
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalAttributeDTO.fromJson(value));
  }

  Future<Result<List<LocalAttributeDTO>>> executeThirdPartyRelationshipAttributeQuery({
    required ThirdPartyRelationshipAttributeQuery query,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.executeThirdPartyRelationshipAttributeQuery(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'query': query.toJson(),
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<List<LocalAttributeDTO>>> executeIQLQuery({
    required IQLQuery query,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.executeIQLQuery(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'query': query.toJson(),
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<LocalAttributeDTO>> succeedAttribute({
    required Map<String, dynamic> successorContent,
    required String succeeds,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.succeedAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'successorContent': successorContent,
          'succeeds': succeeds,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalAttributeDTO.fromJson(value));
  }

  Future<Result<LocalAttributeDTO>> updateAttribute({
    required String attributeId,
    required Map<String, dynamic> content,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.updateAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': attributeId,
          'content': content,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalAttributeDTO.fromJson(value));
  }

  Future<Result<LocalRequestDTO>> shareAttribute({
    required String attributeId,
    required String peer,
    String? requestTitle,
    String? requestDescription,
    Map<String, dynamic>? requestMetadata,
    String? requestItemTitle,
    String? requestItemDescription,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.shareAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'attributeId': attributeId,
          'peer': peer,
          if (requestTitle != null) 'requestTitle': requestTitle,
          if (requestDescription != null) 'requestDescription': requestDescription,
          if (requestMetadata != null) 'requestMetadata': requestMetadata,
          if (requestItemTitle != null) 'requestItemTitle': requestItemTitle,
          if (requestItemDescription != null) 'requestItemDescription': requestItemDescription,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalRequestDTO.fromJson(value));
  }
}
