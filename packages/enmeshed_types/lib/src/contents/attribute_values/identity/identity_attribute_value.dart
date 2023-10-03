import '../attribute_value.dart';
import 'identity.dart';

abstract class IdentityAttributeValue extends AttributeValue {
  const IdentityAttributeValue();

  factory IdentityAttributeValue.fromJson(Map json) {
    final type = json['@type'];

    return switch (type) {
      'AffiliationOrganization' => AffiliationOrganizationAttributeValue.fromJson(json),
      'AffiliationRole' => AffiliationRoleAttributeValue.fromJson(json),
      'AffiliationUnit' => AffiliationUnitAttributeValue.fromJson(json),
      'BirthCity' => BirthCityAttributeValue.fromJson(json),
      'BirthName' => BirthNameAttributeValue.fromJson(json),
      'BirthState' => BirthStateAttributeValue.fromJson(json),
      'City' => CityAttributeValue.fromJson(json),
      'DisplayName' => DisplayNameAttributeValue.fromJson(json),
      'IdentityFileReference' => IdentityFileReferenceAttributeValue.fromJson(json),
      'GivenName' => GivenNameAttributeValue.fromJson(json),
      'HonorificPrefix' => HonorificPrefixAttributeValue.fromJson(json),
      'HonorificSuffix' => HonorificSuffixAttributeValue.fromJson(json),
      'HouseNumber' => HouseNumberAttributeValue.fromJson(json),
      'JobTitle' => JobTitleAttributeValue.fromJson(json),
      'MiddleName' => MiddleNameAttributeValue.fromJson(json),
      'PhoneNumber' => PhoneNumberAttributeValue.fromJson(json),
      'Pseudonym' => PseudonymAttributeValue.fromJson(json),
      'State' => StateAttributeValue.fromJson(json),
      'Street' => StreetAttributeValue.fromJson(json),
      'Surname' => SurnameAttributeValue.fromJson(json),
      'ZipCode' => ZipCodeAttributeValue.fromJson(json),
      'Affiliation' => AffiliationAttributeValue.fromJson(json), // TODO: 
      'BirthCountry' => BirthCountryAttributeValue.fromJson(json),
      'BirthDate' => BirthDateAttributeValue.fromJson(json), // TODO: 
      'BirthDay' => BirthDayAttributeValue.fromJson(json), // TODO: int
      'BirthMonth' => BirthMonthAttributeValue.fromJson(json), // TODO: int
      'BirthPlace' => BirthPlaceAttributeValue.fromJson(json), // TODO: 
      'BirthYear' => BirthYearAttributeValue.fromJson(json), // TODO: int
      'Citizenship' => CitizenshipAttributeValue.fromJson(json),
      'CommunicationLanguage' => CommunicationLanguageAttributeValue.fromJson(json),
      'Country' => CountryAttributeValue.fromJson(json),
      'DeliveryBoxAddress' => DeliveryBoxAddressAttributeValue.fromJson(json), // TODO: 
      'EMailAddress' => EMailAddressAttributeValue.fromJson(json),
      'FaxNumber' => FaxNumberAttributeValue.fromJson(json),
      'Nationality' => NationalityAttributeValue.fromJson(json),
      'PersonName' => PersonNameAttributeValue.fromJson(json), // TODO: 
      'PostOfficeBoxAddress' => PostOfficeBoxAddressAttributeValue.fromJson(json), // TODO: 
      'Sex' => SexAttributeValue.fromJson(json),
      'StreetAddress' => StreetAddressAttributeValue.fromJson(json), // TODO: 
      'Website' => WebsiteAttributeValue.fromJson(json),
      'SchematizedXML' => SchematizedXMLAttributeValue.fromJson(json), // TODO: 
      'Statement' => StatementAttributeValue.fromJson(json), // TODO: json
      _ => throw Exception('Unknown IdentityAttributeValue: $type'),
    };
  }
}
