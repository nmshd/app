import 'package:enmeshed_types/enmeshed_types.dart';

import 'endpoint.dart';
import 'transformers.dart';

class AttributesEndpoint extends Endpoint {
  AttributesEndpoint(super.dio);

  Future<ConnectorResponse<LocalAttributeDTO>> createAttribute(AbstractAttribute attribute) =>
      post('/api/v2/Attributes', data: {'content': attribute.toJson()}, transformer: localAttributeTransformer);

  Future<ConnectorResponse<List<LocalAttributeDTO>>> getAttributes([Map<String, dynamic>? query]) =>
      get('/api/v2/Attributes', transformer: localAttributeListTransformer, query: query);

  Future<ConnectorResponse<LocalAttributeDTO>> getAttribute(String attributeId) =>
      get('/api/v2/Attributes/$attributeId', transformer: localAttributeTransformer);

  Future<ConnectorResponse<List<LocalAttributeDTO>>> getValidAttributes([Map<String, dynamic>? query]) =>
      get('/api/v2/Attributes/Valid', transformer: localAttributeListTransformer, query: query);

  Future<ConnectorResponse<List<LocalAttributeDTO>>> executeIdentityAttributeQuery(IdentityAttributeQuery query) =>
      post('/api/v2/Attributes/ExecuteIdentityAttributeQuery', data: {'query': query.toJson()}, transformer: localAttributeListTransformer);

  Future<ConnectorResponse<LocalAttributeDTO>> executeRelationshipAttributeQuery(RelationshipAttributeQuery query) =>
      post('/api/v2/Attributes/ExecuteRelationshipAttributeQuery', data: {'query': query.toJson()}, transformer: localAttributeTransformer);

  Future<ConnectorResponse<List<LocalAttributeDTO>>> executeThirdPartyAttributeQuery(ThirdPartyRelationshipAttributeQuery query) =>
      post('/api/v2/Attributes/ExecuteThirdPartyAttributeQuery', data: {'query': query.toJson()}, transformer: localAttributeListTransformer);
}
