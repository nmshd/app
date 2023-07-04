import 'package:flutter_inappwebview/flutter_inappwebview.dart';

abstract class AbstractEvaluator {
  Future<CallAsyncJavaScriptResult> evaluateJavaScript(
    String source, {
    Map<String, dynamic> arguments = const <String, dynamic>{},
  });
}
