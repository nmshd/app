import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class RelationshipTemplatesFacade {
  final AbstractEvaluator _evaluator;
  RelationshipTemplatesFacade(this._evaluator);

  Future<Result<RelationshipTemplateDTO>> createOwnRelationshipTemplate({
    required String expiresAt,
    required RelationshipTemplateContentDerivation content,
    int? maxNumberOfAllocations,
    String? forIdentity,
    PasswordProtection? passwordProtection,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'expiresAt': expiresAt,
          'content': content.toJson(),
          'maxNumberOfAllocations': ?maxNumberOfAllocations,
          'forIdentity': ?forIdentity,
          if (passwordProtection != null) 'passwordProtection': passwordProtection.toJson(),
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipTemplateDTO.fromJson(value));
  }

  Future<Result<RelationshipTemplateDTO>> loadPeerRelationshipTemplate({required String reference, String? password}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationshipTemplates.loadPeerRelationshipTemplate(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'reference': reference, 'password': ?password},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipTemplateDTO.fromJson(value));
  }

  Future<Result<List<RelationshipTemplateDTO>>> getRelationshipTemplates({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationshipTemplates.getRelationshipTemplates(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {if (query != null) 'query': query.toJson()},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<RelationshipTemplateDTO>.from(value.map((e) => RelationshipTemplateDTO.fromJson(e))));
  }

  Future<Result<RelationshipTemplateDTO>> getRelationshipTemplate({required String relationshipTemplateId}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationshipTemplates.getRelationshipTemplate(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {'id': relationshipTemplateId},
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => RelationshipTemplateDTO.fromJson(x));
  }

  Future<Result<TokenDTO>> createTokenForOwnRelationshipTemplate({
    required String templateId,
    String? expiresAt,
    bool? ephemeral,
    String? forIdentity,
    PasswordProtection? passwordProtection,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationshipTemplates.createTokenForOwnRelationshipTemplate(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'templateId': templateId,
          'expiresAt': ?expiresAt,
          'ephemeral': ?ephemeral,
          'forIdentity': ?forIdentity,
          if (passwordProtection != null) 'passwordProtection': passwordProtection.toJson(),
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => TokenDTO.fromJson(value));
  }
}
