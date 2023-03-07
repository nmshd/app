import 'package:enmeshed_types/enmeshed_types.dart';

import 'abstract_evaluator.dart';
import 'handle_call_async_js_result.dart';

class RelationshipTemplatesFacade {
  final AbstractEvaluator _evaluator;
  RelationshipTemplatesFacade(this._evaluator);

  Future<RelationshipTemplateDTO> createOwnRelationshipTemplate({
    required String expiresAt,
    required Map<String, dynamic> content,
    int? maxNumberOfAllocations,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationshipTemplates.createOwnRelationshipTemplate(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'expiresAt': expiresAt,
          'content': content,
          if (maxNumberOfAllocations != null) 'maxNumberOfAllocations': maxNumberOfAllocations,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final relationshipTemplate = RelationshipTemplateDTO.fromJson(value);
    return relationshipTemplate;
  }

  Future<RelationshipTemplateDTO> loadPeerRelationshipTemplateByIdAndKey({
    required String relationshipTemplateId,
    required String secretKey,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationshipTemplates.loadPeerRelationshipTemplate(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': relationshipTemplateId,
          'secretKey': secretKey,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final relationshipTemplate = RelationshipTemplateDTO.fromJson(value);
    return relationshipTemplate;
  }

  Future<RelationshipTemplateDTO> loadPeerRelationshipTemplateByReference({
    required String reference,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationshipTemplates.loadPeerRelationshipTemplate(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'reference': reference,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final relationshipTemplate = RelationshipTemplateDTO.fromJson(value);
    return relationshipTemplate;
  }

  Future<List<RelationshipTemplateDTO>> getRelationshipTemplates({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationshipTemplates.getRelationshipTemplates(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          if (query != null) 'query': query.toJson(),
        },
      },
    );

    final value = result.toValue<List<dynamic>>();
    final relationshipTemplates = value.map((e) => RelationshipTemplateDTO.fromJson(e)).toList();
    return relationshipTemplates;
  }

  Future<RelationshipTemplateDTO> getRelationshipTemplate({
    required String relationshipTemplateId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationshipTemplates.getRelationshipTemplate(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'id': relationshipTemplateId,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final relationshipTemplate = RelationshipTemplateDTO.fromJson(value);
    return relationshipTemplate;
  }

  Future<CreateQrCodeResponse> createQrCodeForOwnTemplate({
    required String templateId,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationshipTemplates.createQrCodeForOwnTemplate(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'templateId': templateId,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final response = CreateQrCodeResponse.fromJson(value);
    return response;
  }

  Future<CreateQrCodeResponse> createTokenQrCodeForOwnTemplate({
    required String templateId,
    String? expiresAt,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationshipTemplates.createTokenQrCodeForOwnTemplate(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'templateId': templateId,
          if (expiresAt != null) 'expiresAt': expiresAt,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final response = CreateQrCodeResponse.fromJson(value);
    return response;
  }

  Future<TokenDTO> createTokenForOwnTemplate({
    required String templateId,
    String? expiresAt,
    bool? ephemeral,
  }) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.transportServices.relationshipTemplates.createTokenForOwnTemplate(request)
      if (result.isError) throw new Error(result.error)
      return result.value''',
      arguments: {
        'request': {
          'templateId': templateId,
          if (expiresAt != null) 'expiresAt': expiresAt,
          if (ephemeral != null) 'ephemeral': ephemeral,
        },
      },
    );

    final value = result.toValue<Map<String, dynamic>>();
    final token = TokenDTO.fromJson(value);
    return token;
  }
}
