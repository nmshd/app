import 'package:enmeshed_types/enmeshed_types.dart';

import 'endpoint.dart';
import 'transformers.dart';

class IncomingRequestsEndpoint extends Endpoint {
  IncomingRequestsEndpoint(super.dio);

  Future<ConnectorResponse<RequestValidationResultDTO>> canAccept(String requestId, List<DecideRequestParametersItem> items) => put(
        '/api/v2/Requests/Incoming/$requestId/CanAccept',
        data: {'items': items.map((e) => e.toJson()).toList()},
        transformer: requestValidationResultTransformer,
      );

  Future<ConnectorResponse<LocalRequestDTO>> accept(String requestId, List<DecideRequestParametersItem> items) => put(
        '/api/v2/Requests/Incoming/$requestId/Accept',
        data: {'items': items.map((e) => e.toJson()).toList()},
        transformer: localRequestTransformer,
      );

  Future<ConnectorResponse<RequestValidationResultDTO>> canReject(String requestId, List<DecideRequestParametersItem> items) => put(
        '/api/v2/Requests/Incoming/$requestId/CanReject',
        data: {'items': items.map((e) => e.toJson()).toList()},
        transformer: requestValidationResultTransformer,
      );

  Future<ConnectorResponse<LocalRequestDTO>> reject(String requestId, List<DecideRequestParametersItem> items) => put(
        '/api/v2/Requests/Incoming/$requestId/Reject',
        data: {'items': items.map((e) => e.toJson()).toList()},
        transformer: localRequestTransformer,
      );

  Future<ConnectorResponse<LocalRequestDTO>> getRequest(String requestId) => get(
        '/api/v2/Requests/Incoming/$requestId',
        transformer: localRequestTransformer,
      );

  Future<ConnectorResponse<List<LocalRequestDTO>>> getRequests([Map<String, dynamic>? query]) => get(
        '/api/v2/Requests/Incoming',
        transformer: localRequestListTransformer,
        query: query,
      );
}
