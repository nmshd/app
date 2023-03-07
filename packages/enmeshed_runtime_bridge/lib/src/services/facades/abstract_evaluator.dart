import 'package:flutter_inappwebview/flutter_inappwebview.dart';

abstract class AbstractEvaluator {
  Future<CallAsyncJavaScriptResult> evaluateJavascript(
    String source, {
    Map<String, dynamic> arguments = const <String, dynamic>{},
  });
}
