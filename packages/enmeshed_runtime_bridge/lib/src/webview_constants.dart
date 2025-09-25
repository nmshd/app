import 'package:flutter_inappwebview/flutter_inappwebview.dart';

const _htmlContent = """<!DOCTYPE html><html><head><meta http-equiv="Content-Security-Policy"
  content="default-src *; style-src * 'unsafe-inline'; script-src * 'unsafe-inline' 'unsafe-eval'; frame-src *"
/></head></html>""";

final initialData = InAppWebViewInitialData(data: _htmlContent, mimeType: 'text/html', encoding: 'utf-8', baseUrl: WebUri('nmshd://prod'));
