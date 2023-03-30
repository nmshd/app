import 'endpoint.dart';

class MonitoringEndpoint extends Endpoint {
  MonitoringEndpoint(super.dio);

  Future<Map<String, dynamic>> getHealth() => getPlain<Map<String, dynamic>>('/health');

  Future<Map<String, dynamic>> getVersion() => getPlain<Map<String, dynamic>>('/Monitoring/Version');

  Future<Map<String, dynamic>> getRequests() => getPlain<Map<String, dynamic>>('/Monitoring/Requests');

  Future<Map<String, dynamic>> getSupport() => getPlain<Map<String, dynamic>>('/Monitoring/Support');
}
