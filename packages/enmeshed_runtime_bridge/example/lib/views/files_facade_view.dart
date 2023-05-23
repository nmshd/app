import 'dart:convert';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilesFacadeView extends StatelessWidget {
  final EnmeshedRuntime runtime;

  const FilesFacadeView({super.key, required this.runtime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              final files = await runtime.currentSession.transportServices.files.getFiles();
              print(files);
            },
            child: const Text('getFiles'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final files = await runtime.currentSession.transportServices.files.getFiles();

              final file = await runtime.currentSession.transportServices.files.getOrLoadFileByIdAndKey(
                fileId: files.value.first.id,
                secretKey: files.value.first.secretKey,
              );
              print(file);
            },
            child: const Text('getOrLoadFileByIdAndKey'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final files = await runtime.currentSession.transportServices.files.getFiles();

              final file = await runtime.currentSession.transportServices.files.getOrLoadFileByReference(
                reference: files.value.first.truncatedReference,
              );
              print(file);
            },
            child: const Text('getOrLoadFileByReference'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final files = await runtime.currentSession.transportServices.files.getFiles();

              final response = await runtime.currentSession.transportServices.files.downloadFile(fileId: files.value.first.id);
              print(utf8.decode(response.value.content));
            },
            child: const Text('downloadFile'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final files = await runtime.currentSession.transportServices.files.getFiles();

              final file = await runtime.currentSession.transportServices.files.getFile(fileId: files.value.first.id);
              print(file);
            },
            child: const Text('getFile'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final data = await rootBundle.load('assets/testFile.txt');
              final bytes = data.buffer.asUint8List().toList();

              final file = await runtime.currentSession.transportServices.files.uploadOwnFile(
                content: bytes,
                filename: 'test.txt',
                mimetype: 'plain',
                expiresAt: DateTime.now().add(const Duration(days: 365)).toIso8601String(),
                title: 'TestTitle',
              );
              print(file);
            },
            child: const Text('uploadOwnFile'),
          ),
        ],
      ),
    );
  }
}
