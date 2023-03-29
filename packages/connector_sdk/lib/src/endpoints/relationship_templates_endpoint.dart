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
          'maxNumberOfAllocations': maxNumberOfAllocations,
          'expiresAt': expiresAt,
          'content': content,
        },
        transformer: relationshipTemplateTransformer,
      );

  Future<ConnectorResponse<List<int>>> getQrCodeForOwnRelationshipTemplate(String id) => downloadQrCode('GET', '/api/v2/RelationshipTemplates/$id');

  Future<ConnectorResponse<TokenDTO>> createTokenForOwnRelationshipTemplate(String id, {String? expiresAt, bool? ephemeral}) => post(
        '/api/v2/RelationshipTemplates/Own/$id/Token',
        data: {
          'expiresAt': expiresAt,
          'ephemeral': ephemeral,
        },
        transformer: tokenTransformer,
      );

  Future<ConnectorResponse<List<int>>> createTokenQrCodeForOwnRelationshipTemplate(String id, {String? expiresAt, bool? ephemeral}) => downloadQrCode(
        'POST',
        '/api/v2/RelationshipTemplates/Own/$id/Token',
        request: {
          'expiresAt': expiresAt,
          'ephemeral': ephemeral,
        },
      );

  Future<ConnectorResponse<List<RelationshipTemplateDTO>>> getPeerRelationshipTemplates([Map<String, dynamic>? query]) => get(
        '/api/v2/RelationshipTemplates/Peer',
        query: query,
        transformer: relationshipTemplateListTransformer,
      );

  Future<ConnectorResponse<RelationshipTemplateDTO>> loadPeerRelationshipTemplateByTruncatedReference(String truncatedReference) => post(
        '/api/v2/RelationshipTemplates/Peer',
        data: {
          'reference': truncatedReference,
        },
        transformer: relationshipTemplateTransformer,
      );

  Future<ConnectorResponse<RelationshipTemplateDTO>> loadPeerRelationshipTemplateByIdAndKey({required String id, required String secretKey}) => post(
        '/api/v2/RelationshipTemplates/Peer',
        data: {
          'id': id,
          'key': secretKey,
        },
        transformer: relationshipTemplateTransformer,
      );
}
