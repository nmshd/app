import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '/core/core.dart';

Future<void> moveFileOnDevice({required Session session, required FileDVO fileDVO, required VoidCallback onError}) async {
  try {
    final cachedFile = await _getCachedFile(session: session, fileDVO: fileDVO);
    if (cachedFile == null) {
      onError();
      return;
    }

    final bytes = await cachedFile.readAsBytes();

    final deviceDir = await FilePicker.platform.saveFile(
      fileName: fileDVO.filename,
      allowedExtensions: [getFileExtension(fileDVO.filename)],
      bytes: Platform.isIOS || Platform.isAndroid ? bytes : null,
    );

    if (Platform.isIOS || Platform.isAndroid) return;

    if (deviceDir == null) return;

    final savedFile = File(deviceDir);
    await savedFile.writeAsBytes(bytes);
  } on PlatformException catch (e) {
    GetIt.I.get<Logger>().e('Saving document failed caused by: $e');
    onError();

    return;
  }
}

Future<void> openFile({required Session session, required FileDVO fileDVO, required VoidCallback onError}) async {
  final cachedFile = await _getCachedFile(session: session, fileDVO: fileDVO);
  if (cachedFile == null) {
    onError();
    return;
  }

  await OpenFile.open(cachedFile.path);
}

Future<void> shareFile({required Session session, required FileDVO fileDVO, required VoidCallback onError}) async {
  final cachedFile = await _getCachedFile(session: session, fileDVO: fileDVO);
  if (cachedFile == null) {
    onError();
    return;
  }

  final params = ShareParams(files: [XFile(cachedFile.path, name: fileDVO.filename, mimeType: fileDVO.mimetype)]);

  final result = await SharePlus.instance.share(params);

  if (result.status == ShareResultStatus.success || result.status == ShareResultStatus.dismissed) return;

  onError();
}

Future<File?> _getCachedFile({required Session session, required FileDVO fileDVO}) async {
  try {
    final cacheDir = await getTemporaryDirectory();
    final cachedFile = fileDVO.getCacheFile(cacheDir);
    if (cachedFile.existsSync()) return cachedFile;

    final response = await session.transportServices.files.downloadFile(fileId: fileDVO.id);

    await cachedFile.parent.create(recursive: true);
    await cachedFile.writeAsBytes(response.value.content);

    return cachedFile;
  } on PlatformException catch (e) {
    GetIt.I.get<Logger>().e('Could not get the cached file: $e');

    return null;
  }
}

Future<FileDVO> expandFileReference({required String accountId, required String fileReference}) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

  final fileDTO = await session.transportServices.files.getOrLoadFile(reference: fileReference);
  final expanded = await session.expander.expandFileDTO(fileDTO.value);
  return expanded;
}

String getFileExtension(String filePath) {
  return path.extension(filePath).isEmpty ? '' : path.extension(filePath).substring(1).toUpperCase();
}
