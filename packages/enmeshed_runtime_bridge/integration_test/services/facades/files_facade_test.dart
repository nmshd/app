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
    testWidgets('returns a valid FileDTO', (_) async {
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
    testWidgets('returns a valid FileDTO with all properties', (_) async {
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
    testWidgets('returns a valid list of FileDTOs', (_) async {
      final filesResult = await session.transportServices.files.getFiles();

      final files = filesResult.value;

      expect(files, isInstanceOf<List<FileDTO>>());
      expect(files, isNotEmpty);
    });
  });

  group('FilesFacade: getOrLoadFileByIdAndKey', () {
    testWidgets('returns a valid FileDTO', (_) async {
      final fileResult = await session.transportServices.files.getOrLoadFileByIdAndKey(fileId: globalFile.id, secretKey: globalFile.secretKey);

      final file = fileResult.value;

      expect(file, isInstanceOf<FileDTO>());
      expect(file.id, globalFile.id);
    });

    testWidgets('throws an exception if file id does not match the pattern', (_) async {
      final result = await session.transportServices.files.getOrLoadFileByIdAndKey(fileId: '', secretKey: globalFile.secretKey);

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    testWidgets('throws an exception if secret key does not match the pattern', (_) async {
      final result = await session.transportServices.files.getOrLoadFileByIdAndKey(fileId: globalFile.id, secretKey: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });
  });

  group('FilesFacade: getOrLoadFileByReference', () {
    testWidgets('returns a valid FileDTO', (_) async {
      final fileResult = await session.transportServices.files.getOrLoadFileByReference(reference: globalFile.truncatedReference);

      final file = fileResult.value;

      expect(file, isInstanceOf<FileDTO>());
      expect(file.id, globalFile.id);
    });

    testWidgets('throws an exception if reference does not match the pattern', (_) async {
      final result = await session.transportServices.files.getOrLoadFileByReference(reference: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    testWidgets('throws an exception on not existing reference', (_) async {
      final result = await session.transportServices.files.getOrLoadFileByReference(
        reference: 'RklMTG93cDV2Yk5JaUh6QWZ5aGp8M3xKZ2h6dXFKa003TW1Id0hyb3k3akd3dmdleXFXVEdVd3h2QWUwWlRBeXXX',
      );

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.unknown');
    });
  });

  group('FilesFacade: downloadFile', () {
    testWidgets('returns a valid DownloadFileResponse', (_) async {
      final responseResult = await session.transportServices.files.downloadFile(fileId: globalFile.id);

      final response = responseResult.value;

      expect(response, isInstanceOf<DownloadFileResponse>());
    });

    testWidgets('throws an exception if file id does not match the pattern', (_) async {
      final result = await session.transportServices.files.downloadFile(fileId: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    testWidgets('throws an exception on not existing file id', (_) async {
      final result = await session.transportServices.files.downloadFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.recordNotFound');
    });
  });

  group('FilesFacade: getFile', () {
    testWidgets('returns a valid FileDTO', (_) async {
      final fileResult = await session.transportServices.files.getFile(fileId: globalFile.id);

      final file = fileResult.value;

      expect(file, isInstanceOf<FileDTO>());
      expect(file.id, globalFile.id);
    });

    testWidgets('throws an exception if file id does not match the pattern', (_) async {
      final result = await session.transportServices.files.getFile(fileId: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    testWidgets('throws an exception on not existing file id', (_) async {
      final result = await session.transportServices.files.getFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.recordNotFound');
    });
  });

  group('FilesFacade: createQrCodeForFile', () {
    testWidgets('returns a valid CreateQrCodeResponse', (_) async {
      final responseResult = await session.transportServices.files.createQrCodeForFile(fileId: globalFile.id);

      final response = responseResult.value;

      expect(response, isInstanceOf<CreateQrCodeResponse>());
    });

    testWidgets('throws an exception if file id does not match the pattern', (_) async {
      final result = await session.transportServices.files.createQrCodeForFile(fileId: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    testWidgets('throws an exception on not existing file id', (_) async {
      final result = await session.transportServices.files.createQrCodeForFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.recordNotFound');
    });
  });

  group('FilesFacade: createTokenForFile', () {
    testWidgets('returns a valid TokenDTO', (_) async {
      final tokenResult = await session.transportServices.files.createTokenForFile(fileId: globalFile.id);
      final token = tokenResult.value;

      final responseResult = await session2.transportServices.files.getOrLoadFileByReference(reference: token.truncatedReference);
      final response = responseResult.value;

      expect(token, isInstanceOf<TokenDTO>());
      expect(response, isInstanceOf<FileDTO>());
      expect(response.isOwn, false);
    });

    testWidgets('returns a valid TokenDTO with all properties', (_) async {
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

    testWidgets('throws an exception if file id does not match the pattern', (_) async {
      final result = await session.transportServices.files.createTokenForFile(fileId: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    testWidgets('throws an exception on not existing file id', (_) async {
      final result = await session.transportServices.files.createTokenForFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.recordNotFound');
    });
  });

  group('FilesFacade: createTokenQrCodeForFile', () {
    testWidgets('returns a valid CreateQrCodeResponse', (_) async {
      final tokenResult = await session.transportServices.files.createTokenQrCodeForFile(fileId: globalFile.id);

      final token = tokenResult.value;

      expect(token, isInstanceOf<CreateQrCodeResponse>());
    });

    testWidgets('returns a valid CreateQrCodeResponse with all properties', (_) async {
      final tokenResult = await session.transportServices.files.createTokenQrCodeForFile(
        fileId: globalFile.id,
        expiresAt: DateTime.now().add(const Duration(minutes: 5)).toRuntimeIsoString(),
      );

      final token = tokenResult.value;

      expect(token, isInstanceOf<CreateQrCodeResponse>());
    });

    testWidgets('throws an exception if file id does not match the pattern', (_) async {
      final result = await session.transportServices.files.createTokenQrCodeForFile(fileId: '');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.validation.invalidPropertyValue');
    });

    testWidgets('throws an exception on not existing file id', (_) async {
      final result = await session.transportServices.files.createTokenQrCodeForFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result.isSuccess, false);
      expect(result.error.code, 'error.runtime.recordNotFound');
    });
  });
}
