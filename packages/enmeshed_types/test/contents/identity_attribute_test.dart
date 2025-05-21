import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('IdentityAttribute toJson', () {
    test('is correctly converted', () {
      const identityAttribute = IdentityAttribute(
        owner: 'anOwner',
        value: CityAttributeValue(value: 'aCity'),
      );
      final identityAttributeJson = identityAttribute.toJson();
      expect(
        identityAttributeJson,
        equals({'@type': 'IdentityAttribute', 'owner': 'anOwner', 'value': const CityAttributeValue(value: 'aCity').toJson()}),
      );
    });

    test('is correctly converted with property "tags"', () {
      const identityAttribute = IdentityAttribute(
        owner: 'anOwner',
        value: CityAttributeValue(value: 'aCity'),
        tags: ['tag1', 'tag2'],
      );
      final identityAttributeJson = identityAttribute.toJson();
      expect(
        identityAttributeJson,
        equals({
          '@type': 'IdentityAttribute',
          'owner': 'anOwner',
          'value': const CityAttributeValue(value: 'aCity').toJson(),
          'tags': ['tag1', 'tag2'],
        }),
      );
    });

    test('is correctly converted with properties "validFrom" and "validTo"', () {
      const identityAttribute = IdentityAttribute(
        owner: 'anOwner',
        value: CityAttributeValue(value: 'aCity'),
        validFrom: '1970',
        validTo: '1980',
      );
      final identityAttributeJson = identityAttribute.toJson();
      expect(
        identityAttributeJson,
        equals({
          '@type': 'IdentityAttribute',
          'owner': 'anOwner',
          'value': const CityAttributeValue(value: 'aCity').toJson(),
          'validFrom': '1970',
          'validTo': '1980',
        }),
      );
    });

    test('is correctly converted with properties "validFrom", "validTo" and "tags"', () {
      const identityAttribute = IdentityAttribute(
        owner: 'anOwner',
        value: CityAttributeValue(value: 'aCity'),
        validFrom: '1970',
        validTo: '1980',
        tags: ['tag1', 'tag2'],
      );
      final identityAttributeJson = identityAttribute.toJson();
      expect(
        identityAttributeJson,
        equals({
          '@type': 'IdentityAttribute',
          'owner': 'anOwner',
          'value': const CityAttributeValue(value: 'aCity').toJson(),
          'validFrom': '1970',
          'validTo': '1980',
          'tags': ['tag1', 'tag2'],
        }),
      );
    });
  });

  group('IdentityAttribute fromJson', () {
    test('is correctly converted', () {
      final json = {'owner': 'anOwner', 'value': const CityAttributeValue(value: 'aCity').toJson()};
      expect(
        IdentityAttribute.fromJson(json),
        equals(
          const IdentityAttribute(
            owner: 'anOwner',
            value: CityAttributeValue(value: 'aCity'),
          ),
        ),
      );
    });

    test('is correctly converted with property "tags"', () {
      final json = {
        'owner': 'anOwner',
        'value': const CityAttributeValue(value: 'aCity').toJson(),
        'tags': ['tag1', 'tag2'],
      };
      expect(
        IdentityAttribute.fromJson(json),
        equals(
          const IdentityAttribute(
            owner: 'anOwner',
            value: CityAttributeValue(value: 'aCity'),
            tags: ['tag1', 'tag2'],
          ),
        ),
      );
    });

    test('is correctly converted with properties "validFrom" and "validTo"', () {
      final json = {'owner': 'anOwner', 'value': const CityAttributeValue(value: 'aCity').toJson(), 'validFrom': '1970', 'validTo': '1980'};
      expect(
        IdentityAttribute.fromJson(json),
        equals(
          const IdentityAttribute(
            owner: 'anOwner',
            value: CityAttributeValue(value: 'aCity'),
            validFrom: '1970',
            validTo: '1980',
          ),
        ),
      );
    });

    test('is correctly converted with properties "validFrom", "validTo" and "tags"', () {
      final json = {
        'owner': 'anOwner',
        'value': const CityAttributeValue(value: 'aCity').toJson(),
        'validFrom': '1970',
        'validTo': '1980',
        'tags': ['tag1', 'tag2'],
      };
      expect(
        IdentityAttribute.fromJson(json),
        equals(
          const IdentityAttribute(
            owner: 'anOwner',
            value: CityAttributeValue(value: 'aCity'),
            validFrom: '1970',
            validTo: '1980',
            tags: ['tag1', 'tag2'],
          ),
        ),
      );
    });
  });
}
