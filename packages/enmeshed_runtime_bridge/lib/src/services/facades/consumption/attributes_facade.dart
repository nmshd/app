import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../result.dart';

class AttributesFacade {
  final AbstractEvaluator _evaluator;
  AttributesFacade(this._evaluator);

  Future<Result<LocalAttributeDTO>> createIdentityAttribute({
    required IdentityAttributeValue value,
    List<String>? tags,
    String? validFrom,
    String? validTo,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.createIdentityAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'content': {
            'value': value.toJson(),
            if (tags != null) 'tags': tags,
            if (validFrom != null) 'validFrom': validFrom,
            if (validTo != null) 'validTo': validTo,
          },
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalAttributeDTO.fromJson(value));
  }

  Future<Result<List<LocalAttributeDTO>>> getPeerSharedAttributes({
    required String peer,
    Map<String, QueryValue>? query,
    bool? onlyValid,
    bool? hideTechnical,
    bool? onlyLatestVersions,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getPeerSharedAttributes(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'peer': peer,
          if (onlyValid != null) 'onlyValid': onlyValid,
          if (hideTechnical != null) 'hideTechnical': hideTechnical,
          if (query != null) 'query': query.toJson(),
          if (onlyLatestVersions != null) 'onlyLatestVersions': onlyLatestVersions,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<List<LocalAttributeDTO>>> getOwnSharedAttributes({
    required String peer,
    Map<String, QueryValue>? query,
    bool? onlyValid,
    bool? hideTechnical,
    bool? onlyLatestVersions,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getOwnSharedAttributes(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'peer': peer,
          if (onlyValid != null) 'onlyValid': onlyValid,
          if (hideTechnical != null) 'hideTechnical': hideTechnical,
          if (query != null) 'query': query.toJson(),
          if (onlyLatestVersions != null) 'onlyLatestVersions': onlyLatestVersions,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<List<LocalAccountDTO>>> getOwnIdentityAttributes({
    bool? onlyLatestVersions,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getOwnIdentityAttributes(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          if (onlyLatestVersions != null) 'onlyLatestVersions': onlyLatestVersions,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAccountDTO>.from(value.map((e) => LocalAccountDTO.fromJson(e))));
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

  Future<Result<List<LocalAttributeDTO>>> getVersionsOfAttribute({
    required String attributeId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getVersionsOfAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'attributeId': attributeId,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<List<LocalAttributeDTO>>> getSharedVersionsOfIdentityAttribute({
    required String attributeId,
    List<String>? peers,
    bool? onlyLatestVersions,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getSharedVersionsOfIdentityAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'attributeId': attributeId,
          if (peers != null) 'peers': peers,
          if (onlyLatestVersions != null) 'onlyLatestVersions': onlyLatestVersions,
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

  Future<Result<SucceedRelationshipAttributeAndNotifyPeerResponse>> succeedRelationshipAttributeAndNotifyPeer({
    required String predecessorId,
    required RelationshipAttributeValue value,
    String? validFrom,
    String? validTo,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.succeedRelationshipAttributeAndNotifyPeer(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'predecessorId': predecessorId,
          'successorContent': {
            'value': value.toJson(),
            if (validFrom != null) 'validFrom': validFrom,
            if (validTo != null) 'validTo': validTo,
          }
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => SucceedRelationshipAttributeAndNotifyPeerResponse.fromJson(value));
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

  Future<Result<SucceedIdentityAttributeResponse>> succeedIdentityAttribute({
    required String predecessorId,
    required IdentityAttributeValue value,
    List<String>? tags,
    String? validFrom,
    String? validTo,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.succeedIdentityAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'predecessorId': predecessorId,
          'successorContent': {
            'value': value.toJson(),
            if (tags != null) 'tags': tags,
            if (validFrom != null) 'validFrom': validFrom,
            if (validTo != null) 'validTo': validTo,
          }
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => SucceedIdentityAttributeResponse.fromJson(value));
  }

  Future<Result<LocalRequestDTO>> shareIdentityAttribute({
    required String attributeId,
    required String peer,
    ({String? title, String? description, Map<String, dynamic>? metadata, String? expiresAt})? requestMetadata,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.shareIdentityAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'attributeId': attributeId,
          'peer': peer,
          if (requestMetadata != null)
            'requestMetadata': {
              if (requestMetadata.title != null) 'title': requestMetadata.title,
              if (requestMetadata.description != null) 'description': requestMetadata.description,
              if (requestMetadata.metadata != null) 'metadata': requestMetadata.metadata,
              if (requestMetadata.expiresAt != null) 'expiresAt': requestMetadata.expiresAt,
            },
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalRequestDTO.fromJson(value));
  }

  Future<Result<LocalRequestDTO>> createAndShareRelationshipAttribute({
    required RelationshipAttributeValue value,
    required String key,
    required RelationshipAttributeConfidentiality confidentiality,
    bool? isTechnical,
    String? validFrom,
    String? validTo,
    required String peer,
    ({String? title, String? description, Map<String, dynamic>? metadata, String? expiresAt})? requestMetadata,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.createAndShareRelationshipAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'content': {
            'value': value.toJson(),
            'key': key,
            'confidentiality': confidentiality.name,
            if (isTechnical != null) 'isTechnical': isTechnical,
            if (validFrom != null) 'validFrom': validFrom,
            if (validTo != null) 'validTo': validTo,
          },
          'peer': peer,
          if (requestMetadata != null)
            'requestMetadata': {
              if (requestMetadata.title != null) 'title': requestMetadata.title,
              if (requestMetadata.description != null) 'description': requestMetadata.description,
              if (requestMetadata.metadata != null) 'metadata': requestMetadata.metadata,
              if (requestMetadata.expiresAt != null) 'expiresAt': requestMetadata.expiresAt,
            },
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalRequestDTO.fromJson(value));
  }

  Future<Result<NotifyPeerAboutIdentityAttributeSuccessionResponse>> notifyPeerAboutIdentityAttributeSuccession({
    required String attributeId,
    required String peer,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.notifyPeerAboutIdentityAttributeSuccession(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'attributeId': attributeId,
          'peer': peer,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => NotifyPeerAboutIdentityAttributeSuccessionResponse.fromJson(value));
  }
}
