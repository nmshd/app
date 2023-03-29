// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:connector_sdk/connector_sdk.dart';

void main() async {
  final cc = ConnectorClient('https://jkoenig.is.enmeshed.eu', 'EryuQRBhPRwiQ1f9Do7Hif0qK679AnxN');

  final file = await cc.files.uploadOwnFile(
    title: 'test',
    description: 'test',
    expiresAt: DateTime.now().add(const Duration(days: 1)).toIso8601String(),
    file: utf8.encode('test'),
    filename: 'test.txt',
  );
  print(file.data);

  final download = await cc.files.downloadFile(file.data.id);
  print(utf8.decode(download.data));

  final qr = await cc.files.getQrCodeForFile(file.data.id);
  File('qr.png').writeAsBytesSync(qr.data);

  final files = await cc.files.getFiles();
  for (final element in files.data) {
    print(element);
  }
}
