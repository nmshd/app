import 'dart:convert';
import 'dart:typed_data';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../matchers.dart';
import '../../utils.dart';

void run(EnmeshedRuntime runtime) {
  late Session session;
  late Session session2;
  late FileDTO globalFile;

  setUpAll(() async {
    final account = await runtime.accountServices.createAccount(name: 'filesFacade Test');
    session = runtime.getSession(account.id);
    final account2 = await runtime.accountServices.createAccount(name: 'filesFacade Test 2');
    session2 = runtime.getSession(account2.id);

    final expiresAt = generateExpiryString();
    final bytes = Uint8List.fromList(utf8.encode('a String')).toList();

    final fileResult = await session.transportServices.files.uploadOwnFile(
      content: bytes,
      filename: 'facades/test.txt',
      mimetype: 'plain',
      expiresAt: expiresAt,
      title: 'aTitle',
    );

    final file = fileResult.value;
    globalFile = file;

    expect(file, isA<FileDTO>());
    expect(file.filename, 'facades/test.txt');
    expect(file.mimetype, 'plain');
    expect(file.expiresAt, expiresAt);
    expect(file.title, 'aTitle');
  });

  group('FilesFacade: uploadOwnFile', () {
    test('should upload own file', () async {
      final expiresAt = generateExpiryString();
      final bytes = Uint8List.fromList(utf8.encode('a String')).toList();

      final fileResult = await session.transportServices.files.uploadOwnFile(
        content: bytes,
        filename: 'facades/test.txt',
        mimetype: 'plain',
        expiresAt: expiresAt,
        title: 'aTitle',
      );
      final file = fileResult.value;

      expect(fileResult, isSuccessful<FileDTO>());
      expect(file.filename, 'facades/test.txt');
      expect(file.mimetype, 'plain');
      expect(file.expiresAt, expiresAt);
      expect(file.title, 'aTitle');
    });

    test('should upload own file with all properties', () async {
      final expiresAt = generateExpiryString();
      final bytes = Uint8List.fromList(utf8.encode('a String')).toList();

      final fileResult = await session.transportServices.files.uploadOwnFile(
        content: bytes,
        filename: 'facades/test.txt',
        mimetype: 'plain',
        expiresAt: expiresAt,
        title: 'aTitle',
        description: 'aDescription',
      );
      final file = fileResult.value;

      expect(fileResult, isSuccessful<FileDTO>());
      expect(file.filename, 'facades/test.txt');
      expect(file.mimetype, 'plain');
      expect(file.expiresAt, expiresAt);
      expect(file.title, 'aTitle');
      expect(file.description, 'aDescription');
    });
  });

  group('FilesFacade: getFiles', () {
    test('should give access to uploaded files', () async {
      final filesResult = await session.transportServices.files.getFiles();
      final files = filesResult.value;

      expect(filesResult, isSuccessful<List<FileDTO>>());
      expect(files, isNotEmpty);
    });
  });

  group('FilesFacade: getOrLoadFileByIdAndKey', () {
    test('should be able to load files by entering id and key', () async {
      final fileResult = await session.transportServices.files.getOrLoadFileByIdAndKey(fileId: globalFile.id, secretKey: globalFile.secretKey);
      final file = fileResult.value;

      expect(fileResult, isSuccessful<FileDTO>());
      expect(file.id, globalFile.id);
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await session.transportServices.files.getOrLoadFileByIdAndKey(fileId: '', secretKey: globalFile.secretKey);

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception if secret key does not match the pattern', () async {
      final result = await session.transportServices.files.getOrLoadFileByIdAndKey(fileId: globalFile.id, secretKey: '');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });
  });

  group('FilesFacade: getOrLoadFileByReference', () {
    test('should be able to load files by entering reference', () async {
      final fileResult = await session.transportServices.files.getOrLoadFileByReference(reference: globalFile.truncatedReference);
      final file = fileResult.value;

      expect(fileResult, isSuccessful<FileDTO>());
      expect(file.id, globalFile.id);
    });

    test('throws an exception if reference does not match the pattern', () async {
      final result = await session.transportServices.files.getOrLoadFileByReference(reference: '');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception on not existing reference', () async {
      final result = await session.transportServices.files.getOrLoadFileByReference(
        reference: 'RklMTG93cDV2Yk5JaUh6QWZ5aGp8M3xKZ2h6dXFKa003TW1Id0hyb3k3akd3dmdleXFXVEdVd3h2QWUwWlRBeXXX',
      );

      // TODO: why unknown
      expect(result, isFailing('error.runtime.unknown'));
    });
  });

  group('FilesFacade: downloadFile', () {
    // TODO: re-enable test
    test('should allow to download a file', skip: true, () async {
      final responseResult = await session.transportServices.files.downloadFile(fileId: globalFile.id);

      final response = responseResult.value;

      expect(responseResult, isSuccessful<DownloadFileResponse>());
      expect(utf8.decode(response.content), 'a String');
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await session.transportServices.files.downloadFile(fileId: '');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception on not existing file id', () async {
      final result = await session.transportServices.files.downloadFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('FilesFacade: getFile', () {
    test('should return a valid file', () async {
      final fileResult = await session.transportServices.files.getFile(fileId: globalFile.id);
      final file = fileResult.value;

      expect(fileResult, isSuccessful<FileDTO>());
      expect(file.id, globalFile.id);
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await session.transportServices.files.getFile(fileId: '');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception on not existing file id', () async {
      final result = await session.transportServices.files.getFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('FilesFacade: createQrCodeForFile', () {
    test('should return a valid CreateQrCodeResponse', () async {
      final responseResult = await session.transportServices.files.createQrCodeForFile(fileId: globalFile.id);

      expect(responseResult, isSuccessful<CreateQrCodeResponse>());
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await session.transportServices.files.createQrCodeForFile(fileId: '');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception on not existing file id', () async {
      final result = await session.transportServices.files.createQrCodeForFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('FilesFacade: createTokenForFile', () {
    test('should return a valid TokenDTO', () async {
      final tokenResult = await session.transportServices.files.createTokenForFile(fileId: globalFile.id);
      final token = tokenResult.value;

      final responseResult = await session2.transportServices.files.getOrLoadFileByReference(reference: token.truncatedReference);
      final response = responseResult.value;

      expect(tokenResult, isSuccessful<TokenDTO>());
      expect(responseResult, isSuccessful<FileDTO>());
      expect(response.isOwn, false);
    });

    test('should return a valid TokenDTO with all properties', () async {
      final expiresAt = generateExpiryString();

      final tokenResult = await session.transportServices.files.createTokenForFile(
        fileId: globalFile.id,
        expiresAt: expiresAt,
        ephemeral: true,
      );
      final token = tokenResult.value;

      final responseResult = await session2.transportServices.files.getOrLoadFileByReference(reference: token.truncatedReference);
      final response = responseResult.value;

      expect(tokenResult, isSuccessful<TokenDTO>());
      expect(token.expiresAt, expiresAt);
      expect(token.isEphemeral, true);
      expect(responseResult, isSuccessful<FileDTO>());
      expect(response.isOwn, false);
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await session.transportServices.files.createTokenForFile(fileId: '');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception on not existing file id', () async {
      final result = await session.transportServices.files.createTokenForFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('FilesFacade: createTokenQrCodeForFile', () {
    test('should return a valid CreateQrCodeResponse', () async {
      final tokenResult = await session.transportServices.files.createTokenQrCodeForFile(fileId: globalFile.id);

      expect(tokenResult, isSuccessful<CreateQrCodeResponse>());
    });

    test('should return a valid CreateQrCodeResponse with all properties', () async {
      final tokenResult = await session.transportServices.files.createTokenQrCodeForFile(
        fileId: globalFile.id,
        expiresAt: generateExpiryString(),
      );

      expect(tokenResult, isSuccessful<CreateQrCodeResponse>());
    });

    test('throws an exception if file id does not match the pattern', () async {
      final result = await session.transportServices.files.createTokenQrCodeForFile(fileId: '');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception on not existing file id', () async {
      final result = await session.transportServices.files.createTokenQrCodeForFile(fileId: 'FILXXXXXXXXXXXXXXXXX');

      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });
}
