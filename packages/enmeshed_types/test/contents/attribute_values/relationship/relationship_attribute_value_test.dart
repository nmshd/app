import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipAttributeValue fromJson correctly', () {
    test('parsed valid Consent', () {
      final consentJson = {'@type': 'Consent', 'consent': 'aConsent'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(consentJson);
      expect(relationshipAttributeValue, isA<Consent>());
    });

    test('parsed valid ProprietaryBoolean', () {
      final proprietaryBooleanJson = {'@type': 'ProprietaryBoolean', 'title': 'aTitle', 'value': true};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryBooleanJson);
      expect(relationshipAttributeValue, isA<ProprietaryBoolean>());
    });

    test('parsed valid ProprietaryCountry', () {
      final proprietaryCountryJson = {'@type': 'ProprietaryCountry', 'title': 'aTitle', 'value': 'aCountry'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryCountryJson);
      expect(relationshipAttributeValue, isA<ProprietaryCountry>());
    });

    test('parsed valid ProprietaryEMailAddress', () {
      final proprietaryEMailAddressJson = {'@type': 'ProprietaryEMailAddress', 'title': 'aTitle', 'value': 'test@test.com'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryEMailAddressJson);
      expect(relationshipAttributeValue, isA<ProprietaryEMailAddress>());
    });

    test('parsed valid ProprietaryFileReference', () {
      final proprietaryFileReferenceJson = {'@type': 'ProprietaryFileReference', 'title': 'aTitle', 'value': 'aFileReference'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryFileReferenceJson);
      expect(relationshipAttributeValue, isA<ProprietaryFileReference>());
    });

    test('parsed valid ProprietaryFloat', () {
      final proprietaryFloatJson = {'@type': 'ProprietaryFloat', 'title': 'aTitle', 'value': 10.5};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryFloatJson);
      expect(relationshipAttributeValue, isA<ProprietaryFloat>());
    });

    test('parsed valid ProprietaryHEXColor', () {
      final proprietaryHEXColorJson = {'@type': 'ProprietaryHEXColor', 'title': 'aTitle', 'value': 'aHEXColor'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryHEXColorJson);
      expect(relationshipAttributeValue, isA<ProprietaryHEXColor>());
    });

    test('parsed valid ProprietaryInteger', () {
      final proprietaryIntegerJson = {'@type': 'ProprietaryInteger', 'title': 'aTitle', 'value': 10};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryIntegerJson);
      expect(relationshipAttributeValue, isA<ProprietaryInteger>());
    });

    test('parsed valid ProprietaryJSON', () {
      final proprietaryJSONJson = {
        '@type': 'ProprietaryJSON',
        'title': 'aTitle',
        'value': {'value': 'aValue'},
      };
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryJSONJson);
      expect(relationshipAttributeValue, isA<ProprietaryJSON>());
    });

    test('parsed valid ProprietaryLanguage', () {
      final proprietaryLanguageJson = {'@type': 'ProprietaryLanguage', 'title': 'aTitle', 'value': 'aLanguage'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryLanguageJson);
      expect(relationshipAttributeValue, isA<ProprietaryLanguage>());
    });

    test('parsed valid ProprietaryPhoneNumber', () {
      final proprietaryPhoneNumberJson = {'@type': 'ProprietaryPhoneNumber', 'title': 'aTitle', 'value': 'aPhoneNumber'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryPhoneNumberJson);
      expect(relationshipAttributeValue, isA<ProprietaryPhoneNumber>());
    });

    test('parsed valid ProprietaryString', () {
      final proprietaryStringJson = {'@type': 'ProprietaryString', 'title': 'aTitle', 'value': 'aString'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryStringJson);
      expect(relationshipAttributeValue, isA<ProprietaryString>());
    });

    test('parsed valid ProprietaryURL', () {
      final proprietaryURLJson = {'@type': 'ProprietaryURL', 'title': 'aTitle', 'value': 'www.test.com'};
      final relationshipAttributeValue = RelationshipAttributeValue.fromJson(proprietaryURLJson);
      expect(relationshipAttributeValue, isA<ProprietaryURL>());
    });
  });

  group('RelationshipAttributeValue fromJson with wrong @type', () {
    test('throws an Exception', () {
      final invalidJson = {'@type': 'wrongType'};

      expect(() => RelationshipAttributeValue.fromJson(invalidJson), throwsA(isA<Exception>()));
    });
  });
}
