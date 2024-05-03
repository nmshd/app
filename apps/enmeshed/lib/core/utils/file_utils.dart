import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import '/core/core.dart';

Future<File?> downloadAndCacheFile({
  required Session session,
  required FileDVO fileDVO,
  required VoidCallback onError,
}) async {
  try {
    final cacheDir = await getTemporaryDirectory();

    final response = await session.transportServices.files.downloadFile(fileId: fileDVO.id);

    final cachedFile = fileDVO.getCacheFile(cacheDir);
    await cachedFile.parent.create(recursive: true);
    await cachedFile.writeAsBytes(response.value.content);

    return cachedFile;
  } on PlatformException catch (e) {
    GetIt.I.get<Logger>().e('Uploading document failed caused by: $e');
    onError();

    return null;
  }
}

Future<FileDVO> expandFileReference({
  required String accountId,
  required String fileReference,
}) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

  final fileDTO = await session.transportServices.files.getOrLoadFileByReference(reference: fileReference);
  final expanded = await session.expander.expandFileDTO(fileDTO.value);
  return expanded;
}
