import 'package:enmeshed_types/enmeshed_types.dart';

import 'endpoint.dart';
import 'transformers.dart';

class RelationshipsEndpoint extends Endpoint {
  RelationshipsEndpoint(super.dio);

  Future<ConnectorResponse<RelationshipDTO>> createRelationship({required String templateId, required Map<String, dynamic> content}) => post(
        '/api/v2/Relationships',
        data: {
          'templateId': templateId,
          'content': content,
        },
        transformer: relationshipTransformer,
      );

  Future<ConnectorResponse<List<RelationshipDTO>>> getRelationships([Map<String, dynamic>? query]) => get(
        '/api/v2/Relationships',
        query: query,
        transformer: relationshipListTransformer,
      );

  Future<ConnectorResponse<RelationshipDTO>> getRelationship(String relationshipId) => get(
        '/api/v2/Relationships/$relationshipId',
        transformer: relationshipTransformer,
      );
  Future<ConnectorResponse<RelationshipDTO>> acceptRelationshipChange({
    required String relationshipId,
    required String changeId,
    required Map<String, dynamic> content,
  }) =>
      put(
        '/api/v2/Relationships/$relationshipId/Changes/$changeId/Accept',
        data: {'content': content},
        transformer: relationshipTransformer,
      );

  Future<ConnectorResponse<RelationshipDTO>> rejectRelationshipChange({
    required String relationshipId,
    required String changeId,
    required Map<String, dynamic> content,
  }) =>
      put(
        '/api/v2/Relationships/$relationshipId/Changes/$changeId/Reject',
        data: {'content': content},
        transformer: relationshipTransformer,
      );

  Future<ConnectorResponse<List<LocalAttributeDTO>>> getAttributesForRelationship(String relationshipId) => get(
        '/api/v2/Relationships/$relationshipId/Attributes',
        transformer: localAttributeListTransformer,
      );
}
