import 'runtime_error.dart';

class Result<T> {
  final T? _value;
  final RuntimeError? _error;

  bool get isError => _error != null;
  bool get isSuccess => _value != null;

  T get value {
    if (_value == null) {
      throw _error!;
    }

    return _value;
  }

  RuntimeError get error {
    if (_error == null) throw StateError('The result is not an error');
    return _error;
  }

  Result._({T? value, RuntimeError? error})
      : _value = value,
        _error = error;

  factory Result.success(T value) => Result._(value: value);
  factory Result.failure(RuntimeError error) => Result._(error: error);

  factory Result.fromJson(Map json, T Function(dynamic) transformer) {
    if (json.containsKey('error')) {
      return Result.failure(RuntimeError.fromJson(json['error']));
    }
    return Result.success(transformer(json['value']));
  }
}
