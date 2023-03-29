import 'package:dio/dio.dart';

import 'endpoints/endpoints.dart';

class ConnectorClient {
  final Dio _dio;

  late final AccountEndpoint account;
  late final AttributesEndpoint attributes;
  late final ChallengesEndpoint challenges;

  late final FilesEndpoint files;

  ConnectorClient(String baseUrl, String apiKey)
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {'X-API-KEY': apiKey},
          validateStatus: (_) => true,
        )) {
    files = FilesEndpoint(_dio);
  }
}
