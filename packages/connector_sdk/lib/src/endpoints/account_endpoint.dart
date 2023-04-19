import 'package:enmeshed_types/enmeshed_types.dart';

import 'endpoint.dart';

class AccountEndpoint extends Endpoint {
  AccountEndpoint(super.dio);

  Future<ConnectorResponse<GetIdentityInfoResponse>> getIdentityInfo() => get(
        '/api/v2/Account/IdentityInfo',
        transformer: (v) => GetIdentityInfoResponse.fromJson(v),
      );

  Future<ConnectorResponse<SyncEverythingResponse>> sync() => post(
        '/api/v2/Account/Sync',
        transformer: (v) => SyncEverythingResponse.fromJson(v),
        expectedStatus: 200,
      );

  Future<ConnectorResponse<SyncInfoResponse>> getSyncInfo() => get('/api/v2/Account/SyncInfo', transformer: (v) => SyncInfoResponse.fromJson(v));
}
