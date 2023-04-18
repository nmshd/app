import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('LoadItemFromTruncatedReferenceResponse toJson', () {
    test('is correctly converted', () {
      const response = LoadItemFromTruncatedReferenceResponse(type: LoadItemFromTruncatedReferenceResponseType.File, value: {'aKey': 'aValue'});
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

  group('LoadItemFromTruncatedReferenceResponse fromJson', () {
    test('is correctly converted', () {
      final json = {
        'type': 'File',
        'value': {'aKey': 'aValue'},
      };
      expect(
        LoadItemFromTruncatedReferenceResponse.fromJson(json),
        equals(const LoadItemFromTruncatedReferenceResponse(type: LoadItemFromTruncatedReferenceResponseType.File, value: {'aKey': 'aValue'})),
      );
    });
  });
}
