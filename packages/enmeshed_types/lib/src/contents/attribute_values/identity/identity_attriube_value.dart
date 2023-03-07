import 'package:meta/meta.dart';

import 'identity.dart';

abstract class IdentityAttributeValue {
  static IdentityAttributeValue fromJson(Map<String, dynamic> json) {
    final type = json['@type'];

    switch (type) {
      case 'AffiliationOrganization':
        return AffiliationOrganization.fromJson(json);
      case 'AffiliationRole':
        return AffiliationRole.fromJson(json);
      case 'AffiliationUnit':
        return AffiliationUnit.fromJson(json);
      case 'BirthCity':
        return BirthCity.fromJson(json);
      case 'BirthName':
        return BirthName.fromJson(json);
      case 'BirthState':
        return BirthState.fromJson(json);
      case 'City':
        return City.fromJson(json);
      case 'DisplayName':
        return DisplayName.fromJson(json);
      case 'FileReference':
        return FileReference.fromJson(json);
      case 'GivenName':
        return GivenName.fromJson(json);
      case 'HonorificPrefix':
        return HonorificPrefix.fromJson(json);
      case 'HonorificSuffix':
        return HonorificSuffix.fromJson(json);
      case 'HouseNumber':
        return HouseNumber.fromJson(json);
      case 'JobTitle':
        return JobTitle.fromJson(json);
      case 'MiddleName':
        return MiddleName.fromJson(json);
      case 'PhoneNumber':
        return PhoneNumber.fromJson(json);
      case 'Pseudonym':
        return Pseudonym.fromJson(json);
      case 'State':
        return StateAttribute.fromJson(json);
      case 'Street':
        return Street.fromJson(json);
      case 'Surname':
        return Surname.fromJson(json);
      case 'ZipCode':
        return ZipCode.fromJson(json);
      case 'Affiliation':
        return Affiliation.fromJson(json);
      case 'BirthCountry':
        return BirthCountry.fromJson(json);
      case 'BirthDate':
        return BirthDate.fromJson(json);
      case 'BirthDay':
        return BirthDay.fromJson(json);
      case 'BirthMonth':
        return BirthMonth.fromJson(json);
      case 'BirthPlace':
        return BirthPlace.fromJson(json);
      case 'BirthYear':
        return BirthYear.fromJson(json);
      case 'Citizenship':
        return Citizenship.fromJson(json);
      case 'CommunicationLanguage':
        return CommunicationLanguage.fromJson(json);
      case 'Country':
        return Country.fromJson(json);
      case 'DeliveryBoxAddress':
        return DeliveryBoxAddress.fromJson(json);
      case 'EMailAddress':
        return EMailAddress.fromJson(json);
      case 'FaxNumber':
        return FaxNumber.fromJson(json);
      case 'Nationality':
        return Nationality.fromJson(json);
      case 'PersonName':
        return PersonName.fromJson(json);
      case 'PostOfficeBoxAddress':
        return PostOfficeBoxAddress.fromJson(json);
      case 'Sex':
        return Sex.fromJson(json);
      case 'StreetAddress':
        return StreetAddress.fromJson(json);
      case 'Website':
        return Website.fromJson(json);
      default:
        throw Exception('Unknown IdentityAttributeValue: $type');
    }
  }

  @mustCallSuper
  Map<String, dynamic> toJson();
}
