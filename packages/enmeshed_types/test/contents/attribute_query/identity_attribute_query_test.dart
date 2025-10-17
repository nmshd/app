import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('IdentityAttributeQuery toJson', () {
    test('is correctly converted', () {
      const identityAttributeQuery = IdentityAttributeQuery(valueType: 'StreetAddress');
      final identityJson = identityAttributeQuery.toJson();
      expect(identityJson, equals({'@type': 'IdentityAttributeQuery', 'valueType': 'StreetAddress'}));
    });

    test('is correctly converted with property "tags"', () {
      const identityAttributeQuery = IdentityAttributeQuery(valueType: 'StreetAddress', tags: ['tag1', 'tag2']);
      expect(
        identityAttributeQuery.toJson(),
        equals({
          '@type': 'IdentityAttributeQuery',
          'valueType': 'StreetAddress',
          'tags': ['tag1', 'tag2'],
        }),
      );
    });
  });

  group('IdentityAttributeQuery fromJson', () {
    test('is correctly converted', () {
      final json = {'valueType': 'StreetAddress'};
      expect(IdentityAttributeQuery.fromJson(json), equals(const IdentityAttributeQuery(valueType: 'StreetAddress')));
    });

    test('is correctly converted with property "tags"', () {
      final json = {
        'valueType': 'StreetAddress',
        'tags': ['tag1', 'tag2'],
      };

      expect(IdentityAttributeQuery.fromJson(json), equals(const IdentityAttributeQuery(valueType: 'StreetAddress', tags: ['tag1', 'tag2'])));
    });
  });
}
