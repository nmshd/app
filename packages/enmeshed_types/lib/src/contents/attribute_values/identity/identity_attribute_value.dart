import '../attribute_value.dart';
import 'identity.dart';

abstract class IdentityAttributeValue extends AttributeValue {
  const IdentityAttributeValue(super.atType);

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
      'Affiliation' => AffiliationAttributeValue.fromJson(json),
      'BirthCountry' => BirthCountryAttributeValue.fromJson(json),
      'BirthDate' => BirthDateAttributeValue.fromJson(json),
      'BirthDay' => BirthDayAttributeValue.fromJson(json),
      'BirthMonth' => BirthMonthAttributeValue.fromJson(json),
      'BirthPlace' => BirthPlaceAttributeValue.fromJson(json),
      'BirthYear' => BirthYearAttributeValue.fromJson(json),
      'Citizenship' => CitizenshipAttributeValue.fromJson(json),
      'CommunicationLanguage' => CommunicationLanguageAttributeValue.fromJson(json),
      'Country' => CountryAttributeValue.fromJson(json),
      'DeliveryBoxAddress' => DeliveryBoxAddressAttributeValue.fromJson(json),
      'EMailAddress' => EMailAddressAttributeValue.fromJson(json),
      'FaxNumber' => FaxNumberAttributeValue.fromJson(json),
      'Nationality' => NationalityAttributeValue.fromJson(json),
      'PersonName' => PersonNameAttributeValue.fromJson(json),
      'PostOfficeBoxAddress' => PostOfficeBoxAddressAttributeValue.fromJson(json),
      'Sex' => SexAttributeValue.fromJson(json),
      'StreetAddress' => StreetAddressAttributeValue.fromJson(json),
      'Website' => WebsiteAttributeValue.fromJson(json),
      'SchematizedXML' => SchematizedXMLAttributeValue.fromJson(json),
      'Statement' => StatementAttributeValue.fromJson(json),
      _ => throw Exception('Unknown IdentityAttributeValue: $type'),
    };
  }
}
