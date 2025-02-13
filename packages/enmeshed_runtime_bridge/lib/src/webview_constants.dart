import 'package:flutter_inappwebview/flutter_inappwebview.dart';

const _htmlContent = """<!DOCTYPE html><html><head><meta http-equiv="Content-Security-Policy"
  content="default-src 'self' http://localhost:* http://*.enmeshed.eu https://*.enmeshed.eu https://*.nbpdev.de https://*.meinbildungsraum.de https://*.demo.meinbildungsraum.de https://firebaseinstallations.googleapis.com https://fcmregistrations.googleapis.com mailto: nmshd: data: gap: https://ssl.gstatic.com; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; frame-src 'self'"
/></head></html>""";

final initialData = InAppWebViewInitialData(data: _htmlContent, mimeType: 'text/html', encoding: 'utf-8', baseUrl: WebUri('nmshd://prod'));
