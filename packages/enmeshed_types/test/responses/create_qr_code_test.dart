import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('CreateQRCodeResponse toJson', () {
    test('is correctly converted', () {
      const response = CreateQRCodeResponse(qrCodeBytes: 'aQRCodeBytes');
      final responseJson = response.toJson();
      expect(
        responseJson,
        equals({'qrCodeBytes': 'aQRCodeBytes'}),
      );
    });
  });

  group('CreateQRCodeResponse fromJson', () {
    test('is correctly converted', () {
      final json = {'qrCodeBytes': 'aQRCodeBytes'};
      expect(
        CreateQRCodeResponse.fromJson(json),
        equals(const CreateQRCodeResponse(qrCodeBytes: 'aQRCodeBytes')),
      );
    });
  });
}
