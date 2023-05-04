import 'dart:convert';

extension ToBase64WithNoPadding on dynamic {
  String toBase64WithNoPadding() {
    if (this is String) return this;

    return base64UrlEncode(utf8.encode(json.encode(this))).replaceAll(RegExp('=+\$'), '');
  }
}
