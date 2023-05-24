import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';

import '../../utils.dart';

void run(EnmeshedRuntime runtime) {
  late Session session;
  late Session session2;
  late FileDTO globalFile;

  setUpAll(() async {
    EnmeshedRuntime.setAssetsFolder('assets');

    final account = await runtime.accountServices.createAccount(name: 'filesFacade Test');
    session = runtime.getSession(account.id);
    final account2 = await runtime.accountServices.createAccount(name: 'filesFacade Test 2');
    session2 = runtime.getSession(account2.id);

    final data = await rootBundle.load('integration_test/test_assets/testFile.txt');
    final bytes = data.buffer.asUint8List().toList();

    final fileResult = await session.transportServices.files.uploadOwnFile(
      content: bytes,
      filename: 'facades/test.txt',
      mimetype: 'plain',
      expiresAt: DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString(),
      title: 'aTitle',
    );

    final file = fileResult.value;
    globalFile = file;

    expect(file, isInstanceOf<FileDTO>());
    expect(file.filename, 'facades/test.txt');
    expect(file.mimetype, 'plain');
    expect(file.title, 'aTitle');
  });

  group('FilesFacade: uploadOwnFile', () {
    test('returns a valid FileDTO', () async {
      final data = await rootBundle.load('integration_test/test_assets/testFile.txt');
      final bytes = data.buffer.asUint8List().toList();

      final fileResult = await session.transportServices.files.uploadOwnFile(
        content: bytes,
        filename: 'facades/test.txt',
        mimetype: 'plain',
        expiresAt: DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString(),
        title: 'aTitle',
      );

      final file = fileResult.value;
      // globalFile = file;

      expect(file, isInstanceOf<FileDTO>());
      expect(file.filename, 'facades/test.txt');
      expect(file.mimetype, 'plain');
      expect(file.title, 'aTitle');
    });
    test('returns a valid FileDTO with all properties', () async {
      final data = await rootBundle.load('integration_test/test_assets/testFile.txt');
      final bytes = data.buffer.asUint8List().toList();

      final fileResult = await session.transportServices.files.uploadOwnFile(
        content: bytes,
        filename: 'facades/test.txt',
        mimetype: 'plain',
        expiresAt: DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString(),
        title: 'aTitle',
        description: 'aDescription',
      );

      final file = fileResult.value;

      expect(file, isInstanceOf<FileDTO>());
      expect(file.filename, 'facades/test.txt');
      expect(file.mimetype, 'plain');
      expect(file.title, 'aTitle');
      expect(file.description, 'aDescription');
    });
  });

  group('FilesFacade: getFiles', () {
    test('returns a valid list of FileDTOs', () async {
      final filesResult = await session.transportServices.files.getFiles();

      final files = filesResult.value;

      expect(files, isInstanceOf<List<FileDTO>>());
      expect(files, isNotEmpty);
    });
  });

  group('FilesFacade: getOrLoadFileByIdAndKey', () {
    test('returns a valid FileDTO', () async {
      final fileResult = await session.transportServices.files.getOrLoadFileByIdAndKey(fileId: globalFile.id, secretKey: globalFile.secretKey);

      final file = fileResult.value;

      expect(file, isInstanceOf<FileDTO>());
      expect(file.id, globalFile.id);
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await session.transportServices.files.getOrLoadFileByIdAndKey(fileId: '', secretKey: globalFile.secretKey);

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    test('throws an exception if secret key does not match the pattern', () async {
      final result = await session.transportServices.files.getOrLoadFileByIdAndKey(fileId: globalFile.id, secretKey: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });
  });

  group('FilesFacade: getOrLoadFileByReference', () {
    test('returns a valid FileDTO', () async {
      final fileResult = await session.transportServices.files.getOrLoadFileByReference(reference: globalFile.truncatedReference);

      final file = fileResult.value;

      expect(file, isInstanceOf<FileDTO>());
      expect(file.id, globalFile.id);
    });

    test('throws an exception if reference does not match the pattern', () async {
      final result = await session.transportServices.files.getOrLoadFileByReference(reference: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    test('throws an exception on not existing reference', () async {
      final result = await session.transportServices.files.getOrLoadFileByReference(
        reference: 'RklMTG93cDV2Yk5JaUh6QWZ5aGp8M3xKZ2h6dXFKa003TW1Id0hyb3k3akd3dmdleXFXVEdVd3h2QWUwWlRBeXXX',
      );

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.unknown');
    });
  });

  group('FilesFacade: downloadFile', () {
    test('returns a valid DownloadFileResponse', () async {
      final responseResult = await session.transportServices.files.downloadFile(fileId: globalFile.id);

      final response = responseResult.value;

      expect(response, isInstanceOf<DownloadFileResponse>());
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await session.transportServices.files.downloadFile(fileId: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    test('throws an exception on not existing file id', () async {
      final result = await session.transportServices.files.downloadFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.recordNotFound');
    });
  });

  group('FilesFacade: getFile', () {
    test('returns a valid FileDTO', () async {
      final fileResult = await session.transportServices.files.getFile(fileId: globalFile.id);

      final file = fileResult.value;

      expect(file, isInstanceOf<FileDTO>());
      expect(file.id, globalFile.id);
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await session.transportServices.files.getFile(fileId: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    test('throws an exception on not existing file id', () async {
      final result = await session.transportServices.files.getFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.recordNotFound');
    });
  });

  group('FilesFacade: createQrCodeForFile', () {
    test('returns a valid CreateQrCodeResponse', () async {
      final responseResult = await session.transportServices.files.createQrCodeForFile(fileId: globalFile.id);

      final response = responseResult.value;

      expect(response, isInstanceOf<CreateQrCodeResponse>());
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await session.transportServices.files.createQrCodeForFile(fileId: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    test('throws an exception on not existing file id', () async {
      final result = await session.transportServices.files.createQrCodeForFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.recordNotFound');
    });
  });

  group('FilesFacade: createTokenForFile', () {
    test('returns a valid TokenDTO', () async {
      final tokenResult = await session.transportServices.files.createTokenForFile(fileId: globalFile.id);
      final token = tokenResult.value;

      final responseResult = await session2.transportServices.files.getOrLoadFileByReference(reference: token.truncatedReference);
      final response = responseResult.value;

      expect(token, isInstanceOf<TokenDTO>());
      expect(response, isInstanceOf<FileDTO>());
      expect(response.isOwn, false);
    });

    test('returns a valid TokenDTO with all properties', () async {
      final tokenResult = await session.transportServices.files.createTokenForFile(
        fileId: globalFile.id,
        expiresAt: DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString(),
        ephemeral: true,
      );
      final token = tokenResult.value;

      final responseResult = await session2.transportServices.files.getOrLoadFileByReference(reference: token.truncatedReference);
      final response = responseResult.value;

      expect(token, isInstanceOf<TokenDTO>());
      expect(token.isEphemeral, true);
      expect(response, isInstanceOf<FileDTO>());
      expect(response.isOwn, false);
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await session.transportServices.files.createTokenForFile(fileId: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    test('throws an exception on not existing file id', () async {
      final result = await session.transportServices.files.createTokenForFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.recordNotFound');
    });
  });

  group('FilesFacade: createTokenQrCodeForFile', () {
    test('returns a valid CreateQrCodeResponse', () async {
      final tokenResult = await session.transportServices.files.createTokenQrCodeForFile(fileId: globalFile.id);

      final token = tokenResult.value;

      expect(token, isInstanceOf<CreateQrCodeResponse>());
    });

    test('returns a valid CreateQrCodeResponse with all properties', () async {
      final tokenResult = await session.transportServices.files.createTokenQrCodeForFile(
        fileId: globalFile.id,
        expiresAt: DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString(),
      );

      final token = tokenResult.value;

      expect(token, isInstanceOf<CreateQrCodeResponse>());
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await session.transportServices.files.createTokenQrCodeForFile(fileId: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    test('throws an exception on not existing file id', () async {
      final result = await session.transportServices.files.createTokenQrCodeForFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.recordNotFound');
    });
  });
}
