import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../types/types.dart';

export '../types/connector_response.dart';

abstract class Endpoint {
  final Dio _dio;

  Endpoint(this._dio);

  @protected
  Future<T> getPlain<T>(String path) async {
    final response = await _dio.get<T>(path);
    if (response.data == null) {
      throw Exception('Invalid response type');
    }

    return response.data!;
  }

  @protected
  Future<ConnectorResponse<T>> get<T>(String path, {required T Function(dynamic) transformer, Map<String, dynamic>? query}) async {
    final response = await _dio.get<Map<String, dynamic>>(path, queryParameters: query);
    return _makeResult(response, transformer);
  }

  @protected
  Future<ConnectorResponse<T>> post<T>(
    String path, {
    required T Function(dynamic) transformer,
    Object? data,
    int? expectedStatus,
    Map<String, dynamic>? params,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(path, data: data, queryParameters: params);
    return _makeResult(response, transformer, expectedStatus: expectedStatus);
  }

  @protected
  Future<ConnectorResponse<T>> put<T>(String path, {required T Function(dynamic) transformer, Object? data}) async {
    final response = await _dio.put<Map<String, dynamic>>(path, data: data);
    return _makeResult(response, transformer);
  }

  ConnectorResponse<T> _makeResult<T>(Response<Map<String, dynamic>> httpResponse, T Function(dynamic) transformer, {int? expectedStatus}) {
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
      return ConnectorResponse.fromError(ConnectorError.fromJson(errorPayload));
    }

    return ConnectorResponse.success(transformer(payload['result']));
  }

  @protected
  Future<ConnectorResponse<List<int>>> download(String url) async {
    final httpResponse = await _dio.get<List<int>>(url, options: Options(responseType: ResponseType.bytes));

    final payload = httpResponse.data;
    if (payload == null) {
      throw Exception('Invalid response type');
    }

    if (httpResponse.statusCode != 200) {
      // Manually parse data because responseType is "arrayBuffer"
      final errorPayload = jsonDecode(utf8.decode(payload))['error'];
      return ConnectorResponse.fromError(ConnectorError.fromJson(errorPayload));
    }

    return ConnectorResponse.success(payload);
  }

  @protected
  Future<ConnectorResponse<List<int>>> downloadQrCode(String method, String url, {Map<String, dynamic>? request}) async {
    final Options config = Options(responseType: ResponseType.bytes, headers: {'accept': 'image/png'});

    Response<List<int>> httpResponse;

    switch (method) {
      case 'GET':
        httpResponse = await _dio.get<List<int>>(url, options: config, queryParameters: request);
        break;
      case 'POST':
        httpResponse = await _dio.post<List<int>>(url, data: request, options: config);
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
      return ConnectorResponse.fromError(ConnectorError.fromJson(errorPayload));
    }

    return ConnectorResponse.success(payload);
  }
}
