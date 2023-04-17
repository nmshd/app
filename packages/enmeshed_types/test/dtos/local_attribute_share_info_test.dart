import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('LocalAttributeShareInfo toJson', () {
    test('is correctly converted', () {
      const localAttributeShareInfo = LocalAttributeShareInfo(requestReference: 'aRequestReference', peer: 'aPeer');
      final localAttributeShareInfoJson = localAttributeShareInfo.toJson();
      expect(
        localAttributeShareInfoJson,
        equals({'requestReference': 'aRequestReference', 'peer': 'aPeer'}),
      );
    });

    test('is correctly converted with property "sourceAttribute"', () {
      const localAttributeShareInfo = LocalAttributeShareInfo(
        requestReference: 'aRequestReference',
        peer: 'aPeer',
        sourceAttribute: 'aSourceAttribute',
      );
      final localAttributeShareInfoJson = localAttributeShareInfo.toJson();
      expect(
        localAttributeShareInfoJson,
        equals({'requestReference': 'aRequestReference', 'peer': 'aPeer', 'sourceAttribute': 'aSourceAttribute'}),
      );
    });
  });

  group('LocalAttributeShareInfo fromJson', () {
    test('is correctly converted', () {
      final json = {'requestReference': 'aRequestReference', 'peer': 'aPeer'};
      expect(
        LocalAttributeShareInfo.fromJson(json),
        equals(const LocalAttributeShareInfo(requestReference: 'aRequestReference', peer: 'aPeer')),
      );
    });

    test('is correctly converted with property "sourceAttribute"', () {
      final json = {'requestReference': 'aRequestReference', 'peer': 'aPeer', 'sourceAttribute': 'aSourceAttribute'};
      expect(
        LocalAttributeShareInfo.fromJson(json),
        equals(const LocalAttributeShareInfo(requestReference: 'aRequestReference', peer: 'aPeer', sourceAttribute: 'aSourceAttribute')),
      );
    });
  });
}
