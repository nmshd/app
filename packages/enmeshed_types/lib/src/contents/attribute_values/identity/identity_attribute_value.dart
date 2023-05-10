import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'identity.dart';

abstract class IdentityAttributeValue extends Equatable {
  const IdentityAttributeValue();

  static IdentityAttributeValue fromJson(Map json) {
    final type = json['@type'];

    switch (type) {
      case 'AffiliationOrganization':
        return AffiliationOrganizationAttributeValue.fromJson(json);
      case 'AffiliationRole':
        return AffiliationRoleAttributeValue.fromJson(json);
      case 'AffiliationUnit':
        return AffiliationUnitAttributeValue.fromJson(json);
      case 'BirthCity':
        return BirthCityAttributeValue.fromJson(json);
      case 'BirthName':
        return BirthNameAttributeValue.fromJson(json);
      case 'BirthState':
        return BirthStateAttributeValue.fromJson(json);
      case 'City':
        return CityAttributeValue.fromJson(json);
      case 'DisplayName':
        return DisplayNameAttributeValue.fromJson(json);
      case 'FileReference':
        return FileReferenceAttributeValue.fromJson(json);
      case 'GivenName':
        return GivenNameAttributeValue.fromJson(json);
      case 'HonorificPrefix':
        return HonorificPrefixAttributeValue.fromJson(json);
      case 'HonorificSuffix':
        return HonorificSuffixAttributeValue.fromJson(json);
      case 'HouseNumber':
        return HouseNumberAttributeValue.fromJson(json);
      case 'JobTitle':
        return JobTitleAttributeValue.fromJson(json);
      case 'MiddleName':
        return MiddleNameAttributeValue.fromJson(json);
      case 'PhoneNumber':
        return PhoneNumberAttributeValue.fromJson(json);
      case 'Pseudonym':
        return PseudonymAttributeValue.fromJson(json);
      case 'State':
        return StateAttributeValue.fromJson(json);
      case 'Street':
        return StreetAttributeValue.fromJson(json);
      case 'Surname':
        return SurnameAttributeValue.fromJson(json);
      case 'ZipCode':
        return ZipCodeAttributeValue.fromJson(json);
      case 'Affiliation':
        return AffiliationAttributeValue.fromJson(json);
      case 'BirthCountry':
        return BirthCountryAttributeValue.fromJson(json);
      case 'BirthDate':
        return BirthDateAttributeValue.fromJson(json);
      case 'BirthDay':
        return BirthDayAttributeValue.fromJson(json);
      case 'BirthMonth':
        return BirthMonthAttributeValue.fromJson(json);
      case 'BirthPlace':
        return BirthPlaceAttributeValue.fromJson(json);
      case 'BirthYear':
        return BirthYearAttributeValue.fromJson(json);
      case 'Citizenship':
        return CitizenshipAttributeValue.fromJson(json);
      case 'CommunicationLanguage':
        return CommunicationLanguageAttributeValue.fromJson(json);
      case 'Country':
        return CountryAttributeValue.fromJson(json);
      case 'DeliveryBoxAddress':
        return DeliveryBoxAddressAttributeValue.fromJson(json);
      case 'EMailAddress':
        return EMailAddressAttributeValue.fromJson(json);
      case 'FaxNumber':
        return FaxNumberAttributeValue.fromJson(json);
      case 'Nationality':
        return NationalityAttributeValue.fromJson(json);
      case 'PersonName':
        return PersonNameAttributeValue.fromJson(json);
      case 'PostOfficeBoxAddress':
        return PostOfficeBoxAddressAttributeValue.fromJson(json);
      case 'Sex':
        return SexAttributeValue.fromJson(json);
      case 'StreetAddress':
        return StreetAddressAttributeValue.fromJson(json);
      case 'Website':
        return WebsiteAttributeValue.fromJson(json);
      default:
        throw Exception('Unknown IdentityAttributeValue: $type');
    }
  }

  @mustCallSuper
  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props;
}
