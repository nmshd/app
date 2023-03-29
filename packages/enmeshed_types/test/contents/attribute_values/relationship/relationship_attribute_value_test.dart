import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Relationship Attribute Value from json correctly', () {
    test('RelationshipAttributeValue.fromJson should parse valid Consent correctly', () {
      final consentJson = {'@type': 'Consent', 'consent': 'aConsent'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(consentJson);
      expect(relationshipAttributeValue, isA<Consent>());
    });

    test('RelationshipAttributeValue.fromJson should parse valid ProprietaryBoolean correctly', () {
      final proprietaryBooleanJson = {'@type': 'ProprietaryBoolean', 'title': 'aTitle', 'value': true};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryBooleanJson);
      expect(relationshipAttributeValue, isA<ProprietaryBoolean>());
    });

    test('RelationshipAttributeValue.fromJson should parse valid ProprietaryCountry correctly', () {
      final proprietaryCountryJson = {'@type': 'ProprietaryCountry', 'title': 'aTitle', 'value': 'aCountry'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryCountryJson);
      expect(relationshipAttributeValue, isA<ProprietaryCountry>());
    });

    test('RelationshipAttributeValue.fromJson should parse valid ProprietaryEMailAddress correctly', () {
      final proprietaryEMailAddressJson = {'@type': 'ProprietaryEMailAddress', 'title': 'aTitle', 'value': 'test@test.com'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryEMailAddressJson);
      expect(relationshipAttributeValue, isA<ProprietaryEMailAddress>());
    });

    test('RelationshipAttributeValue.fromJson should parse valid ProprietaryFileReference correctly', () {
      final proprietaryFileReferenceJson = {'@type': 'ProprietaryFileReference', 'title': 'aTitle', 'value': 'aFileReference'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryFileReferenceJson);
      expect(relationshipAttributeValue, isA<ProprietaryFileReference>());
    });

    test('RelationshipAttributeValue.fromJson should parse valid ProprietaryFloat correctly', () {
      final proprietaryFloatJson = {'@type': 'ProprietaryFloat', 'title': 'aTitle', 'value': 10.5};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryFloatJson);
      expect(relationshipAttributeValue, isA<ProprietaryFloat>());
    });

    test('RelationshipAttributeValue.fromJson should parse valid ProprietaryHEXColor correctly', () {
      final proprietaryHEXColorJson = {'@type': 'ProprietaryHEXColor', 'title': 'aTitle', 'value': 'aHEXColor'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryHEXColorJson);
      expect(relationshipAttributeValue, isA<ProprietaryHEXColor>());
    });

    test('RelationshipAttributeValue.fromJson should parse valid ProprietaryInteger correctly', () {
      final proprietaryIntegerJson = {'@type': 'ProprietaryInteger', 'title': 'aTitle', 'value': 10};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryIntegerJson);
      expect(relationshipAttributeValue, isA<ProprietaryInteger>());
    });

    test('RelationshipAttributeValue.fromJson should parse valid ProprietaryJSON correctly', () {
      final proprietaryJSONJson = {
        '@type': 'ProprietaryJSON',
        'title': 'aTitle',
        'value': {'value': 'aValue'},
      };
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryJSONJson);
      expect(relationshipAttributeValue, isA<ProprietaryJSON>());
    });

    test('RelationshipAttributeValue.fromJson should parse valid ProprietaryLanguage correctly', () {
      final proprietaryLanguageJson = {'@type': 'ProprietaryLanguage', 'title': 'aTitle', 'value': 'aLanguage'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryLanguageJson);
      expect(relationshipAttributeValue, isA<ProprietaryLanguage>());
    });

    test('RelationshipAttributeValue.fromJson should parse valid ProprietaryPhoneNumber correctly', () {
      final proprietaryPhoneNumberJson = {'@type': 'ProprietaryPhoneNumber', 'title': 'aTitle', 'value': 'aPhoneNumber'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryPhoneNumberJson);
      expect(relationshipAttributeValue, isA<ProprietaryPhoneNumber>());
    });

    test('RelationshipAttributeValue.fromJson should parse valid ProprietaryString correctly', () {
      final proprietaryStringJson = {'@type': 'ProprietaryString', 'title': 'aTitle', 'value': 'aString'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryStringJson);
      expect(relationshipAttributeValue, isA<ProprietaryString>());
    });

    test('RelationshipAttributeValue.fromJson should parse valid ProprietaryURL correctly', () {
      final proprietaryURLJson = {'@type': 'ProprietaryURL', 'title': 'aTitle', 'value': 'www.test.com'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryURLJson);
      expect(relationshipAttributeValue, isA<ProprietaryURL>());
    });
  });

  group('Relationship Attribute Value from json with exception', () {
    test('RelationshipAttributeValue.fromJson with wrong @type should throw an Exception', () {
      final invalidJson = {'@type': 'wrongType'};

      expect(() => RelationshipAttributeValue.fromJson(invalidJson), throwsA(isA<Exception>()));
    });
  });
}
