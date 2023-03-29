import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('Identity Attribute Value from json correctly', () {
    test('IdentityAttributeValue.fromJson should parse valid AffiliationOrganization correctly', () {
      final affiliationOrganizationJson = {
        '@type': 'AffiliationOrganization',
        'value': 'anAffiliationOrganization',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(affiliationOrganizationJson);
      expect(identityAttributeValue, isA<AffiliationOrganization>());
    });

    test('IdentityAttributeValue.fromJson should parse valid AffiliationRole correctly', () {
      final affiliationRoleJson = {
        '@type': 'AffiliationRole',
        'value': 'anAffiliationRole',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(affiliationRoleJson);
      expect(identityAttributeValue, isA<AffiliationRole>());
    });

    test('IdentityAttributeValue.fromJson should parse valid AffiliationUnit correctly', () {
      final affiliationUnitJson = {
        '@type': 'AffiliationUnit',
        'value': 'anAffiliationUnit',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(affiliationUnitJson);
      expect(identityAttributeValue, isA<AffiliationUnit>());
    });

    test('IdentityAttributeValue.fromJson should parse valid BirthCity correctly', () {
      final birthCityJson = {
        '@type': 'BirthCity',
        'value': 'aBirthCity',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthCityJson);
      expect(identityAttributeValue, isA<BirthCity>());
    });

    test('IdentityAttributeValue.fromJson should parse valid BirthName correctly', () {
      final birthNameJson = {
        '@type': 'BirthName',
        'value': 'aBirthName',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthNameJson);
      expect(identityAttributeValue, isA<BirthName>());
    });

    test('IdentityAttributeValue.fromJson should parse valid BirthState correctly', () {
      final birthStateJson = {
        '@type': 'BirthState',
        'value': 'aBirthState',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthStateJson);
      expect(identityAttributeValue, isA<BirthState>());
    });

    test('IdentityAttributeValue.fromJson should parse valid City correctly', () {
      final cityJson = {
        '@type': 'City',
        'value': 'aCity',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(cityJson);
      expect(identityAttributeValue, isA<City>());
    });

    test('IdentityAttributeValue.fromJson should parse valid DisplayName correctly', () {
      final displayNameJson = {
        '@type': 'DisplayName',
        'value': 'aDisplayName',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(displayNameJson);
      expect(identityAttributeValue, isA<DisplayName>());
    });

    test('IdentityAttributeValue.fromJson should parse valid FileReference correctly', () {
      final fileReferenceJson = {
        '@type': 'FileReference',
        'value': 'aFileReference',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(fileReferenceJson);
      expect(identityAttributeValue, isA<FileReference>());
    });

    test('IdentityAttributeValue.fromJson should parse valid GivenName correctly', () {
      final givenNameJson = {
        '@type': 'GivenName',
        'value': 'aGivenName',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(givenNameJson);
      expect(identityAttributeValue, isA<GivenName>());
    });

    test('IdentityAttributeValue.fromJson should parse valid HonorificPrefix correctly', () {
      final honorificPrefixJson = {
        '@type': 'HonorificPrefix',
        'value': 'aHonorificPrefix',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(honorificPrefixJson);
      expect(identityAttributeValue, isA<HonorificPrefix>());
    });

    test('IdentityAttributeValue.fromJson should parse valid HonorificSuffix correctly', () {
      final honorificSuffixJson = {
        '@type': 'HonorificSuffix',
        'value': 'aHonorificSuffix',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(honorificSuffixJson);
      expect(identityAttributeValue, isA<HonorificSuffix>());
    });

    test('IdentityAttributeValue.fromJson should parse valid HouseNumber correctly', () {
      final houseNumberJson = {
        '@type': 'HouseNumber',
        'value': 'aHouseNumber',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(houseNumberJson);
      expect(identityAttributeValue, isA<HouseNumber>());
    });

    test('IdentityAttributeValue.fromJson should parse valid JobTitle correctly', () {
      final jobTitleJson = {
        '@type': 'JobTitle',
        'value': 'aJobTitle',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(jobTitleJson);
      expect(identityAttributeValue, isA<JobTitle>());
    });

    test('IdentityAttributeValue.fromJson should parse valid MiddleName correctly', () {
      final middleNameJson = {
        '@type': 'MiddleName',
        'value': 'aMiddleName',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(middleNameJson);
      expect(identityAttributeValue, isA<MiddleName>());
    });

    test('IdentityAttributeValue.fromJson should parse valid PhoneNumber correctly', () {
      final phoneNumberJson = {
        '@type': 'PhoneNumber',
        'value': 'aPhoneNumber',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(phoneNumberJson);
      expect(identityAttributeValue, isA<PhoneNumber>());
    });

    test('IdentityAttributeValue.fromJson should parse valid Pseudonym correctly', () {
      final pseudonymJson = {
        '@type': 'Pseudonym',
        'value': 'aPseudonym',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(pseudonymJson);
      expect(identityAttributeValue, isA<Pseudonym>());
    });

    test('IdentityAttributeValue.fromJson should parse valid State correctly', () {
      final stateJson = {
        '@type': 'State',
        'value': 'aState',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(stateJson);
      expect(identityAttributeValue, isA<State>());
    });

    test('IdentityAttributeValue.fromJson should parse valid Street correctly', () {
      final streetJson = {
        '@type': 'Street',
        'value': 'aStreet',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(streetJson);
      expect(identityAttributeValue, isA<Street>());
    });

    test('IdentityAttributeValue.fromJson should parse valid Surname correctly', () {
      final surnameJson = {
        '@type': 'Surname',
        'value': 'aSurname',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(surnameJson);
      expect(identityAttributeValue, isA<Surname>());
    });

    test('IdentityAttributeValue.fromJson should parse valid ZipCode correctly', () {
      final zipCodeJson = {
        '@type': 'ZipCode',
        'value': 'aZipCode',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(zipCodeJson);
      expect(identityAttributeValue, isA<ZipCode>());
    });

    test('IdentityAttributeValue.fromJson should parse valid Affiliation correctly', () {
      final affiliationJson = {
        '@type': 'Affiliation',
        'role': 'aRole',
        'organization': 'anOrganization',
        'unit': 'anUnit',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(affiliationJson);
      expect(identityAttributeValue, isA<Affiliation>());
    });

    test('IdentityAttributeValue.fromJson should parse valid BirthCountry correctly', () {
      final birthCountryJson = {
        '@type': 'BirthCountry',
        'value': 'DE',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthCountryJson);
      expect(identityAttributeValue, isA<BirthCountry>());
    });

    test('IdentityAttributeValue.fromJson should parse valid BirthDate correctly', () {
      final birthDateJson = {
        '@type': 'BirthDate',
        'day': 01,
        'month': 01,
        'year': 1970,
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthDateJson);
      expect(identityAttributeValue, isA<BirthDate>());
    });

    test('IdentityAttributeValue.fromJson should parse valid BirthDay correctly', () {
      final birthDayJson = {
        '@type': 'BirthDay',
        'value': 01,
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthDayJson);
      expect(identityAttributeValue, isA<BirthDay>());
    });

    test('IdentityAttributeValue.fromJson should parse valid BirthMonth correctly', () {
      final birthMonthJson = {
        '@type': 'BirthMonth',
        'value': 01,
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthMonthJson);
      expect(identityAttributeValue, isA<BirthMonth>());
    });

    test('IdentityAttributeValue.fromJson should parse valid BirthPlace correctly', () {
      final birthPlaceJson = {
        '@type': 'BirthPlace',
        'city': 'aCity',
        'country': 'aCountry',
        'state': 'aState',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthPlaceJson);
      expect(identityAttributeValue, isA<BirthPlace>());
    });

    test('IdentityAttributeValue.fromJson should parse valid BirthYear correctly', () {
      final birthYearJson = {
        '@type': 'BirthYear',
        'value': 01,
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthYearJson);
      expect(identityAttributeValue, isA<BirthYear>());
    });

    test('IdentityAttributeValue.fromJson should parse valid Citizenship correctly', () {
      final citizenshipJson = {
        '@type': 'Citizenship',
        'value': 'DE',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(citizenshipJson);
      expect(identityAttributeValue, isA<Citizenship>());
    });

    test('IdentityAttributeValue.fromJson should parse valid CommunicationLanguage correctly', () {
      final communicationLanguageJson = {
        '@type': 'CommunicationLanguage',
        'value': 'de',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(communicationLanguageJson);
      expect(identityAttributeValue, isA<CommunicationLanguage>());
    });

    test('IdentityAttributeValue.fromJson should parse valid Country correctly', () {
      final countryJson = {
        '@type': 'Country',
        'value': 'DE',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(countryJson);
      expect(identityAttributeValue, isA<Country>());
    });

    test('IdentityAttributeValue.fromJson should parse valid DeliveryBoxAddress correctly', () {
      final deliveryBoxAddressJson = {
        '@type': 'DeliveryBoxAddress',
        'recipient': 'aRecipient',
        'deliveryBoxId': 'aDeliveryBoxId',
        'userId': 'anUserId',
        'zipCode': 'aZipCode',
        'city': 'aCity',
        'country': 'aCountry',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(deliveryBoxAddressJson);
      expect(identityAttributeValue, isA<DeliveryBoxAddress>());
    });

    test('IdentityAttributeValue.fromJson should parse valid EMailAddress correctly', () {
      final eMailAddressJson = {
        '@type': 'EMailAddress',
        'value': 'test@test.com',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(eMailAddressJson);
      expect(identityAttributeValue, isA<EMailAddress>());
    });

    test('IdentityAttributeValue.fromJson should parse valid FaxNumber correctly', () {
      final faxNumberJson = {
        '@type': 'FaxNumber',
        'value': '0123456789',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(faxNumberJson);
      expect(identityAttributeValue, isA<FaxNumber>());
    });

    test('IdentityAttributeValue.fromJson should parse valid Nationality correctly', () {
      final nationalityJson = {
        '@type': 'Nationality',
        'value': 'DE',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(nationalityJson);
      expect(identityAttributeValue, isA<Nationality>());
    });

    test('IdentityAttributeValue.fromJson should parse valid PersonName correctly', () {
      final personNameJson = {
        '@type': 'PersonName',
        'givenName': 'aGivenName',
        'surname': 'aSurname',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(personNameJson);
      expect(identityAttributeValue, isA<PersonName>());
    });

    test('IdentityAttributeValue.fromJson should parse valid PostOfficeBoxAddress correctly', () {
      final postOfficeBoxAddressJson = {
        '@type': 'PostOfficeBoxAddress',
        'recipient': 'aRecipient',
        'boxId': 'aBoxId',
        'zipCode': 'aZipCode',
        'city': 'aCity',
        'country': 'DE',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(postOfficeBoxAddressJson);
      expect(identityAttributeValue, isA<PostOfficeBoxAddress>());
    });

    test('IdentityAttributeValue.fromJson should parse valid Sex correctly', () {
      final sexJson = {
        '@type': 'Sex',
        'value': 'male',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(sexJson);
      expect(identityAttributeValue, isA<Sex>());
    });

    test('IdentityAttributeValue.fromJson should parse valid StreetAddress correctly', () {
      final streetAddressJson = {
        '@type': 'StreetAddress',
        'recipient': 'aRecipient',
        'street': 'aStreet',
        'houseNumber': 'aHouseNo',
        'zipCode': 'aZipCode',
        'city': 'aCity',
        'country': 'DE',
        'state': 'aState',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(streetAddressJson);
      expect(identityAttributeValue, isA<StreetAddress>());
    });

    test('IdentityAttributeValue.fromJson should parse valid Website correctly', () {
      final websiteJson = {
        '@type': 'Website',
        'value': 'www.test.com',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(websiteJson);
      expect(identityAttributeValue, isA<Website>());
    });
  });

  group('Identity Attribute Value from json with exception', () {
    test('IdentityAttributeValue.fromJson with wrong @type should throw an Exception', () {
      final invalidJson = {'@type': 'wrongType'};

      expect(() => IdentityAttributeValue.fromJson(invalidJson), throwsA(isA<Exception>()));
    });
  });
}
