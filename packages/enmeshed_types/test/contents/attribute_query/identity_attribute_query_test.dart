import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Identity Attribute Query to json', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('valid IdentityAttributeQuery', () {
      final identityAttributeQuery = IdentityAttributeQuery(valueType: 'StreetAddress');
      expect(identityAttributeQuery.toJson(), equals({'@type': 'IdentityAttributeQuery', 'valueType': 'StreetAddress'}));
    });

    test('valid IdentityAttributeQuery with tags', () {
      final identityAttributeQuery = IdentityAttributeQuery(valueType: 'StreetAddress', tags: const ['tag1', 'tag2']);
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
      final identityAttributeQuery = IdentityAttributeQuery(valueType: 'StreetAddress', validFrom: '20220131', validTo: '20230131');
      expect(
        identityAttributeQuery.toJson(),
        equals({'@type': 'IdentityAttributeQuery', 'valueType': 'StreetAddress', 'validFrom': '20220131', 'validTo': '20230131'}),
      );
    });

    test('valid IdentityAttributeQuery with validFrom, validTo and tags', () {
      final identityAttributeQuery =
          IdentityAttributeQuery(valueType: 'StreetAddress', validFrom: '20220131', validTo: '20230131', tags: const ['tag1', 'tag2']);
      expect(
        identityAttributeQuery.toJson(),
        equals({
          '@type': 'IdentityAttributeQuery',
          'valueType': 'StreetAddress',
          'validFrom': '20220131',
          'validTo': '20230131',
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
      expect(IdentityAttributeQuery.fromJson(json).valueType, equals('StreetAddress'));
    });

    test('valid IdentityAttributeQuery with tags', () {
      final json = {
        'valueType': 'StreetAddress',
        'tags': ['tag1', 'tag2'],
      };

      expect(IdentityAttributeQuery.fromJson(json).valueType, equals('StreetAddress'));
      expect(IdentityAttributeQuery.fromJson(json).tags, equals(['tag1', 'tag2']));
    });

    test('valid IdentityAttributeQuery with validFrom and validTo', () {
      final json = {
        'valueType': 'StreetAddress',
        'validFrom': '20220131',
        'validTo': '20230131',
      };

      expect(IdentityAttributeQuery.fromJson(json).valueType, equals('StreetAddress'));
      expect(IdentityAttributeQuery.fromJson(json).validFrom, equals('20220131'));
      expect(IdentityAttributeQuery.fromJson(json).validTo, equals('20230131'));
    });

    test('valid IdentityAttributeQuery with validFrom, validTo and tags', () {
      final json = {
        'valueType': 'StreetAddress',
        'tags': ['tag1', 'tag2'],
        'validFrom': '20220131',
        'validTo': '20230131',
      };

      expect(IdentityAttributeQuery.fromJson(json).valueType, equals('StreetAddress'));
      expect(IdentityAttributeQuery.fromJson(json).tags, equals(['tag1', 'tag2']));
      expect(IdentityAttributeQuery.fromJson(json).validFrom, equals('20220131'));
      expect(IdentityAttributeQuery.fromJson(json).validTo, equals('20230131'));
    });
  });
}
