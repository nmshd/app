import 'package:enmeshed_types/enmeshed_types.dart';

import 'endpoint.dart';
import 'transformers.dart';

class OutgoingRequestsEndpoint extends Endpoint {
  OutgoingRequestsEndpoint(super.dio);

  Future<ConnectorResponse<RequestValidationResultDTO>> canCreateRequest({required Request content, String? peer}) =>
      post<RequestValidationResultDTO>(
        '/api/v2/Requests/Outgoing/Validate',
        transformer: requestValidationResultTransformer,
        data: {
          'content': content.toJson(),
          'peer': peer,
        },
      );

  Future<ConnectorResponse<LocalRequestDTO>> createRequest({required Request content, required String peer}) => post<LocalRequestDTO>(
        '/api/v2/Requests/Outgoing',
        transformer: localRequestTransformer,
        data: {
          'content': content.toJson(),
          'peer': peer,
        },
      );

  Future<ConnectorResponse<LocalRequestDTO>> getRequest(String requestId) => get<LocalRequestDTO>(
        '/api/v2/Requests/Outgoing/$requestId',
        transformer: localRequestTransformer,
      );

  Future<ConnectorResponse<List<LocalRequestDTO>>> getRequests([Map<String, dynamic>? query]) => get<List<LocalRequestDTO>>(
        '/api/v2/Requests/Outgoing',
        transformer: localRequestListTransformer,
        query: query,
      );
}
