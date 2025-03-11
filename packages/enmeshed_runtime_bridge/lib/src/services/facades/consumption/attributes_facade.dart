import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class AttributesFacade {
  final AbstractEvaluator _evaluator;
  AttributesFacade(this._evaluator);

  Future<Result<CanCreateRepositoryAttributeResponse>> canCreateRepositoryAttribute({
    required IdentityAttributeValue value,
    List<String>? tags,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.canCreateRepositoryAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'content': {'value': value.toJson(), if (tags != null) 'tags': tags},
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => CanCreateRepositoryAttributeResponse.fromJson(value));
  }

  Future<Result<LocalAttributeDTO>> createRepositoryAttribute({required IdentityAttributeValue value, List<String>? tags}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.createRepositoryAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'content': {'value': value.toJson(), if (tags != null) 'tags': tags},
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

  Future<Result<List<LocalAttributeDTO>>> getRepositoryAttributes({bool? onlyLatestVersions, Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getRepositoryAttributes(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {if (onlyLatestVersions != null) 'onlyLatestVersions': onlyLatestVersions, if (query != null) 'query': query.toJson()},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<LocalAttributeDTO>> getAttribute({required String attributeId}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'id': attributeId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalAttributeDTO.fromJson(value));
  }

  Future<Result<List<LocalAttributeDTO>>> getAttributes({Map<String, QueryValue>? query, bool? onlyValid, bool? hideTechnical}) async {
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

  Future<Result<List<LocalAttributeDTO>>> getVersionsOfAttribute({required String attributeId}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getVersionsOfAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'attributeId': attributeId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<List<LocalAttributeDTO>>> getSharedVersionsOfAttribute({
    required String attributeId,
    List<String>? peers,
    bool? onlyLatestVersions,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.getSharedVersionsOfAttribute(request)
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

  Future<Result<List<LocalAttributeDTO>>> executeIdentityAttributeQuery({required IdentityAttributeQuery query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.executeIdentityAttributeQuery(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'query': query.toJson()},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<LocalAttributeDTO>> executeRelationshipAttributeQuery({required RelationshipAttributeQuery query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.executeRelationshipAttributeQuery(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'query': query.toJson()},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalAttributeDTO.fromJson(value));
  }

  Future<Result<List<LocalAttributeDTO>>> executeThirdPartyRelationshipAttributeQuery({required ThirdPartyRelationshipAttributeQuery query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.executeThirdPartyRelationshipAttributeQuery(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'query': query.toJson()},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<List<LocalAttributeDTO>>> executeIQLQuery({required IQLQuery query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.executeIQLQuery(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'query': query.toJson()},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }

  Future<Result<SucceedRepositoryAttributeResponse>> succeedRepositoryAttribute({
    required String predecessorId,
    required IdentityAttributeValue value,
    List<String>? tags,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.succeedRepositoryAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'predecessorId': predecessorId,
          'successorContent': {'value': value.toJson(), if (tags != null) 'tags': tags},
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => SucceedRepositoryAttributeResponse.fromJson(value));
  }

  Future<Result<LocalRequestDTO>> shareRepositoryAttribute({
    required String attributeId,
    required String peer,
    ({String? title, String? description, Map<String, dynamic>? metadata, String? expiresAt})? requestMetadata,
    ({String? title, String? description, Map<String, dynamic>? metadata, bool? requireManualDecision})? requestItemMetadata,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.shareRepositoryAttribute(request)
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
          if (requestItemMetadata != null)
            'requestItemMetadata': {
              if (requestItemMetadata.title != null) 'title': requestItemMetadata.title,
              if (requestItemMetadata.description != null) 'description': requestItemMetadata.description,
              if (requestItemMetadata.metadata != null) 'metadata': requestItemMetadata.metadata,
              if (requestItemMetadata.requireManualDecision != null) 'requireManualDecision': requestItemMetadata.requireManualDecision,
            },
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalRequestDTO.fromJson(value));
  }

  Future<Result<NotifyPeerAboutRepositoryAttributeSuccessionResponse>> notifyPeerAboutRepositoryAttributeSuccession({
    required String attributeId,
    required String peer,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.notifyPeerAboutRepositoryAttributeSuccession(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'attributeId': attributeId, 'peer': peer},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => NotifyPeerAboutRepositoryAttributeSuccessionResponse.fromJson(value));
  }

  Future<Result<LocalRequestDTO>> createAndShareRelationshipAttribute({
    required RelationshipAttributeValue value,
    required String key,
    required RelationshipAttributeConfidentiality confidentiality,
    bool? isTechnical,
    required String peer,
    ({String? title, String? description, Map<String, dynamic>? metadata, String? expiresAt})? requestMetadata,
    ({String? title, String? description, Map<String, dynamic>? metadata, bool? requireManualDecision})? requestItemMetadata,
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
          },
          'peer': peer,
          if (requestMetadata != null)
            'requestMetadata': {
              if (requestMetadata.title != null) 'title': requestMetadata.title,
              if (requestMetadata.description != null) 'description': requestMetadata.description,
              if (requestMetadata.metadata != null) 'metadata': requestMetadata.metadata,
              if (requestMetadata.expiresAt != null) 'expiresAt': requestMetadata.expiresAt,
            },
          if (requestItemMetadata != null)
            'requestItemMetadata': {
              if (requestItemMetadata.title != null) 'title': requestItemMetadata.title,
              if (requestItemMetadata.description != null) 'description': requestItemMetadata.description,
              if (requestItemMetadata.metadata != null) 'metadata': requestItemMetadata.metadata,
              if (requestItemMetadata.requireManualDecision != null) 'requireManualDecision': requestItemMetadata.requireManualDecision,
            },
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalRequestDTO.fromJson(value));
  }

  Future<Result<SucceedRelationshipAttributeAndNotifyPeerResponse>> succeedRelationshipAttributeAndNotifyPeer({
    required String predecessorId,
    required RelationshipAttributeValue value,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.succeedRelationshipAttributeAndNotifyPeer(request)
  if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
  return { value: result.value }''',
      arguments: {
        'request': {
          'predecessorId': predecessorId,
          'successorContent': {'value': value.toJson()},
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => SucceedRelationshipAttributeAndNotifyPeerResponse.fromJson(value));
  }

  Future<Result<LocalAttributeDTO>> changeDefaultRepositoryAttribute({required String attributeId}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.changeDefaultRepositoryAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'attributeId': attributeId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => LocalAttributeDTO.fromJson(value));
  }

  Future<Result<DeleteOwnSharedAttributeAndNotifyPeerResponse>> deleteOwnSharedAttributeAndNotifyPeer({required String attributeId}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.deleteOwnSharedAttributeAndNotifyPeer(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'attributeId': attributeId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => DeleteOwnSharedAttributeAndNotifyPeerResponse.fromJson(value));
  }

  Future<Result<DeletePeerSharedAttributeAndNotifyOwnerResponse>> deletePeerSharedAttributeAndNotifyOwner({required String attributeId}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.deletePeerSharedAttributeAndNotifyOwner(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'attributeId': attributeId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => DeletePeerSharedAttributeAndNotifyOwnerResponse.fromJson(value));
  }

  Future<Result<DeleteThirdPartyRelationshipAttributeAndNotifyPeerResponse>> deleteThirdPartyRelationshipAttributeAndNotifyPeer({
    required String attributeId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.deleteThirdPartyRelationshipAttributeAndNotifyPeer(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'attributeId': attributeId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => DeleteThirdPartyRelationshipAttributeAndNotifyPeerResponse.fromJson(value));
  }

  Future<VoidResult> deleteRepositoryAttribute({required String attributeId}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.consumptionServices.attributes.deleteRepositoryAttribute(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'attributeId': attributeId},
      },
    );

    return VoidResult.fromJson(result.valueToMap());
  }

  Future<Result<AttributeTagCollectionDTO>> getAttributeTagCollection() async {
    final result = await _evaluator.evaluateJavaScript('''const result = await session.consumptionServices.attributes.getAttributeTagCollection()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''');

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => AttributeTagCollectionDTO.fromJson(value));
  }
}
