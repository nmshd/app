import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'relationship.dart';

abstract class RelationshipAttributeValue extends Equatable {
  const RelationshipAttributeValue();

  static RelationshipAttributeValue fromJson(Map json) {
    final type = json['@type'];

    switch (type) {
      case 'Consent':
        return ConsentAttributeValue.fromJson(json);
      case 'ProprietaryBoolean':
        return ProprietaryBooleanAttributeValue.fromJson(json);
      case 'ProprietaryCountry':
        return ProprietaryCountryAttributeValue.fromJson(json);
      case 'ProprietaryEMailAddress':
        return ProprietaryEMailAddressAttributeValue.fromJson(json);
      case 'ProprietaryFileReference':
        return ProprietaryFileReferenceAttributeValue.fromJson(json);
      case 'ProprietaryFloat':
        return ProprietaryFloatAttributeValue.fromJson(json);
      case 'ProprietaryHEXColor':
        return ProprietaryHEXColorAttributeValue.fromJson(json);
      case 'ProprietaryInteger':
        return ProprietaryIntegerAttributeValue.fromJson(json);
      case 'ProprietaryJSON':
        return ProprietaryJSONAttributeValue.fromJson(json);
      case 'ProprietaryLanguage':
        return ProprietaryLanguageAttributeValue.fromJson(json);
      case 'ProprietaryPhoneNumber':
        return ProprietaryPhoneNumberAttributeValue.fromJson(json);
      case 'ProprietaryString':
        return ProprietaryStringAttributeValue.fromJson(json);
      case 'ProprietaryURL':
        return ProprietaryURLAttributeValue.fromJson(json);
      default:
        throw Exception('Unknown AbstractAttributeValue: $type');
    }
  }

  @mustCallSuper
  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props;
}
