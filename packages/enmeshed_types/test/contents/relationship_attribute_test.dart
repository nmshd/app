import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipAttribute toJson', () {
    test('is correctly converted', () {
      const relationshipAttribute = RelationshipAttribute(
        owner: 'anOwner',
        value: ProprietaryBoolean(title: 'aTitle', value: true),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
      );
      final relationshipAttributeJson = relationshipAttribute.toJson();
      expect(
        relationshipAttributeJson,
        equals({
          '@type': 'RelationshipAttribute',
          'owner': 'anOwner',
          'value': const ProprietaryBoolean(title: 'aTitle', value: true).toJson(),
          'key': 'aKey',
          'confidentiality': 'public',
        }),
      );
    });

    test('is correctly converted with properties "validFrom" and "validTo"', () {
      const relationshipAttribute = RelationshipAttribute(
        owner: 'anOwner',
        validFrom: '1970',
        validTo: '1980',
        value: ProprietaryBoolean(title: 'aTitle', value: true),
        key: 'aKey',
        confidentiality: RelationshipAttributeConfidentiality.public,
      );
      final relationshipAttributeJson = relationshipAttribute.toJson();
      expect(
        relationshipAttributeJson,
        equals({
          '@type': 'RelationshipAttribute',
          'owner': 'anOwner',
          'validFrom': '1970',
          'validTo': '1980',
          'value': const ProprietaryBoolean(title: 'aTitle', value: true).toJson(),
          'key': 'aKey',
          'confidentiality': 'public',
        }),
      );
    });

    test('is correctly converted with property "isTechnical"', () {
      const relationshipAttribute = RelationshipAttribute(
        owner: 'anOwner',
        value: ProprietaryBoolean(title: 'aTitle', value: true),
        key: 'aKey',
        isTechnical: true,
        confidentiality: RelationshipAttributeConfidentiality.public,
      );
      final relationshipAttributeJson = relationshipAttribute.toJson();
      expect(
        relationshipAttributeJson,
        equals({
          '@type': 'RelationshipAttribute',
          'owner': 'anOwner',
          'value': const ProprietaryBoolean(title: 'aTitle', value: true).toJson(),
          'key': 'aKey',
          'isTechnical': true,
          'confidentiality': 'public',
        }),
      );
    });

    test('is correctly converted with properties "validFrom", "validTo" and "isTechnical"', () {
      const relationshipAttribute = RelationshipAttribute(
        owner: 'anOwner',
        validFrom: '1970',
        validTo: '1980',
        value: ProprietaryBoolean(title: 'aTitle', value: true),
        key: 'aKey',
        isTechnical: true,
        confidentiality: RelationshipAttributeConfidentiality.public,
      );
      final relationshipAttributeJson = relationshipAttribute.toJson();
      expect(
        relationshipAttributeJson,
        equals({
          '@type': 'RelationshipAttribute',
          'owner': 'anOwner',
          'validFrom': '1970',
          'validTo': '1980',
          'value': const ProprietaryBoolean(title: 'aTitle', value: true).toJson(),
          'key': 'aKey',
          'isTechnical': true,
          'confidentiality': 'public',
        }),
      );
    });
  });

  group('RelationshipAttribute fromJson', () {
    test('is correctly converted', () {
      final json = {
        'owner': 'anOwner',
        'value': const ProprietaryBoolean(title: 'aTitle', value: true).toJson(),
        'key': 'aKey',
        'confidentiality': 'public',
      };
      expect(
        RelationshipAttribute.fromJson(json),
        equals(const RelationshipAttribute(
          owner: 'anOwner',
          value: ProprietaryBoolean(title: 'aTitle', value: true),
          key: 'aKey',
          confidentiality: RelationshipAttributeConfidentiality.public,
        )),
      );
    });

    test('is correctly converted with properties "validFrom" and "validTo"', () {
      final json = {
        'owner': 'anOwner',
        'validFrom': '1970',
        'validTo': '1980',
        'value': const ProprietaryBoolean(title: 'aTitle', value: true).toJson(),
        'key': 'aKey',
        'confidentiality': 'public',
      };
      expect(
        RelationshipAttribute.fromJson(json),
        equals(const RelationshipAttribute(
          owner: 'anOwner',
          validFrom: '1970',
          validTo: '1980',
          value: ProprietaryBoolean(title: 'aTitle', value: true),
          key: 'aKey',
          confidentiality: RelationshipAttributeConfidentiality.public,
        )),
      );
    });

    test('is correctly converted with property "isTechnical"', () {
      final json = {
        'owner': 'anOwner',
        'value': const ProprietaryBoolean(title: 'aTitle', value: true).toJson(),
        'key': 'aKey',
        'isTechnical': true,
        'confidentiality': 'public',
      };
      expect(
        RelationshipAttribute.fromJson(json),
        equals(const RelationshipAttribute(
          owner: 'anOwner',
          value: ProprietaryBoolean(title: 'aTitle', value: true),
          key: 'aKey',
          isTechnical: true,
          confidentiality: RelationshipAttributeConfidentiality.public,
        )),
      );
    });

    test('is correctly converted with properties "validFrom", "validTo" and "isTechnical"', () {
      final json = {
        'owner': 'anOwner',
        'validFrom': '1970',
        'validTo': '1980',
        'value': const ProprietaryBoolean(title: 'aTitle', value: true).toJson(),
        'key': 'aKey',
        'isTechnical': true,
        'confidentiality': 'public',
      };
      expect(
        RelationshipAttribute.fromJson(json),
        equals(const RelationshipAttribute(
          owner: 'anOwner',
          validFrom: '1970',
          validTo: '1980',
          value: ProprietaryBoolean(title: 'aTitle', value: true),
          key: 'aKey',
          isTechnical: true,
          confidentiality: RelationshipAttributeConfidentiality.public,
        )),
      );
    });
  });
}
