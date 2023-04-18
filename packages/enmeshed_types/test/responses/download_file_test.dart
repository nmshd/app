import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('DownloadFileResponse toJson', () {
    test('is correctly converted', () {
      const response = DownloadFileResponse(content: [1, 2, 3], filename: 'test.txt', mimeType: 'text/plain');
      final responseJson = response.toJson();
      expect(
        responseJson,
        equals({
          'content': [1, 2, 3],
          'filename': 'test.txt',
          'mimetype': 'text/plain',
        }),
      );
    });
  });

  group('DownloadFileResponse fromJson', () {
    test('is correctly converted', () {
      final json = {
        'content': [1, 2, 3],
        'filename': 'test.txt',
        'mimetype': 'text/plain',
      };
      expect(
        DownloadFileResponse.fromJson(json),
        equals(const DownloadFileResponse(content: [1, 2, 3], filename: 'test.txt', mimeType: 'text/plain')),
      );
    });
  });
}
