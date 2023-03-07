import 'package:meta/meta.dart';

import 'relationship.dart';

abstract class RelationshipAttributeValue {
  static RelationshipAttributeValue fromJson(Map<String, dynamic> json) {
    final type = json['@type'];

    switch (type) {
      case 'Consent':
        return Consent.fromJson(json);
      case 'ProprietaryBoolean':
        return ProprietaryBoolean.fromJson(json);
      case 'ProprietaryCountry':
        return ProprietaryCountry.fromJson(json);
      case 'ProprietaryEMailAddress':
        return ProprietaryEMailAddress.fromJson(json);
      case 'ProprietaryFileReference':
        return ProprietaryFileReference.fromJson(json);
      case 'ProprietaryFloat':
        return ProprietaryFloat.fromJson(json);
      case 'ProprietaryHEXColor':
        return ProprietaryHEXColor.fromJson(json);
      case 'ProprietaryInteger':
        return ProprietaryInteger.fromJson(json);
      case 'ProprietaryJSON':
        return ProprietaryJSON.fromJson(json);
      case 'ProprietaryLanguage':
        return ProprietaryLanguage.fromJson(json);
      case 'ProprietaryPhoneNumber':
        return ProprietaryPhoneNumber.fromJson(json);
      case 'ProprietaryString':
        return ProprietaryString.fromJson(json);
      case 'ProprietaryURL':
        return ProprietaryURL.fromJson(json);
      default:
        throw Exception('Unknown AbstractAttributeValue: $type');
    }
  }

  @mustCallSuper
  Map<String, dynamic> toJson();
}
