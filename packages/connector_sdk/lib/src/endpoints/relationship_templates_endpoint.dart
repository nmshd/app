import 'package:enmeshed_types/enmeshed_types.dart';

import 'endpoint.dart';
import 'transformers.dart';

class RelationshipTemplatesEndpoint extends Endpoint {
  RelationshipTemplatesEndpoint(super.dio);

  Future<ConnectorResponse<List<RelationshipTemplateDTO>>> getRelationshipTemplates([Map<String, dynamic>? query]) => get(
        '/api/v2/RelationshipTemplates',
        query: query,
        transformer: relationshipTemplateListTransformer,
      );

  Future<ConnectorResponse<RelationshipTemplateDTO>> getRelationshipTemplate(String id) => get(
        '/api/v2/RelationshipTemplates/$id',
        transformer: relationshipTemplateTransformer,
      );

  Future<ConnectorResponse<List<RelationshipTemplateDTO>>> getOwnRelationshipTemplates([Map<String, dynamic>? query]) => get(
        '/api/v2/RelationshipTemplates/Own',
        query: query,
        transformer: relationshipTemplateListTransformer,
      );

  Future<ConnectorResponse<RelationshipTemplateDTO>> createOwnRelationshipTemplate({
    int? maxNumberOfAllocations,
    required String expiresAt,
    required Map<String, dynamic> content,
  }) =>
      post(
        '/api/v2/RelationshipTemplates/Own',
        data: {
          if (maxNumberOfAllocations != null) 'maxNumberOfAllocations': maxNumberOfAllocations,
          'expiresAt': expiresAt,
          'content': content,
        },
        transformer: relationshipTemplateTransformer,
      );

  Future<ConnectorResponse<List<int>>> getQRCodeForOwnRelationshipTemplate(String id) => downloadQRCode('GET', '/api/v2/RelationshipTemplates/$id');

  Future<ConnectorResponse<TokenDTO>> createTokenForOwnRelationshipTemplate(
    String id, {
    String? expiresAt,
    bool? ephemeral,
    String? forIdentity,
  }) =>
      post(
        '/api/v2/RelationshipTemplates/Own/$id/Token',
        data: {
          if (expiresAt != null) 'expiresAt': expiresAt,
          if (ephemeral != null) 'ephemeral': ephemeral,
          if (forIdentity != null) 'forIdentity': forIdentity,
        },
        transformer: tokenTransformer,
      );

  Future<ConnectorResponse<List<int>>> createTokenQRCodeForOwnRelationshipTemplate(String id, {String? expiresAt, String? forIdentity}) =>
      downloadQRCode(
        'POST',
        '/api/v2/RelationshipTemplates/Own/$id/Token',
        request: {
          if (expiresAt != null) 'expiresAt': expiresAt,
          if (forIdentity != null) 'forIdentity': forIdentity,
        },
      );

  Future<ConnectorResponse<List<RelationshipTemplateDTO>>> getPeerRelationshipTemplates([Map<String, dynamic>? query]) => get(
        '/api/v2/RelationshipTemplates/Peer',
        query: query,
        transformer: relationshipTemplateListTransformer,
      );

  Future<ConnectorResponse<RelationshipTemplateDTO>> loadPeerRelationshipTemplate(String truncatedReference) => post(
        '/api/v2/RelationshipTemplates/Peer',
        data: {
          'reference': truncatedReference,
        },
        transformer: relationshipTemplateTransformer,
      );
}
