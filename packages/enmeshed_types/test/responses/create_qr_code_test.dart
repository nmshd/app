import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('CreateQrCodeResponse toJson', () {
    test('is correctly converted', () {
      const response = CreateQrCodeResponse(qrCodeBytes: 'aQrCodeBytes');
      final responseJson = response.toJson();
      expect(
        responseJson,
        equals({'qrCodeBytes': 'aQrCodeBytes'}),
      );
    });
  });

  group('CreateQrCodeResponse fromJson', () {
    test('is correctly converted', () {
      final json = {'qrCodeBytes': 'aQrCodeBytes'};
      expect(
        CreateQrCodeResponse.fromJson(json),
        equals(const CreateQrCodeResponse(qrCodeBytes: 'aQrCodeBytes')),
      );
    });
  });
}
