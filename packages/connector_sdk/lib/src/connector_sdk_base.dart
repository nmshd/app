import 'package:dio/dio.dart';

import 'endpoints/endpoints.dart';

class ConnectorClient {
  final String baseUrl;

  late final AccountEndpoint account;
  late final AttributesEndpoint attributes;
  late final ChallengesEndpoint challenges;
  late final FilesEndpoint files;
  late final IncomingRequestsEndpoint incomingRequests;
  late final MessagesEndpoint messages;
  late final MonitoringEndpoint monitoring;
  late final OutgoingRequestsEndpoint outgoingRequests;
  late final RelationshipTemplatesEndpoint relationshipTemplates;
  late final RelationshipsEndpoint relationships;
  late final TokensEndpoint tokens;

  ConnectorClient(this.baseUrl, String apiKey) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {'X-API-KEY': apiKey}, validateStatus: (_) => true));

    account = AccountEndpoint(dio);
    attributes = AttributesEndpoint(dio);
    challenges = ChallengesEndpoint(dio);
    files = FilesEndpoint(dio);
    incomingRequests = IncomingRequestsEndpoint(dio);
    messages = MessagesEndpoint(dio);
    monitoring = MonitoringEndpoint(dio);
    outgoingRequests = OutgoingRequestsEndpoint(dio);
    relationshipTemplates = RelationshipTemplatesEndpoint(dio);
    relationships = RelationshipsEndpoint(dio);
    tokens = TokensEndpoint(dio);
  }
}
