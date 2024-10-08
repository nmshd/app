import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('FileDTO toJson', () {
    test('is correctly converted', () {
      const dto = FileDTO(
        id: 'anId',
        filename: 'aFilename',
        filesize: 1,
        createdAt: '2023',
        createdBy: 'aCreator',
        createdByDevice: 'aCreatorDeviceId',
        expiresAt: '2023',
        mimetype: 'aMimetype',
        isOwn: true,
        title: 'aTitle',
        truncatedReference: 'aTruncatedReference',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'filename': 'aFilename',
          'filesize': 1,
          'createdAt': '2023',
          'createdBy': 'aCreator',
          'createdByDevice': 'aCreatorDeviceId',
          'expiresAt': '2023',
          'mimetype': 'aMimetype',
          'isOwn': true,
          'title': 'aTitle',
          'truncatedReference': 'aTruncatedReference',
        }),
      );
    });

    test('is correctly converted with property "description"', () {
      const dto = FileDTO(
        id: 'anId',
        filename: 'aFilename',
        filesize: 1,
        createdAt: '2023',
        createdBy: 'aCreator',
        createdByDevice: 'aCreatorDeviceId',
        expiresAt: '2023',
        mimetype: 'aMimetype',
        isOwn: true,
        title: 'aTitle',
        description: 'aDescription',
        truncatedReference: 'aTruncatedReference',
      );
      final dtoJson = dto.toJson();
      expect(
        dtoJson,
        equals({
          'id': 'anId',
          'filename': 'aFilename',
          'filesize': 1,
          'createdAt': '2023',
          'createdBy': 'aCreator',
          'createdByDevice': 'aCreatorDeviceId',
          'expiresAt': '2023',
          'mimetype': 'aMimetype',
          'isOwn': true,
          'title': 'aTitle',
          'description': 'aDescription',
          'truncatedReference': 'aTruncatedReference',
        }),
      );
    });
  });

  group('FileDTO fromJson', () {
    test('is correctly converted', () {
      final json = {
        'id': 'anId',
        'filename': 'aFilename',
        'filesize': 1,
        'createdAt': '2023',
        'createdBy': 'aCreator',
        'createdByDevice': 'aCreatorDeviceId',
        'expiresAt': '2023',
        'mimetype': 'aMimetype',
        'isOwn': true,
        'title': 'aTitle',
        'truncatedReference': 'aTruncatedReference',
      };
      expect(
        FileDTO.fromJson(json),
        equals(const FileDTO(
          id: 'anId',
          filename: 'aFilename',
          filesize: 1,
          createdAt: '2023',
          createdBy: 'aCreator',
          createdByDevice: 'aCreatorDeviceId',
          expiresAt: '2023',
          mimetype: 'aMimetype',
          isOwn: true,
          title: 'aTitle',
          truncatedReference: 'aTruncatedReference',
        )),
      );
    });

    test('is correctly converted with property "description"', () {
      final json = {
        'id': 'anId',
        'filename': 'aFilename',
        'filesize': 1,
        'createdAt': '2023',
        'createdBy': 'aCreator',
        'createdByDevice': 'aCreatorDeviceId',
        'expiresAt': '2023',
        'mimetype': 'aMimetype',
        'isOwn': true,
        'title': 'aTitle',
        'description': 'aDescription',
        'truncatedReference': 'aTruncatedReference',
      };
      expect(
        FileDTO.fromJson(json),
        equals(const FileDTO(
          id: 'anId',
          filename: 'aFilename',
          filesize: 1,
          createdAt: '2023',
          createdBy: 'aCreator',
          createdByDevice: 'aCreatorDeviceId',
          expiresAt: '2023',
          mimetype: 'aMimetype',
          isOwn: true,
          title: 'aTitle',
          description: 'aDescription',
          truncatedReference: 'aTruncatedReference',
        )),
      );
    });
  });
}
