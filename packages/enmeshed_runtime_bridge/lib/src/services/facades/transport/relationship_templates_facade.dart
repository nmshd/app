import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../result.dart';

class RelationshipTemplatesFacade {
  final AbstractEvaluator _evaluator;
  RelationshipTemplatesFacade(this._evaluator);

  Future<Result<RelationshipTemplateDTO>> createOwnRelationshipTemplate({
    required String expiresAt,
    required Map<String, dynamic> content,
    int? maxNumberOfAllocations,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'expiresAt': expiresAt,
          'content': content,
          if (maxNumberOfAllocations != null) 'maxNumberOfAllocations': maxNumberOfAllocations,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipTemplateDTO.fromJson(value));
  }

  Future<Result<RelationshipTemplateDTO>> loadPeerRelationshipTemplateByIdAndKey({
    required String relationshipTemplateId,
    required String secretKey,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationshipTemplates.loadPeerRelationshipTemplate(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': relationshipTemplateId,
          'secretKey': secretKey,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => RelationshipTemplateDTO.fromJson(value));
  }

  Future<Result<RelationshipTemplateDTO>> loadPeerRelationshipTemplateByReference({
    required String reference,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationshipTemplates.loadPeerRelationshipTemplate(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'reference': reference,
        },
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
        'request': {
          if (query != null) 'query': query.toJson(),
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<RelationshipTemplateDTO>.from(value.map((e) => RelationshipTemplateDTO.fromJson(e))));
  }

  Future<Result<RelationshipTemplateDTO>> getRelationshipTemplate({
    required String relationshipTemplateId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationshipTemplates.getRelationshipTemplate(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'id': relationshipTemplateId,
        },
      },
    );

    final value = result.valueToMap();
    return Result.fromJson(value, (x) => RelationshipTemplateDTO.fromJson(x));
  }

  Future<Result<CreateQRCodeResponse>> createQRCodeForOwnTemplate({
    required String templateId,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationshipTemplates.createQRCodeForOwnTemplate(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'templateId': templateId,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => CreateQRCodeResponse.fromJson(value));
  }

  Future<Result<CreateQRCodeResponse>> createTokenQRCodeForOwnTemplate({
    required String templateId,
    String? expiresAt,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationshipTemplates.createTokenQRCodeForOwnTemplate(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'templateId': templateId,
          if (expiresAt != null) 'expiresAt': expiresAt,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => CreateQRCodeResponse.fromJson(value));
  }

  Future<Result<TokenDTO>> createTokenForOwnTemplate({
    required String templateId,
    String? expiresAt,
    bool? ephemeral,
  }) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.relationshipTemplates.createTokenForOwnTemplate(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {
          'templateId': templateId,
          if (expiresAt != null) 'expiresAt': expiresAt,
          if (ephemeral != null) 'ephemeral': ephemeral,
        },
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => TokenDTO.fromJson(value));
  }
}
