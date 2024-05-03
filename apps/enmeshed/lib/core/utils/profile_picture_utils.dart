import 'dart:io';
import 'dart:typed_data';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

const _profilePictureSettingKey = 'profile_picture';

Future<void> saveProfilePicture({required Uint8List byteData, required String accountReference}) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountReference);

  final enmeshedFileResult = await session.transportServices.files.uploadOwnFile(
    content: byteData.buffer.asUint8List().toList(),
    filename: 'profile_pic.png',
    mimetype: 'image/png',
    // TODO(jkoenig134): this should not expire
    expiresAt: DateTime.now().add(const Duration(days: 365 * 100)).toIso8601String(),
    title: 'i18n://files.profile_picture',
  );
  if (enmeshedFileResult.isError) return;

  final enmeshedFile = enmeshedFileResult.value;

  final filePath = await _getFilePath(session: session, fileId: enmeshedFile.id);

  final file = File(filePath);
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer.asUint8List());

  await _saveProfilePictureSetting(fileId: enmeshedFile.id, session: session);
}

Future<void> _saveProfilePictureSetting({required String fileId, required Session session}) async {
  final newValue = {'fileId': fileId};

  final settingRequest = await session.consumptionServices.settings.getSettingByKey(_profilePictureSettingKey);

  if (settingRequest.isError) {
    // TODO(jkoenig134): should check if setting is not found or different error occured
    await session.consumptionServices.settings.createSetting(key: _profilePictureSettingKey, value: newValue);
    return;
  }

  await session.consumptionServices.settings.updateSetting(settingRequest.value.id, newValue);
}

Future<void> deleteProfilePictureSetting({required String accountReference}) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountReference);

  final settingRequest = await session.consumptionServices.settings.getSettingByKey(_profilePictureSettingKey);

  if (settingRequest.isError) {
    // TODO(jkoenig134): should check if setting is not found or different error occured
    return;
  }

  await session.consumptionServices.settings.deleteSetting(settingRequest.value.id);
}

Future<File?> loadProfilePicture({required String accountReference}) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountReference);

  final settingResult = await session.consumptionServices.settings.getSettingByKey(_profilePictureSettingKey);
  // TODO(jkoenig134): should check if setting is not found or different error occured
  if (settingResult.isError) return null;

  final setting = settingResult.value;
  final fileId = setting.value['fileId'] as String;

  final path = await _getFilePath(session: session, fileId: setting.value['fileId'] as String);
  final file = File(path);

  if (!file.existsSync()) {
    final downloadFileResult = await session.transportServices.files.downloadFile(fileId: fileId);
    if (downloadFileResult.isError) return null;

    await file.create(recursive: true);
    await file.writeAsBytes(downloadFileResult.value.content);
  }

  return File(path);
}

Future<String> _getFilePath({required Session session, required String fileId}) async {
  final docDirectory = await getApplicationDocumentsDirectory();
  final path = docDirectory.path;

  final info = await session.transportServices.account.getIdentityInfo();

  return '$path/cache/${info.value.address}/$fileId.png';
}
