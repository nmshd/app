import '../attribute_value.dart';
import 'relationship.dart';

abstract class RelationshipAttributeValue extends AttributeValue {
  const RelationshipAttributeValue();

  factory RelationshipAttributeValue.fromJson(Map json) {
    final type = json['@type'];

    return switch (type) {
      'Consent' => ConsentAttributeValue.fromJson(json),
      'ProprietaryBoolean' => ProprietaryBooleanAttributeValue.fromJson(json),
      'ProprietaryCountry' => ProprietaryCountryAttributeValue.fromJson(json),
      'ProprietaryEMailAddress' => ProprietaryEMailAddressAttributeValue.fromJson(json),
      'ProprietaryFileReference' => ProprietaryFileReferenceAttributeValue.fromJson(json),
      'ProprietaryFloat' => ProprietaryFloatAttributeValue.fromJson(json),
      'ProprietaryHEXColor' => ProprietaryHEXColorAttributeValue.fromJson(json),
      'ProprietaryInteger' => ProprietaryIntegerAttributeValue.fromJson(json),
      'ProprietaryJSON' => ProprietaryJSONAttributeValue.fromJson(json),
      'ProprietaryLanguage' => ProprietaryLanguageAttributeValue.fromJson(json),
      'ProprietaryPhoneNumber' => ProprietaryPhoneNumberAttributeValue.fromJson(json),
      'ProprietaryString' => ProprietaryStringAttributeValue.fromJson(json),
      'ProprietaryURL' => ProprietaryURLAttributeValue.fromJson(json),
      'ProprietaryXML' => ProprietaryXMLAttributeValue.fromJson(json),
      _ => throw Exception('Unknown AbstractAttributeValue: $type'),
    };
  }
}
