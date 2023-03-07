import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';

class AttributesFacade {
  final AbstractEvaluator _evaluator;
  AttributesFacade(this._evaluator);

  Future<LocalAttributeDTO> createAttribute({
    required Map<String, dynamic> content,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.createAttribute(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'content': content,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final attribute = LocalAttributeDTO.fromJson(value);
    return attribute;
  }

  Future<LocalAttributeDTO> createSharedAttributeCopy({
    required String attributeId,
    required String peer,
    required String requestReference,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.createSharedAttributeCopy(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'attributeId': attributeId,
          'peer': peer,
          'requestReference': requestReference,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final attribute = LocalAttributeDTO.fromJson(value);
    return attribute;
  }

  Future<void> deleteAttribute({
    required String attributeId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.deleteAttribute(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': attributeId,
        },
      },
    );

    result.throwOnError();
  }

  Future<List<LocalAttributeDTO>> getPeerAttributes({
    required String peer,
    bool? onlyValid,
    bool? hideTechnical,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.getPeerAttributes(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'peer': peer,
          if (onlyValid != null) 'onlyValid': onlyValid,
          if (hideTechnical != null) 'hideTechnical': hideTechnical,
        },
      },
    );

    final value = result.toValue<List<dynamic>>();
    final attributes = value.map((e) => LocalAttributeDTO.fromJson(e)).toList();
    return attributes;
  }

  Future<List<LocalAttributeDTO>> getSharedToPeerAttributes({
    required String peer,
    bool? onlyValid,
    bool? hideTechnical,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.getSharedToPeerAttributes(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'peer': peer,
          if (onlyValid != null) 'onlyValid': onlyValid,
          if (hideTechnical != null) 'hideTechnical': hideTechnical,
        },
      },
    );

    final value = result.toValue<List<dynamic>>();
    final attributes = value.map((e) => LocalAttributeDTO.fromJson(e)).toList();
    return attributes;
  }

  Future<LocalAttributeDTO> getAttribute({
    required String attributeId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.getAttribute(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': attributeId,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final attribute = LocalAttributeDTO.fromJson(value);
    return attribute;
  }

  Future<List<LocalAttributeDTO>> getAttributes({
    bool? onlyValid,
    bool? hideTechnical,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.getAttributes(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          if (onlyValid != null) 'onlyValid': onlyValid,
          if (hideTechnical != null) 'hideTechnical': hideTechnical,
        },
      },
    );

    final value = result.toValue<List<dynamic>>();
    final attributes = value.map((e) => LocalAttributeDTO.fromJson(e)).toList();
    return attributes;
  }

  Future<List<LocalAttributeDTO>> executeIdentityAttributeQuery({
    required IdentityAttributeQuery query,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.executeIdentityAttributeQuery(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'query': query.toJson(),
        },
      },
    );

    final value = result.toValue<List<dynamic>>();
    final attributes = value.map((e) => LocalAttributeDTO.fromJson(e)).toList();
    return attributes;
  }

  Future<LocalAttributeDTO> executeRelationshipAttributeQuery({
    required RelationshipAttributeQuery query,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.executeRelationshipAttributeQuery(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'query': query.toJson(),
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final attribute = LocalAttributeDTO.fromJson(value);
    return attribute;
  }

  Future<List<LocalAttributeDTO>> executeThirdPartyRelationshipAttributeQuery({
    required ThirdPartyRelationshipAttributeQuery query,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.executeThirdPartyRelationshipAttributeQuery(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'query': query.toJson(),
        },
      },
    );

    final value = result.toValue<List<dynamic>>();
    final attributes = value.map((e) => LocalAttributeDTO.fromJson(e)).toList();
    return attributes;
  }

  Future<LocalAttributeDTO> succeedAttribute({
    required Map<String, dynamic> successorContent,
    required String succeeds,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.succeedAttribute(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'successorContent': successorContent,
          'succeeds': succeeds,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final attribute = LocalAttributeDTO.fromJson(value);
    return attribute;
  }

  Future<LocalAttributeDTO> updateAttribute({
    required String attributeId,
    required Map<String, dynamic> content,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.updateAttribute(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': attributeId,
          'content': content,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final attribute = LocalAttributeDTO.fromJson(value);
    return attribute;
  }

  Future<LocalRequestDTO> shareAttribute({
    required String attributeId,
    required String peer,
    String? requestTitle,
    String? requestDescription,
    Map<String, dynamic>? requestMetadata,
    String? requestItemTitle,
    String? requestItemDescription,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.consumptionServices.attributes.shareAttribute(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
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

    final value = result.toValue<Map<String, dynamic>>();
    final request = LocalRequestDTO.fromJson(value);
    return request;
  }
}
