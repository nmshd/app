import 'dart:convert';
import 'dart:typed_data';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../setup.dart';
import '../../../utils.dart';

void main() async => run(await setup());

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

    expect(fileResult, isSuccessful<FileDTO>());

    globalFile = fileResult.value;

    expect(fileResult.value.filename, 'facades/test.txt');
    expect(fileResult.value.mimetype, 'plain');
    expect(fileResult.value.expiresAt, expiresAt);
    expect(fileResult.value.title, 'aTitle');
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

      expect(fileResult, isSuccessful<FileDTO>());
      expect(fileResult.value.filename, 'facades/test.txt');
      expect(fileResult.value.mimetype, 'plain');
      expect(fileResult.value.expiresAt, expiresAt);
      expect(fileResult.value.title, 'aTitle');
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
        tags: ['x+%+aTag'],
      );

      expect(fileResult, isSuccessful<FileDTO>());
      expect(fileResult.value.filename, 'facades/test.txt');
      expect(fileResult.value.mimetype, 'plain');
      expect(fileResult.value.expiresAt, expiresAt);
      expect(fileResult.value.title, 'aTitle');
      expect(fileResult.value.description, 'aDescription');
      expect(fileResult.value.tags, ['x+%+aTag']);
    });

    test('should use default uploading own file without expiry date', () async {
      final bytes = Uint8List.fromList(utf8.encode('a String')).toList();

      final fileResult = await session.transportServices.files.uploadOwnFile(
        content: bytes,
        filename: 'facades/test.txt',
        mimetype: 'plain',
        title: 'aTitle',
      );

      expect(fileResult, isSuccessful<FileDTO>());
      const defaultExpiryDate = '9999-12-31T00:00:00.000Z';
      expect(fileResult.value.expiresAt, defaultExpiryDate);
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

  group('FilesFacade: getOrLoadFile', () {
    test('should be able to load files by entering reference', () async {
      final fileResult = await session.transportServices.files.getOrLoadFile(reference: globalFile.truncatedReference);

      expect(fileResult, isSuccessful<FileDTO>());
      expect(fileResult.value.id, globalFile.id);
    });

    test('throws an exception if reference does not match the pattern', () async {
      final result = await session.transportServices.files.getOrLoadFile(reference: '');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception on not existing reference', () async {
      final result = await session.transportServices.files.getOrLoadFile(
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

      expect(responseResult, isSuccessful<DownloadFileResponse>());
      expect(utf8.decode(responseResult.value.content), 'a String');
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

      expect(fileResult, isSuccessful<FileDTO>());
      expect(fileResult.value.id, globalFile.id);
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

  group('FilesFacade: createTokenForFile', () {
    test('should return a valid TokenDTO', () async {
      final tokenResult = await session.transportServices.files.createTokenForFile(fileId: globalFile.id);

      expect(tokenResult, isSuccessful<TokenDTO>());

      final responseResult = await session2.transportServices.files.getOrLoadFile(reference: tokenResult.value.truncatedReference);

      expect(responseResult, isSuccessful<FileDTO>());
      expect(responseResult.value.isOwn, false);
    });

    test('should return a valid TokenDTO with all properties', () async {
      final expiresAt = generateExpiryString();

      final tokenResult = await session.transportServices.files.createTokenForFile(
        fileId: globalFile.id,
        expiresAt: expiresAt,
        ephemeral: true,
      );

      expect(tokenResult, isSuccessful<TokenDTO>());

      final responseResult = await session2.transportServices.files.getOrLoadFile(reference: tokenResult.value.truncatedReference);
      final response = responseResult.value;

      expect(tokenResult.value.expiresAt, expiresAt);
      expect(tokenResult.value.isEphemeral, true);
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

  group('FilesFacade: deleteFile', () {
    test('should delete a file', () async {
      final expiresAt = generateExpiryString();
      final bytes = Uint8List.fromList(utf8.encode('a String')).toList();

      final uploadFileResult = await session.transportServices.files.uploadOwnFile(
        content: bytes,
        filename: 'facades/test.txt',
        mimetype: 'plain',
        expiresAt: expiresAt,
        title: 'aTitle',
      );
      final fileId = uploadFileResult.value.id;

      final getFileResult = await session.transportServices.files.getFile(fileId: fileId);
      expect(getFileResult, isSuccessful<FileDTO>());

      final deleteFileResult = await session.transportServices.files.deleteFile(fileId: fileId);
      expect(deleteFileResult, isSuccessful());

      final getFileAfterDeletionResult = await session.transportServices.files.getFile(fileId: fileId);
      expect(getFileAfterDeletionResult.error.code, 'error.runtime.recordNotFound');
    });
  });
}
