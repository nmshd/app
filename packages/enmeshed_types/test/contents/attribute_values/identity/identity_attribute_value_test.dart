import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('IdentityAttributeValue fromJson', () {
    test('parsed valid AffiliationOrganization', () {
      final affiliationOrganizationJson = {
        '@type': 'AffiliationOrganization',
        'value': 'anAffiliationOrganization',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(affiliationOrganizationJson);
      expect(identityAttributeValue, isA<AffiliationOrganization>());
    });

    test('parsed valid AffiliationRole', () {
      final affiliationRoleJson = {
        '@type': 'AffiliationRole',
        'value': 'anAffiliationRole',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(affiliationRoleJson);
      expect(identityAttributeValue, isA<AffiliationRole>());
    });

    test('parsed valid AffiliationUnit', () {
      final affiliationUnitJson = {
        '@type': 'AffiliationUnit',
        'value': 'anAffiliationUnit',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(affiliationUnitJson);
      expect(identityAttributeValue, isA<AffiliationUnit>());
    });

    test('parsed valid BirthCity', () {
      final birthCityJson = {
        '@type': 'BirthCity',
        'value': 'aBirthCity',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthCityJson);
      expect(identityAttributeValue, isA<BirthCity>());
    });

    test('parsed valid BirthName', () {
      final birthNameJson = {
        '@type': 'BirthName',
        'value': 'aBirthName',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthNameJson);
      expect(identityAttributeValue, isA<BirthName>());
    });

    test('parsed valid BirthState', () {
      final birthStateJson = {
        '@type': 'BirthState',
        'value': 'aBirthState',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthStateJson);
      expect(identityAttributeValue, isA<BirthState>());
    });

    test('parsed valid City', () {
      final cityJson = {
        '@type': 'City',
        'value': 'aCity',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(cityJson);
      expect(identityAttributeValue, isA<City>());
    });

    test('parsed valid DisplayName', () {
      final displayNameJson = {
        '@type': 'DisplayName',
        'value': 'aDisplayName',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(displayNameJson);
      expect(identityAttributeValue, isA<DisplayName>());
    });

    test('parsed valid FileReference', () {
      final fileReferenceJson = {
        '@type': 'FileReference',
        'value': 'aFileReference',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(fileReferenceJson);
      expect(identityAttributeValue, isA<FileReference>());
    });

    test('parsed valid GivenName', () {
      final givenNameJson = {
        '@type': 'GivenName',
        'value': 'aGivenName',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(givenNameJson);
      expect(identityAttributeValue, isA<GivenName>());
    });

    test('parsed valid HonorificPrefix', () {
      final honorificPrefixJson = {
        '@type': 'HonorificPrefix',
        'value': 'aHonorificPrefix',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(honorificPrefixJson);
      expect(identityAttributeValue, isA<HonorificPrefix>());
    });

    test('parsed valid HonorificSuffix', () {
      final honorificSuffixJson = {
        '@type': 'HonorificSuffix',
        'value': 'aHonorificSuffix',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(honorificSuffixJson);
      expect(identityAttributeValue, isA<HonorificSuffix>());
    });

    test('parsed valid HouseNumber', () {
      final houseNumberJson = {
        '@type': 'HouseNumber',
        'value': 'aHouseNumber',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(houseNumberJson);
      expect(identityAttributeValue, isA<HouseNumber>());
    });

    test('parsed valid JobTitle', () {
      final jobTitleJson = {
        '@type': 'JobTitle',
        'value': 'aJobTitle',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(jobTitleJson);
      expect(identityAttributeValue, isA<JobTitle>());
    });

    test('parsed valid MiddleName', () {
      final middleNameJson = {
        '@type': 'MiddleName',
        'value': 'aMiddleName',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(middleNameJson);
      expect(identityAttributeValue, isA<MiddleName>());
    });

    test('parsed valid PhoneNumber', () {
      final phoneNumberJson = {
        '@type': 'PhoneNumber',
        'value': 'aPhoneNumber',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(phoneNumberJson);
      expect(identityAttributeValue, isA<PhoneNumber>());
    });

    test('parsed valid Pseudonym', () {
      final pseudonymJson = {
        '@type': 'Pseudonym',
        'value': 'aPseudonym',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(pseudonymJson);
      expect(identityAttributeValue, isA<Pseudonym>());
    });

    test('parsed valid State', () {
      final stateJson = {
        '@type': 'State',
        'value': 'aState',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(stateJson);
      expect(identityAttributeValue, isA<State>());
    });

    test('parsed valid Street', () {
      final streetJson = {
        '@type': 'Street',
        'value': 'aStreet',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(streetJson);
      expect(identityAttributeValue, isA<Street>());
    });

    test('parsed valid Surname', () {
      final surnameJson = {
        '@type': 'Surname',
        'value': 'aSurname',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(surnameJson);
      expect(identityAttributeValue, isA<Surname>());
    });

    test('parsed valid ZipCode', () {
      final zipCodeJson = {
        '@type': 'ZipCode',
        'value': 'aZipCode',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(zipCodeJson);
      expect(identityAttributeValue, isA<ZipCode>());
    });

    test('parsed valid Affiliation', () {
      final affiliationJson = {
        '@type': 'Affiliation',
        'role': 'aRole',
        'organization': 'anOrganization',
        'unit': 'anUnit',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(affiliationJson);
      expect(identityAttributeValue, isA<Affiliation>());
    });

    test('parsed valid BirthCountry', () {
      final birthCountryJson = {
        '@type': 'BirthCountry',
        'value': 'DE',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthCountryJson);
      expect(identityAttributeValue, isA<BirthCountry>());
    });

    test('parsed valid BirthDate', () {
      final birthDateJson = {
        '@type': 'BirthDate',
        'day': 01,
        'month': 01,
        'year': 1970,
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthDateJson);
      expect(identityAttributeValue, isA<BirthDate>());
    });

    test('parsed valid BirthDay', () {
      final birthDayJson = {
        '@type': 'BirthDay',
        'value': 01,
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthDayJson);
      expect(identityAttributeValue, isA<BirthDay>());
    });

    test('parsed valid BirthMonth', () {
      final birthMonthJson = {
        '@type': 'BirthMonth',
        'value': 01,
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthMonthJson);
      expect(identityAttributeValue, isA<BirthMonth>());
    });

    test('parsed valid BirthPlace', () {
      final birthPlaceJson = {
        '@type': 'BirthPlace',
        'city': 'aCity',
        'country': 'aCountry',
        'state': 'aState',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthPlaceJson);
      expect(identityAttributeValue, isA<BirthPlace>());
    });

    test('parsed valid BirthYear', () {
      final birthYearJson = {
        '@type': 'BirthYear',
        'value': 01,
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(birthYearJson);
      expect(identityAttributeValue, isA<BirthYear>());
    });

    test('parsed valid Citizenship', () {
      final citizenshipJson = {
        '@type': 'Citizenship',
        'value': 'DE',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(citizenshipJson);
      expect(identityAttributeValue, isA<Citizenship>());
    });

    test('parsed valid CommunicationLanguage', () {
      final communicationLanguageJson = {
        '@type': 'CommunicationLanguage',
        'value': 'de',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(communicationLanguageJson);
      expect(identityAttributeValue, isA<CommunicationLanguage>());
    });

    test('parsed valid Country', () {
      final countryJson = {
        '@type': 'Country',
        'value': 'DE',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(countryJson);
      expect(identityAttributeValue, isA<Country>());
    });

    test('parsed valid DeliveryBoxAddress', () {
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

    test('parsed valid EMailAddress', () {
      final eMailAddressJson = {
        '@type': 'EMailAddress',
        'value': 'test@test.com',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(eMailAddressJson);
      expect(identityAttributeValue, isA<EMailAddress>());
    });

    test('parsed valid FaxNumber', () {
      final faxNumberJson = {
        '@type': 'FaxNumber',
        'value': '0123456789',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(faxNumberJson);
      expect(identityAttributeValue, isA<FaxNumber>());
    });

    test('parsed valid Nationality', () {
      final nationalityJson = {
        '@type': 'Nationality',
        'value': 'DE',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(nationalityJson);
      expect(identityAttributeValue, isA<Nationality>());
    });

    test('parsed valid PersonName', () {
      final personNameJson = {
        '@type': 'PersonName',
        'givenName': 'aGivenName',
        'surname': 'aSurname',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(personNameJson);
      expect(identityAttributeValue, isA<PersonName>());
    });

    test('parsed valid PostOfficeBoxAddress', () {
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

    test('parsed valid Sex', () {
      final sexJson = {
        '@type': 'Sex',
        'value': 'male',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(sexJson);
      expect(identityAttributeValue, isA<Sex>());
    });

    test('parsed valid StreetAddress', () {
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

    test('parsed valid Website', () {
      final websiteJson = {
        '@type': 'Website',
        'value': 'www.test.com',
      };
      final identityAttributeValue = IdentityAttributeValue.fromJson(websiteJson);
      expect(identityAttributeValue, isA<Website>());
    });
  });

  group('IdentityAttributeValue fromJson with wrong @type', () {
    test('throws an Exception', () {
      final invalidJson = {'@type': 'wrongType'};

      expect(() => IdentityAttributeValue.fromJson(invalidJson), throwsA(isA<Exception>()));
    });
  });
}
