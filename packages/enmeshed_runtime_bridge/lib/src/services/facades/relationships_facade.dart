import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';

class RelationshipsFacade {
  final AbstractEvaluator _evaluator;
  RelationshipsFacade(this._evaluator);

  Future<List<RelationshipDTO>> getRelationships({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationships.getRelationships(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          if (query != null) 'query': query.toJson(),
        },
      },
    );

    final value = result.valueToList();
    final relationships = value.map((e) => RelationshipDTO.fromJson(e)).toList();
    return relationships;
  }

  Future<RelationshipDTO> getRelationship({
    required String relationshipId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationships.getRelationship(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': relationshipId,
        },
      },
    );

    final value = result.valueToMap();
    final relationship = RelationshipDTO.fromJson(value);
    return relationship;
  }

  Future<RelationshipDTO> getRelationshipByAddress({
    required String address,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationships.getRelationshipByAddress(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'address': address,
        },
      },
    );

    final value = result.valueToMap();
    final relationship = RelationshipDTO.fromJson(value);
    return relationship;
  }

  Future<RelationshipDTO> createRelationship({
    required String templateId,
    required Map<String, dynamic> content,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationships.createRelationship(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'templateId': templateId,
          'content': content,
        },
      },
    );

    final value = result.valueToMap();
    final relationship = RelationshipDTO.fromJson(value);
    return relationship;
  }

  Future<RelationshipDTO> acceptRelationshipChange({
    required String relationshipId,
    required String changeId,
    required Map<String, dynamic> content,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationships.acceptRelationshipChange(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'relationshipId': relationshipId,
          'changeId': changeId,
          'content': content,
        },
      },
    );

    final value = result.valueToMap();
    final relationship = RelationshipDTO.fromJson(value);
    return relationship;
  }

  Future<RelationshipDTO> rejectRelationshipChange({
    required String relationshipId,
    required String changeId,
    required Map<String, dynamic> content,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationships.rejectRelationshipChange(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'relationshipId': relationshipId,
          'changeId': changeId,
          'content': content,
        },
      },
    );

    final value = result.valueToMap();
    final relationship = RelationshipDTO.fromJson(value);
    return relationship;
  }

  Future<List<LocalAttributeDTO>> getAttributesForRelationship({
    required String relationshipId,
    bool? hideTechnical,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationships.getAttributesForRelationship(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': relationshipId,
          if (hideTechnical != null) 'hideTechnical': hideTechnical,
        },
      },
    );

    final value = result.valueToList();
    final attributes = value.map((e) => LocalAttributeDTO.fromJson(e)).toList();
    return attributes;
  }
}
