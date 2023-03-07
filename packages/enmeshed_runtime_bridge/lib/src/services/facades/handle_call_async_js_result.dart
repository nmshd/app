import 'package:flutter_inappwebview/flutter_inappwebview.dart';

extension HandleCallAsyncJavaScriptResult on CallAsyncJavaScriptResult {
  void throwOnError() {
    if (error != null) {
      throw Exception(error);
    }
  }

  T toValue<T>() {
    throwOnError();

    final value = this.value;
    if (value is! T) {
      throw Exception('Invalid result, expected $T, got ${value.runtimeType}');
    }

    return value;
  }
}
