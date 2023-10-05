import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/renderers.dart';

class IdentityAttributeExample extends StatelessWidget {
  const IdentityAttributeExample({super.key});

  @override
  Widget build(BuildContext context) {
    const identityDvo = IdentityDVO(
      id: 'id1KotS3HXFnTGKgo1s8tUaKQzmhnjkjddUo',
      name: 'Gymnasium Hugendubel',
      type: 'IdentityDVO',
      realm: 'id1',
      initials: 'GH',
      isSelf: false,
      hasRelationship: true,
    );

    const affiliationAttributeValue = AffiliationAttributeValue(role: 'a Role', organization: 'an Organization', unit: 'an Unit');
    const birthDateAttributeValue = BirthDateAttributeValue(day: 1, month: 1, year: 2000);
    const birthPlaceAttributeValue = BirthPlaceAttributeValue(city: 'Hamburg', country: 'Germany');
    const deliveryBoxAddressAttributeValue = DeliveryBoxAddressAttributeValue(
      recipient: 'a Recipient',
      deliveryBoxId: 'a deliveryBoxId',
      userId: 'a userId',
      zipCode: 'a zip code',
      city: 'Hamburg',
      country: 'Germany',
    );
    const personNameAttributeValue = PersonNameAttributeValue(givenName: 'Name', surname: 'Surname');
    const postOfficeBoxAddressAttributeValue = PostOfficeBoxAddressAttributeValue(
      recipient: 'a Recipient',
      boxId: 'a boxId',
      zipCode: 'a zip code',
      city: 'Hamburg',
      country: 'Germany',
    );
    const streetAddressAttributeValue = StreetAddressAttributeValue(
      recipient: 'a Recipient',
      street: 'a Street',
      houseNumber: '01',
      zipCode: 'a zip code',
      city: 'Hamburg',
      country: 'Germany',
    );
    const schematizedXMLAttributeValue = SchematizedXMLAttributeValue(value: 'XML');
    const statementAttributeValue = StatementAttributeValue(json: {'statement': 'value'});

    const affiliationOrganizationAttributeValue = AffiliationOrganizationAttributeValue(value: 'an affiliation organization');
    const affiliationRoleAttributeValue = AffiliationRoleAttributeValue(value: 'an affiliation role');
    const affiliationUnitAttributeValue = AffiliationUnitAttributeValue(value: 'an affiliation unit');
    const birthCityAttributeValue = BirthCityAttributeValue(value: 'Heidelberg');
    const birthNameAttributeValue = BirthNameAttributeValue(value: 'Mustermann');
    const birthStateAttributeValue = BirthStateAttributeValue(value: 'a birth state');
    const cityAttributeValue = CityAttributeValue(value: 'Mannheim');
    const displayNameAttributeValue = DisplayNameAttributeValue(value: 'a display name');
    const identityFileReferenceAttributeValue = IdentityFileReferenceAttributeValue(value: 'a file reference');
    const honorificPrefixAttributeValue = HonorificPrefixAttributeValue(value: 'a honorific prefix');
    const honorificSuffixAttributeValue = HonorificSuffixAttributeValue(value: 'a honorific suffix');
    const houseNumberAttributeValue = HouseNumberAttributeValue(value: '42');
    const jobTitleAttributeValue = JobTitleAttributeValue(value: 'Software Engineer');
    const middleNameAttributeValue = MiddleNameAttributeValue(value: 'a middle name');
    const phoneNumberAttributeValue = PhoneNumberAttributeValue(value: '+498795268415');
    const pseudonymAttributeValue = PseudonymAttributeValue(value: 'a pseudonym');
    const stateAttributeValue = StateAttributeValue(value: 'Germany');
    const streetAttributeValue = StreetAttributeValue(value: 'a street');
    const surnameAttributeValue = SurnameAttributeValue(value: 'Mustermann');
    const zipCodeAttributeValue = ZipCodeAttributeValue(value: '87629');
    const birthDayAttributeValue = BirthDayAttributeValue(value: 25);
    const birthMonthAttributeValue = BirthMonthAttributeValue(value: 12);
    const birthYearAttributeValue = BirthYearAttributeValue(value: 1990);
    const citizenshipAttributeValue = CitizenshipAttributeValue(value: 'Germany');
    const communicationLanguageAttributeValue = CommunicationLanguageAttributeValue(value: 'German');
    const countryAttributeValue = CountryAttributeValue(value: 'Germany');
    const eMailAddressAttributeValue = EMailAddressAttributeValue(value: 'example@example.com');
    const faxNumberAttributeValue = FaxNumberAttributeValue(value: '+498795268415');
    const nationalityAttributeValue = NationalityAttributeValue(value: 'Germany');
    const sexAttributeValue = SexAttributeValue(value: 'Male');
    const websiteAttributeValue = WebsiteAttributeValue(value: 'https://example.com');

    createIdentityItem({required IdentityAttributeValue value}) => CreateAttributeRequestItemDVO(
          id: '1',
          name: 'Create 1',
          mustBeAccepted: true,
          isDecidable: false,
          attribute: DraftIdentityAttributeDVO(
            id: '',
            name: 'Art der Hochschulzulassung',
            type: 'DraftIdentityAttributeDVO',
            content: IdentityAttribute(owner: 'id17VhbFbFMg1xQC784SEwsbEGXxGKtcB67V', value: value),
            owner: identityDvo,
            renderHints: RenderHints(
              technicalType: RenderHintsTechnicalType.String,
              editType: RenderHintsEditType.InputLike,
            ),
            valueHints: const ValueHints(),
            valueType: 'Consent',
            isOwn: true,
            isDraft: true,
            value: value,
            tags: [],
          ),
        );

    final localRequest = LocalRequestDVO(
      id: 'a id',
      name: 'a name',
      type: 'LocalRequestDVO',
      isOwn: false,
      createdAt: '2023-09-27T11:41:36.933Z',
      content: RequestDVO(
        id: 'REQyB8AzanfTmT3afh8e',
        name: 'Request REQyB8AzanfTmT3afh8e',
        type: 'RequestDVO',
        items: [
          createIdentityItem(value: affiliationAttributeValue),
          createIdentityItem(value: birthDateAttributeValue),
          createIdentityItem(value: birthPlaceAttributeValue),
          createIdentityItem(value: deliveryBoxAddressAttributeValue),
          createIdentityItem(value: personNameAttributeValue),
          createIdentityItem(value: postOfficeBoxAddressAttributeValue),
          createIdentityItem(value: streetAddressAttributeValue),
          createIdentityItem(value: schematizedXMLAttributeValue),
          createIdentityItem(value: statementAttributeValue),
          createIdentityItem(value: affiliationOrganizationAttributeValue),
          createIdentityItem(value: affiliationRoleAttributeValue),
          createIdentityItem(value: affiliationUnitAttributeValue),
          createIdentityItem(value: birthCityAttributeValue),
          createIdentityItem(value: birthNameAttributeValue),
          createIdentityItem(value: birthStateAttributeValue),
          createIdentityItem(value: cityAttributeValue),
          createIdentityItem(value: displayNameAttributeValue),
          createIdentityItem(value: identityFileReferenceAttributeValue),
          createIdentityItem(value: honorificPrefixAttributeValue),
          createIdentityItem(value: honorificSuffixAttributeValue),
          createIdentityItem(value: houseNumberAttributeValue),
          createIdentityItem(value: jobTitleAttributeValue),
          createIdentityItem(value: middleNameAttributeValue),
          createIdentityItem(value: phoneNumberAttributeValue),
          createIdentityItem(value: pseudonymAttributeValue),
          createIdentityItem(value: stateAttributeValue),
          createIdentityItem(value: streetAttributeValue),
          createIdentityItem(value: surnameAttributeValue),
          createIdentityItem(value: zipCodeAttributeValue),
          createIdentityItem(value: birthDayAttributeValue),
          createIdentityItem(value: birthMonthAttributeValue),
          createIdentityItem(value: birthYearAttributeValue),
          createIdentityItem(value: citizenshipAttributeValue),
          createIdentityItem(value: communicationLanguageAttributeValue),
          createIdentityItem(value: countryAttributeValue),
          createIdentityItem(value: eMailAddressAttributeValue),
          createIdentityItem(value: faxNumberAttributeValue),
          createIdentityItem(value: nationalityAttributeValue),
          createIdentityItem(value: sexAttributeValue),
          createIdentityItem(value: websiteAttributeValue),
        ],
      ),
      status: LocalRequestStatus.Decided,
      statusText: 'a statusText',
      directionText: 'a directionText',
      sourceTypeText: 'a sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [
        createIdentityItem(value: affiliationAttributeValue),
        createIdentityItem(value: birthDateAttributeValue),
        createIdentityItem(value: birthPlaceAttributeValue),
        createIdentityItem(value: deliveryBoxAddressAttributeValue),
        createIdentityItem(value: personNameAttributeValue),
        createIdentityItem(value: postOfficeBoxAddressAttributeValue),
        createIdentityItem(value: streetAddressAttributeValue),
        createIdentityItem(value: schematizedXMLAttributeValue),
        createIdentityItem(value: statementAttributeValue),
        createIdentityItem(value: affiliationOrganizationAttributeValue),
        createIdentityItem(value: affiliationRoleAttributeValue),
        createIdentityItem(value: affiliationUnitAttributeValue),
        createIdentityItem(value: birthCityAttributeValue),
        createIdentityItem(value: birthNameAttributeValue),
        createIdentityItem(value: birthStateAttributeValue),
        createIdentityItem(value: cityAttributeValue),
        createIdentityItem(value: displayNameAttributeValue),
        createIdentityItem(value: identityFileReferenceAttributeValue),
        createIdentityItem(value: honorificPrefixAttributeValue),
        createIdentityItem(value: honorificSuffixAttributeValue),
        createIdentityItem(value: houseNumberAttributeValue),
        createIdentityItem(value: jobTitleAttributeValue),
        createIdentityItem(value: middleNameAttributeValue),
        createIdentityItem(value: phoneNumberAttributeValue),
        createIdentityItem(value: pseudonymAttributeValue),
        createIdentityItem(value: stateAttributeValue),
        createIdentityItem(value: streetAttributeValue),
        createIdentityItem(value: surnameAttributeValue),
        createIdentityItem(value: zipCodeAttributeValue),
        createIdentityItem(value: birthDayAttributeValue),
        createIdentityItem(value: birthMonthAttributeValue),
        createIdentityItem(value: birthYearAttributeValue),
        createIdentityItem(value: citizenshipAttributeValue),
        createIdentityItem(value: communicationLanguageAttributeValue),
        createIdentityItem(value: countryAttributeValue),
        createIdentityItem(value: eMailAddressAttributeValue),
        createIdentityItem(value: faxNumberAttributeValue),
        createIdentityItem(value: nationalityAttributeValue),
        createIdentityItem(value: sexAttributeValue),
        createIdentityItem(value: websiteAttributeValue),
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: RequestRenderer(request: localRequest),
    );
  }
}
