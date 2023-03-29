import 'dart:convert';

import 'package:dio/dio.dart';

class ConnectorError {
  final String id;
  final String docs;
  final String time;
  final String code;
  final String message;

  ConnectorError({
    required this.id,
    required this.docs,
    required this.time,
    required this.code,
    required this.message,
  });
}

class ConnectorResponse<T> {
  final T? _data;
  final ConnectorError? _error;

  T get data {
    if (_data == null) {
      throw Exception('${error.code}: ${error.message}');
    }

    return _data!;
  }

  ConnectorError get error {
    if (_error == null) {
      throw Exception('No error');
    }

    return _error!;
  }

  ConnectorResponse._(this._data, this._error);

  static ConnectorResponse<T> success<T>(T data) {
    return ConnectorResponse._(data, null);
  }

  static ConnectorResponse<T> fromError<T>({
    required String id,
    required String docs,
    required String time,
    required String code,
    required String message,
  }) {
    return ConnectorResponse._(
      null,
      ConnectorError(
        id: id,
        docs: docs,
        time: time,
        code: code,
        message: message,
      ),
    );
  }

  bool get hasError => _error != null;
  bool get hasData => _data != null;
}

abstract class Endpoint {
  final Dio _dio;

  Dio get httpClient => _dio;

  Endpoint(this._dio);

  Future<T> getPlain<T>(String path) async {
    final response = await httpClient.get<T>(path);
    if (response.data == null) {
      throw Exception('Invalid response type');
    }

    return response.data!;
  }

  Future<ConnectorResponse<T>> get<T>(String path, {required T Function(dynamic) transformer, Map<String, dynamic>? query}) async {
    final response = await httpClient.get<Map<String, dynamic>>(path, queryParameters: query);
    return makeResult(response, transformer);
  }

  Future<ConnectorResponse<T>> post<T>(
    String path, {
    required T Function(dynamic) transformer,
    Object? data,
    int? expectedStatus,
    Map<String, dynamic>? params,
  }) async {
    final response = await httpClient.post<Map<String, dynamic>>(path, data: data, queryParameters: params);
    return makeResult(response, transformer, expectedStatus: expectedStatus);
  }

  Future<ConnectorResponse<T>> put<T>(String path, {required T Function(dynamic) transformer, Object? data}) async {
    final response = await httpClient.put<Map<String, dynamic>>(path, data: data);
    return makeResult(response, transformer);
  }

  ConnectorResponse<T> makeResult<T>(Response<Map<String, dynamic>> httpResponse, T Function(dynamic) transformer, {int? expectedStatus}) {
    if (expectedStatus == null) {
      switch (httpResponse.requestOptions.method.toUpperCase()) {
        case 'POST':
          expectedStatus = 201;
          break;
        default:
          expectedStatus = 200;
          break;
      }
    }

    final payload = httpResponse.data;
    if (payload == null) {
      throw Exception('Invalid response type');
    }

    if (httpResponse.statusCode != expectedStatus) {
      final errorPayload = payload['error'];

      return ConnectorResponse.fromError(
        id: errorPayload['id'],
        docs: errorPayload['docs'],
        time: errorPayload['time'],
        code: errorPayload['code'],
        message: errorPayload['message'],
      );
    }

    return ConnectorResponse.success(transformer(payload['result']));
  }

  Future<ConnectorResponse<List<int>>> download(String url) async {
    final httpResponse = await httpClient.get<List<int>>(url, options: Options(responseType: ResponseType.bytes));

    final payload = httpResponse.data;
    if (payload == null) {
      throw Exception('Invalid response type');
    }

    if (httpResponse.statusCode != 200) {
      // Manually parse data because responseType is "arrayBuffer"
      final errorPayload = jsonDecode(utf8.decode(payload))['error'];

      return ConnectorResponse.fromError(
        id: errorPayload['id'],
        docs: errorPayload['docs'],
        time: errorPayload['time'],
        code: errorPayload['code'],
        message: errorPayload['message'],
      );
    }

    return ConnectorResponse.success(payload);
  }

  Future<ConnectorResponse<List<int>>> downloadQrCode(String method, String url, {Map<String, dynamic>? request}) async {
    final Options config = Options(responseType: ResponseType.bytes, headers: {'accept': 'image/png'});

    Response<List<int>> httpResponse;

    switch (method) {
      case 'GET':
        httpResponse = await httpClient.get<List<int>>(url, options: config, queryParameters: request);
        break;
      case 'POST':
        httpResponse = await httpClient.post<List<int>>(url, data: request, options: config);
        break;
      default:
        throw Exception('Unsupported method');
    }

    final payload = httpResponse.data;
    if (payload == null) {
      throw Exception('Invalid response type');
    }

    final expectedStatus = method == 'GET' ? 200 : 201;
    if (httpResponse.statusCode != expectedStatus) {
      final errorPayload = jsonDecode(utf8.decode(payload))['error'];

      return ConnectorResponse.fromError(
        id: errorPayload['id'],
        docs: errorPayload['docs'],
        time: errorPayload['time'],
        code: errorPayload['code'],
        message: errorPayload['message'],
      );
    }

    return ConnectorResponse.success(payload);
  }
}
