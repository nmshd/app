import 'package:flutter_inappwebview/flutter_inappwebview.dart';

extension HandleCallAsyncJavaScriptResult on CallAsyncJavaScriptResult {
  void throwOnError() {
    if (error != null) {
      throw Exception(error);
    }
  }

  Map<String, dynamic> valueToMap() {
    throwOnError();

    final value = this.value;
    if (value is! Map) {
      throw Exception('Invalid result, expected Map, got ${value.runtimeType}');
    }

    return Map<String, dynamic>.from(value);
  }

  List<Map<String, dynamic>> valueToList() {
    throwOnError();

    final value = this.value;
    if (value is! List) {
      throw Exception('Invalid result, expected List, got ${value.runtimeType}');
    }

    return value.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}
