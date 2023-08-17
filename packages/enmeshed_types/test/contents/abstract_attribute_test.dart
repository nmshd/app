import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('AbstractAttribute fromJson', () {
    test('parsed valid IdentityAttribute', () {
      final identityAttributeJson = {
        '@type': 'IdentityAttribute',
        'owner': 'anOwner',
        'value': const CityAttributeValue(value: 'aCity').toJson(),
      };
      final abstractAttribute = AbstractAttribute.fromJson(identityAttributeJson);
      expect(abstractAttribute, isA<IdentityAttribute>());
    });

    test('parsed valid RelationshipAttribute', () {
      final relationshipAttributeJson = {
        '@type': 'RelationshipAttribute',
        'owner': 'anOwner',
        'value': const ProprietaryBooleanAttributeValue(title: 'aTitle', value: true).toJson(),
        'key': 'aKey',
        'confidentiality': 'public',
      };
      final abstractAttribute = AbstractAttribute.fromJson(relationshipAttributeJson);
      expect(abstractAttribute, isA<RelationshipAttribute>());
    });
  });

  group('AbstractAttribute fromJson with wrong @type', () {
    test('throws an Exception', () {
      final invalidJson = {'@type': 'wrongType'};

      expect(() => AbstractAttribute.fromJson(invalidJson), throwsA(isA<Exception>()));
    });
  });

  group('AbstractAttribute toJson', () {
    test('is correctly converted', () {
      const mockAbstractAttribute = MockAbstractAttribute(owner: 'anOwner');

      final abstractAttributeJson = {'owner': 'anOwner'};

      expect(mockAbstractAttribute.toJson(), equals(abstractAttributeJson));
    });

    test('is correctly converted with properties "validFrom" and "validTo"', () {
      const mockAbstractAttribute = MockAbstractAttribute(owner: 'anOwner', validFrom: '1970', validTo: '1980');

      final abstractAttributeJson = {'owner': 'anOwner', 'validFrom': '1970', 'validTo': '1980'};

      expect(mockAbstractAttribute.toJson(), equals(abstractAttributeJson));
    });
  });
}

class MockAbstractAttribute extends AbstractAttribute {
  const MockAbstractAttribute({
    required super.owner,
    super.validFrom,
    super.validTo,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
    };
  }
}
