import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Identity Attribute Query to json', () {
    test('valid IdentityAttributeQuery', () {
      const identityAttributeQuery = IdentityAttributeQuery(valueType: 'StreetAddress');
      final identityJson = identityAttributeQuery.toJson();
      expect(
        identityJson,
        equals({
          '@type': 'IdentityAttributeQuery',
          'valueType': 'StreetAddress',
        }),
      );
    });

    test('valid IdentityAttributeQuery with tags', () {
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

    test('valid IdentityAttributeQuery with validFrom and validTo', () {
      const identityAttributeQuery = IdentityAttributeQuery(valueType: 'StreetAddress', validFrom: '1970', validTo: '1980');
      expect(
        identityAttributeQuery.toJson(),
        equals({
          '@type': 'IdentityAttributeQuery',
          'valueType': 'StreetAddress',
          'validFrom': '1970',
          'validTo': '1980',
        }),
      );
    });

    test('valid IdentityAttributeQuery with validFrom, validTo and tags', () {
      const identityAttributeQuery = IdentityAttributeQuery(
        valueType: 'StreetAddress',
        validFrom: '1970',
        validTo: '1980',
        tags: ['tag1', 'tag2'],
      );
      expect(
        identityAttributeQuery.toJson(),
        equals({
          '@type': 'IdentityAttributeQuery',
          'valueType': 'StreetAddress',
          'validFrom': '1970',
          'validTo': '1980',
          'tags': ['tag1', 'tag2'],
        }),
      );
    });
  });

  group('Identity Attribute Query from json', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('valid IdentityAttributeQuery', () {
      final json = {'valueType': 'StreetAddress'};
      expect(IdentityAttributeQuery.fromJson(json), equals(const IdentityAttributeQuery(valueType: 'StreetAddress')));
    });

    test('valid IdentityAttributeQuery with tags', () {
      final json = {
        'valueType': 'StreetAddress',
        'tags': ['tag1', 'tag2'],
      };

      expect(IdentityAttributeQuery.fromJson(json), equals(const IdentityAttributeQuery(valueType: 'StreetAddress', tags: ['tag1', 'tag2'])));
    });

    test('valid IdentityAttributeQuery with validFrom and validTo', () {
      final json = {
        'valueType': 'StreetAddress',
        'validFrom': '1970',
        'validTo': '1970',
      };

      expect(
        IdentityAttributeQuery.fromJson(json),
        equals(const IdentityAttributeQuery(
          valueType: 'StreetAddress',
          validFrom: '1970',
          validTo: '1970',
        )),
      );
    });

    test('valid IdentityAttributeQuery with validFrom, validTo and tags', () {
      final json = {
        'valueType': 'StreetAddress',
        'tags': ['tag1', 'tag2'],
        'validFrom': '1970',
        'validTo': '1980',
      };

      expect(
        IdentityAttributeQuery.fromJson(json),
        equals(const IdentityAttributeQuery(
          valueType: 'StreetAddress',
          validFrom: '1970',
          validTo: '1980',
          tags: ['tag1', 'tag2'],
        )),
      );
    });
  });
}
