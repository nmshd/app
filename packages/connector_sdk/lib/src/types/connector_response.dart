import 'connector_error.dart';

class ConnectorResponse<T> {
  final T? _data;
  final ConnectorError? _error;

  T get data {
    if (_data == null) {
      throw Exception('${error.code}: ${error.message}');
    }

    return _data;
  }

  ConnectorError get error {
    if (_error == null) {
      throw Exception('No error');
    }

    return _error;
  }

  ConnectorResponse._(this._data, this._error);

  factory ConnectorResponse.success(T data) {
    return ConnectorResponse._(data, null);
  }

  factory ConnectorResponse.fromError(ConnectorError error) {
    return ConnectorResponse._(
      null,
      error,
    );
  }

  bool get hasError => _error != null;
  bool get hasData => _data != null;
}
