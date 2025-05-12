import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('LoadItemFromReferenceResponse toJson', () {
    test('is correctly converted', () {
      const response = LoadItemFromReferenceResponse(type: LoadItemFromReferenceResponseType.File, value: {'aKey': 'aValue'});
      final responseJson = response.toJson();

      expect(
        responseJson,
        equals({
          'type': 'File',
          'value': {'aKey': 'aValue'},
        }),
      );
    });
  });

  group('LoadItemFromReferenceResponse fromJson', () {
    test('is correctly converted', () {
      final json = {
        'type': 'File',
        'value': {'aKey': 'aValue'},
      };

      expect(
        LoadItemFromReferenceResponse.fromJson(json),
        equals(const LoadItemFromReferenceResponse(type: LoadItemFromReferenceResponseType.File, value: {'aKey': 'aValue'})),
      );
    });
  });
}
