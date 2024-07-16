import 'package:enmeshed_types/enmeshed_types.dart';

import 'endpoint.dart';
import 'transformers.dart';

class RelationshipsEndpoint extends Endpoint {
  RelationshipsEndpoint(super.dio);

  Future<ConnectorResponse<RelationshipDTO>> createRelationship({required String templateId, required Map<String, dynamic> creationContent}) => post(
        '/api/v2/Relationships',
        data: {
          'templateId': templateId,
          'content': creationContent,
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

  Future<ConnectorResponse<RelationshipDTO>> acceptRelationship(String relationshipId) => put(
        '/api/v2/Relationships/$relationshipId/Accept',
        transformer: relationshipTransformer,
      );

  Future<ConnectorResponse<RelationshipDTO>> rejectRelationship(String relationshipId) => put(
        '/api/v2/Relationships/$relationshipId/Reject',
        transformer: relationshipTransformer,
      );

  Future<ConnectorResponse<RelationshipDTO>> revokeRelationship(String relationshipId) => put(
        '/api/v2/Relationships/$relationshipId/Revoke',
        transformer: relationshipTransformer,
      );

  Future<ConnectorResponse<RelationshipDTO>> requestRelationshipReactivation(String relationshipId) => put(
        '/api/v2/Relationships/$relationshipId/Reactivate',
        transformer: relationshipTransformer,
      );

  Future<ConnectorResponse<RelationshipDTO>> acceptRelationshipReactivation(String relationshipId) => put(
        '/api/v2/Relationships/$relationshipId/Reactivate/Accept',
        transformer: relationshipTransformer,
      );

  Future<ConnectorResponse<RelationshipDTO>> rejectRelationshipReactivation(String relationshipId) => put(
        '/api/v2/Relationships/$relationshipId/Reactivate/Reject',
        transformer: relationshipTransformer,
      );

  Future<ConnectorResponse<RelationshipDTO>> revokeRelationshipReactivation(String relationshipId) => put(
        '/api/v2/Relationships/$relationshipId/Reactivate/Revoke',
        transformer: relationshipTransformer,
      );

  Future<ConnectorResponse<void>> decomposeRelationship(String relationshipId) => put(
        '/api/v2/Relationships/$relationshipId/Decompose',
        transformer: (v) => v,
      );

  Future<ConnectorResponse<List<LocalAttributeDTO>>> getAttributesForRelationship(String relationshipId) => get(
        '/api/v2/Relationships/$relationshipId/Attributes',
        transformer: localAttributeListTransformer,
      );
}
