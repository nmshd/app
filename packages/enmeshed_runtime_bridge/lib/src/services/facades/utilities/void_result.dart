import 'runtime_error.dart';

class VoidResult {
  final RuntimeError? _error;

  bool get isError => _error != null;
  bool get isSuccess => _error == null;

  VoidResult._({RuntimeError? error}) : _error = error;

  factory VoidResult.success() => VoidResult._();
  factory VoidResult.failure(RuntimeError error) => VoidResult._(error: error);

  factory VoidResult.fromJson(Map json) {
    if (json.containsKey('error')) {
      return VoidResult.failure(RuntimeError.fromJson(json['error']));
    }

    return VoidResult.success();
  }
}
