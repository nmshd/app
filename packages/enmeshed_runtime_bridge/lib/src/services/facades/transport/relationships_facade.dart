import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class RelationshipsFacade {
  final AbstractEvaluator _evaluator;
  RelationshipsFacade(this._evaluator);

  Future<Result<List<RelationshipDTO>>> getRelationships({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.getRelationships(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          if (query != null) 'query': query.toJson(),
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<RelationshipDTO>.from(value.map((e) => RelationshipDTO.fromJson(e))));
  }

  Future<Result<RelationshipDTO>> getRelationship({
    required String relationshipId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.getRelationship(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': relationshipId,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipDTO.fromJson(value));
  }

  Future<Result<RelationshipDTO>> getRelationshipByAddress({
    required String address,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.getRelationshipByAddress(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'address': address,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipDTO.fromJson(value));
  }

  Future<Result<RelationshipDTO>> createRelationship({
    required String templateId,
    required Map<String, dynamic> creationContent,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.createRelationship(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'templateId': templateId,
          'creationContent': creationContent,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipDTO.fromJson(value));
  }

  Future<Result<RelationshipDTO>> acceptRelationship({required String relationshipId}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.acceptRelationshipChange(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'relationshipId': relationshipId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipDTO.fromJson(value));
  }

  Future<Result<RelationshipDTO>> rejectRelationship({
    required String relationshipId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.rejectRelationship(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'relationshipId': relationshipId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipDTO.fromJson(value));
  }

  Future<Result<RelationshipDTO>> revokeRelationship({
    required String relationshipId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.revokeRelationship(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'relationshipId': relationshipId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipDTO.fromJson(value));
  }

  Future<Result<RelationshipDTO>> terminateRelationship({
    required String relationshipId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.terminateRelationship(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'relationshipId': relationshipId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipDTO.fromJson(value));
  }

  Future<Result<RelationshipDTO>> requestRelationshipReactivation({
    required String relationshipId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.requestRelationshipReactivation(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'relationshipId': relationshipId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipDTO.fromJson(value));
  }

  Future<Result<RelationshipDTO>> acceptRelationshipReactivation({
    required String relationshipId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.acceptRelationshipReactivation(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'relationshipId': relationshipId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipDTO.fromJson(value));
  }

  Future<Result<RelationshipDTO>> rejectRelationshipReactivation({
    required String relationshipId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.rejectRelationshipReactivation(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'relationshipId': relationshipId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipDTO.fromJson(value));
  }

  Future<Result<RelationshipDTO>> revokeRelationshipReactivation({
    required String relationshipId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.rejectRelationshipReactivation(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'relationshipId': relationshipId},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipDTO.fromJson(value));
  }

  Future<Result<List<LocalAttributeDTO>>> getAttributesForRelationship({
    required String relationshipId,
    bool? hideTechnical,
    bool? onlyLatestVersions,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationships.getAttributesForRelationship(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': relationshipId,
          if (hideTechnical != null) 'hideTechnical': hideTechnical,
          if (onlyLatestVersions != null) 'onlyLatestVersions': onlyLatestVersions,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<LocalAttributeDTO>.from(value.map((e) => LocalAttributeDTO.fromJson(e))));
  }
}
