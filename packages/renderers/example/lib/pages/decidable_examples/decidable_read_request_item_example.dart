import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

class DecidableReadRequestItemExample extends StatelessWidget {
  final bool isWithResults;

  const DecidableReadRequestItemExample({super.key, required this.isWithResults});

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

    final affiliationRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex, propertyHints: {
      'role': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'organization': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'unit': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
    });
    const affiliationValueHints = ValueHints(propertyHints: {
      'role': ValueHints(max: 100, propertyHints: {}),
      'organization': ValueHints(max: 100, propertyHints: {}),
      'unit': ValueHints(max: 100, propertyHints: {}),
    });
    const affiliationAttributeValue = AffiliationAttributeValue(role: 'Test Rolle', organization: 'Test Organisation', unit: 'Test Unit');
    final affiliationRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Affiliation',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.Affiliation',
                  description: 'i18n://dvo.attribute.description.Affiliation',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: affiliationAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: affiliationAttributeValue,
                  valueType: 'Affiliation',
                  renderHints: affiliationRenderHints,
                  valueHints: affiliationValueHints,
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'Affiliation',
        renderHints: affiliationRenderHints,
        valueHints: affiliationValueHints,
      ),
    );

    final birthDateRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex, propertyHints: {
      'day': RenderHints(technicalType: RenderHintsTechnicalType.Integer, editType: RenderHintsEditType.SelectLike),
      'month': RenderHints(technicalType: RenderHintsTechnicalType.Integer, editType: RenderHintsEditType.SelectLike),
      'year': RenderHints(technicalType: RenderHintsTechnicalType.Integer, editType: RenderHintsEditType.SelectLike),
    });
    const birthDateAttributeValue = BirthDateAttributeValue(day: 1, month: 12, year: 1980);
    final birthDateRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthDate',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.BirthDate',
                  description: 'i18n://dvo.attribute.description.BirthDate',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthDateAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: birthDateAttributeValue,
                  valueType: 'BirthDate',
                  renderHints: birthDateRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'BirthDate',
        renderHints: birthDateRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final birthPlaceRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex, propertyHints: {
      'city': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'country': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.SelectLike),
      'state': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
    });
    const birthPlaceValueHints = ValueHints(propertyHints: {
      'city': ValueHints(max: 100, propertyHints: {}),
      'country': ValueHints(max: 100, propertyHints: {}, values: [
        ValueHintsValue(key: ValueHintsDefaultValueString('AT'), displayName: 'i18n://attributes.values.countries.AT'),
        ValueHintsValue(key: ValueHintsDefaultValueString('DE'), displayName: 'i18n://attributes.values.countries.DE'),
        ValueHintsValue(key: ValueHintsDefaultValueString('BR'), displayName: 'i18n://attributes.values.countries.BR'),
      ]),
      'state': ValueHints(max: 100, propertyHints: {}),
    });
    const birthPlaceAttributeValue = BirthPlaceAttributeValue(city: 'Füssen', country: 'Germany', state: 'Bayern');
    final birthPlaceRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthPlace',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.BirthPlace',
                  description: 'i18n://dvo.attribute.description.BirthPlace',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthPlaceAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: birthPlaceAttributeValue,
                  valueType: 'BirthPlace',
                  renderHints: birthPlaceRenderHints,
                  valueHints: birthPlaceValueHints,
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'BirthPlace',
        renderHints: birthPlaceRenderHints,
        valueHints: birthPlaceValueHints,
      ),
    );

    final deliveryBoxAddressRenderHints =
        RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex, propertyHints: {
      'recipient': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'deliveryBoxId': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'userId': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'zipCode': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'city': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'country': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.SelectLike),
    });
    const deliveryBoxAddressValueHints = ValueHints(propertyHints: {
      'recipient': ValueHints(max: 100, propertyHints: {}),
      'deliveryBoxId': ValueHints(max: 100, propertyHints: {}),
      'userId': ValueHints(max: 100, propertyHints: {}),
      'zipCode': ValueHints(max: 100, propertyHints: {}),
      'city': ValueHints(max: 100, propertyHints: {}),
      'country': ValueHints(max: 100, propertyHints: {}, values: [
        ValueHintsValue(key: ValueHintsDefaultValueString('AT'), displayName: 'i18n://attributes.values.countries.AT'),
        ValueHintsValue(key: ValueHintsDefaultValueString('DE'), displayName: 'i18n://attributes.values.countries.DE'),
        ValueHintsValue(key: ValueHintsDefaultValueString('BR'), displayName: 'i18n://attributes.values.countries.BR'),
      ]),
    });
    const deliveryBoxAddressAttributeValue = DeliveryBoxAddressAttributeValue(
      recipient: 'Max Mustermann',
      deliveryBoxId: '1',
      userId: '2',
      zipCode: '87629',
      city: 'Füssen',
      country: 'Germany',
    );
    final deliveryBoxAddressRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.DeliveryBoxAddress',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.DeliveryBoxAddress',
                  description: 'i18n://dvo.attribute.description.DeliveryBoxAddress',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: deliveryBoxAddressAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: deliveryBoxAddressAttributeValue,
                  valueType: 'DeliveryBoxAddress',
                  renderHints: deliveryBoxAddressRenderHints,
                  valueHints: deliveryBoxAddressValueHints,
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'DeliveryBoxAddress',
        renderHints: deliveryBoxAddressRenderHints,
        valueHints: deliveryBoxAddressValueHints,
      ),
    );

    final personNameRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex, propertyHints: {
      'givenName': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'surname': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
    });
    const personNameValueHints = ValueHints(propertyHints: {
      'givenName': ValueHints(max: 100, propertyHints: {}),
      'surname': ValueHints(max: 100, propertyHints: {}),
    });
    const personNameAttributeValue = PersonNameAttributeValue(givenName: 'Max', surname: 'Mustermann');
    final personNameRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.PersonName',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.PersonName',
                  description: 'i18n://dvo.attribute.description.PersonName',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: personNameAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: personNameAttributeValue,
                  valueType: 'PersonName',
                  renderHints: personNameRenderHints,
                  valueHints: personNameValueHints,
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'PersonName',
        renderHints: personNameRenderHints,
        valueHints: personNameValueHints,
      ),
    );

    final postOfficeBoxAddressRenderHints =
        RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex, propertyHints: {
      'recipient': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'boxId': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'zipCode': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'city': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'country': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.SelectLike),
    });
    const postOfficeBoxAddressValueHints = ValueHints(propertyHints: {
      'recipient': ValueHints(max: 100, propertyHints: {}),
      'boxId': ValueHints(max: 100, propertyHints: {}),
      'zipCode': ValueHints(max: 100, propertyHints: {}),
      'city': ValueHints(max: 100, propertyHints: {}),
      'country': ValueHints(max: 100, propertyHints: {}, values: [
        ValueHintsValue(key: ValueHintsDefaultValueString('AT'), displayName: 'i18n://attributes.values.countries.AT'),
        ValueHintsValue(key: ValueHintsDefaultValueString('DE'), displayName: 'i18n://attributes.values.countries.DE'),
        ValueHintsValue(key: ValueHintsDefaultValueString('BR'), displayName: 'i18n://attributes.values.countries.BR'),
      ]),
    });
    const postOfficeBoxAddressAttributeValue = PostOfficeBoxAddressAttributeValue(
      recipient: 'Max Mustermann',
      boxId: '1',
      zipCode: '87629',
      city: 'Füssen',
      country: 'Germany',
    );
    final postOfficeBoxAddressRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.PostOfficeBoxAddress',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.PostOfficeBoxAddress',
                  description: 'i18n://dvo.attribute.description.PostOfficeBoxAddress',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: postOfficeBoxAddressAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: postOfficeBoxAddressAttributeValue,
                  valueType: 'PostOfficeBoxAddress',
                  renderHints: postOfficeBoxAddressRenderHints,
                  valueHints: postOfficeBoxAddressValueHints,
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'PostOfficeBoxAddress',
        renderHints: postOfficeBoxAddressRenderHints,
        valueHints: postOfficeBoxAddressValueHints,
      ),
    );

    final streetAddressRenderHints =
        RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex, propertyHints: {
      'recipient': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'street': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'houseNumber': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'zipCode': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'city': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'country': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.SelectLike),
    });
    const streetAddressValueHints = ValueHints(propertyHints: {
      'recipient': ValueHints(max: 100, propertyHints: {}),
      'street': ValueHints(max: 100, propertyHints: {}),
      'houseNumber': ValueHints(max: 100, propertyHints: {}),
      'zipCode': ValueHints(max: 100, propertyHints: {}),
      'city': ValueHints(max: 100, propertyHints: {}),
      'country': ValueHints(max: 100, propertyHints: {}, values: [
        ValueHintsValue(key: ValueHintsDefaultValueString('AT'), displayName: 'i18n://attributes.values.countries.AT'),
        ValueHintsValue(key: ValueHintsDefaultValueString('DE'), displayName: 'i18n://attributes.values.countries.DE'),
        ValueHintsValue(key: ValueHintsDefaultValueString('BR'), displayName: 'i18n://attributes.values.countries.BR'),
      ]),
    });
    const streetAddressAttributeValue = StreetAddressAttributeValue(
      recipient: 'Max Mustermann',
      street: 'Musterstraße',
      houseNumber: '1',
      zipCode: '87629',
      city: 'Füssen',
      country: 'Germany',
    );
    final streetAddressRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.StreetAddress',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.StreetAddress',
                  description: 'i18n://dvo.attribute.description.StreetAddress',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: streetAddressAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: streetAddressAttributeValue,
                  valueType: 'StreetAddress',
                  renderHints: streetAddressRenderHints,
                  valueHints: streetAddressValueHints,
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'StreetAddress',
        renderHints: streetAddressRenderHints,
        valueHints: streetAddressValueHints,
      ),
    );

    final affiliationOrganizationRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const affiliationOrganizationAttributeValue = AffiliationOrganizationAttributeValue(value: 'an AffiliationOrganization');
    final affiliationOrganizationRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.AffiliationOrganization',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.AffiliationOrganization',
                  description: 'i18n://dvo.attribute.description.AffiliationOrganization',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: affiliationOrganizationAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: affiliationOrganizationAttributeValue,
                  valueType: 'AffiliationOrganization',
                  renderHints: affiliationOrganizationRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'AffiliationOrganization',
        renderHints: affiliationOrganizationRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final affiliationRoleRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const affiliationRoleAttributeValue = AffiliationRoleAttributeValue(value: 'an AffiliationRole');
    final affiliationRoleRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.AffiliationRole',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.AffiliationRole',
                  description: 'i18n://dvo.attribute.description.AffiliationRole',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: affiliationRoleAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: affiliationRoleAttributeValue,
                  valueType: 'AffiliationRole',
                  renderHints: affiliationRoleRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'AffiliationRole',
        renderHints: affiliationRoleRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final affiliationUnitRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const affiliationUnitAttributeValue = AffiliationUnitAttributeValue(value: 'an AffiliationUnit');
    final affiliationUnitRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.AffiliationUnit',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.AffiliationUnit',
                  description: 'i18n://dvo.attribute.description.AffiliationUnit',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: affiliationUnitAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: affiliationUnitAttributeValue,
                  valueType: 'AffiliationUnit',
                  renderHints: affiliationUnitRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'AffiliationUnit',
        renderHints: affiliationUnitRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final birthCityRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const birthCityAttributeValue = BirthCityAttributeValue(value: 'Füssen');
    final birthCityRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthCity',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.BirthCity',
                  description: 'i18n://dvo.attribute.description.BirthCity',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthCityAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: birthCityAttributeValue,
                  valueType: 'BirthCity',
                  renderHints: birthCityRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'BirthCity',
        renderHints: birthCityRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final birthNameRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const birthNameAttributeValue = BirthNameAttributeValue(value: 'Musterfrau');
    final birthNameRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthName',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.BirthName',
                  description: 'i18n://dvo.attribute.description.BirthName',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthNameAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: birthNameAttributeValue,
                  valueType: 'BirthName',
                  renderHints: birthNameRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'BirthName',
        renderHints: birthNameRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final birthStateRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const birthStateAttributeValue = BirthStateAttributeValue(value: 'Bayern');
    final birthStateRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthState',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.BirthState',
                  description: 'i18n://dvo.attribute.description.BirthState',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthStateAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: birthStateAttributeValue,
                  valueType: 'BirthState',
                  renderHints: birthStateRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'BirthState',
        renderHints: birthStateRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final cityRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const cityAttributeValue = CityAttributeValue(value: 'Füssen');
    final cityRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.City',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.City',
                  description: 'i18n://dvo.attribute.description.City',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: cityAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: cityAttributeValue,
                  valueType: 'City',
                  renderHints: cityRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'City',
        renderHints: cityRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final displayNameRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const displayNameAttributeValue = DisplayNameAttributeValue(value: 'Maxi');
    final displayNameRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.DisplayName',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.DisplayName',
                  description: 'i18n://dvo.attribute.description.DisplayName',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: displayNameAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: displayNameAttributeValue,
                  valueType: 'DisplayName',
                  renderHints: displayNameRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'DisplayName',
        renderHints: displayNameRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final identityFileReferenceRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const identityFileReferenceAttributeValue = IdentityFileReferenceAttributeValue(value: 'RkIMQ3KÖLJDSOLJFMNLDKSAJFKLMKLCASDJ');
    final identityFileReferenceRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.IdentityFileReference',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.IdentityFileReference',
                  description: 'i18n://dvo.attribute.description.IdentityFileReference',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: identityFileReferenceAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: identityFileReferenceAttributeValue,
                  valueType: 'IdentityFileReference',
                  renderHints: identityFileReferenceRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'IdentityFileReference',
        renderHints: identityFileReferenceRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final givenNameRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const givenNameAttributeValue = GivenNameAttributeValue(value: 'Max');
    final givenNameRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.GivenName',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.GivenName',
                  description: 'i18n://dvo.attribute.description.GivenName',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: givenNameAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: givenNameAttributeValue,
                  valueType: 'GivenName',
                  renderHints: givenNameRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'GivenName',
        renderHints: givenNameRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final honorificPrefixRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const honorificPrefixAttributeValue = HonorificPrefixAttributeValue(value: 'a HonorificPrefix');
    final honorificPrefixRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.HonorificPrefix',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.HonorificPrefix',
                  description: 'i18n://dvo.attribute.description.HonorificPrefix',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: honorificPrefixAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: honorificPrefixAttributeValue,
                  valueType: 'HonorificPrefix',
                  renderHints: honorificPrefixRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'HonorificPrefix',
        renderHints: honorificPrefixRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final honorificSuffixRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const honorificSuffixAttributeValue = HonorificSuffixAttributeValue(value: 'a HonorificSuffix');
    final honorificSuffixRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.HonorificSuffix',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.HonorificSuffix',
                  description: 'i18n://dvo.attribute.description.HonorificSuffix',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: honorificSuffixAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: honorificSuffixAttributeValue,
                  valueType: 'HonorificSuffix',
                  renderHints: honorificSuffixRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'HonorificSuffix',
        renderHints: honorificSuffixRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final houseNumberRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const houseNumberAttributeValue = HouseNumberAttributeValue(value: '42');
    final houseNumberRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.HouseNumber',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.HouseNumber',
                  description: 'i18n://dvo.attribute.description.HouseNumber',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: houseNumberAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: houseNumberAttributeValue,
                  valueType: 'HouseNumber',
                  renderHints: houseNumberRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'HouseNumber',
        renderHints: houseNumberRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final jobTitleRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const jobTitleAttributeValue = JobTitleAttributeValue(value: 'Software Engineer');
    final jobTitleRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.JobTitle',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.JobTitle',
                  description: 'i18n://dvo.attribute.description.JobTitle',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: jobTitleAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: jobTitleAttributeValue,
                  valueType: 'JobTitle',
                  renderHints: jobTitleRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'JobTitle',
        renderHints: jobTitleRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final middleNameRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const middleNameAttributeValue = MiddleNameAttributeValue(value: 'Maxi');
    final middleNameRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.MiddleName',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.MiddleName',
                  description: 'i18n://dvo.attribute.description.MiddleName',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: middleNameAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: middleNameAttributeValue,
                  valueType: 'MiddleName',
                  renderHints: middleNameRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'MiddleName',
        renderHints: middleNameRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final phoneNumberRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const phoneNumberAttributeValue = PhoneNumberAttributeValue(value: '+49 675 5654125');
    final phoneNumberRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.PhoneNumber',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.PhoneNumber',
                  description: 'i18n://dvo.attribute.description.PhoneNumber',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: phoneNumberAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: phoneNumberAttributeValue,
                  valueType: 'PhoneNumber',
                  renderHints: phoneNumberRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'PhoneNumber',
        renderHints: phoneNumberRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final pseudonymRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const pseudonymAttributeValue = PseudonymAttributeValue(value: 'a Pseudonym');
    final pseudonymRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Pseudonym',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.Pseudonym',
                  description: 'i18n://dvo.attribute.description.Pseudonym',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: pseudonymAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: pseudonymAttributeValue,
                  valueType: 'Pseudonym',
                  renderHints: pseudonymRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'Pseudonym',
        renderHints: pseudonymRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final stateRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const stateAttributeValue = StateAttributeValue(value: 'Bayern');
    final stateRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.State',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.State',
                  description: 'i18n://dvo.attribute.description.State',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: stateAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: stateAttributeValue,
                  valueType: 'State',
                  renderHints: stateRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'State',
        renderHints: stateRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final streetRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const streetAttributeValue = StreetAttributeValue(value: 'Musterstraße');
    final streetRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Street',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.Street',
                  description: 'i18n://dvo.attribute.description.Street',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: streetAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: streetAttributeValue,
                  valueType: 'Street',
                  renderHints: streetRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'Street',
        renderHints: streetRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final surnameRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const surnameAttributeValue = SurnameAttributeValue(value: 'Mustermann');
    final surnameRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Surname',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.Surname',
                  description: 'i18n://dvo.attribute.description.Surname',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: surnameAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: surnameAttributeValue,
                  valueType: 'Surname',
                  renderHints: surnameRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'Surname',
        renderHints: surnameRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final zipCodeRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const zipCodeAttributeValue = ZipCodeAttributeValue(value: 'Mustermann');
    final zipCodeRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.ZipCode',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.ZipCode',
                  description: 'i18n://dvo.attribute.description.ZipCode',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: zipCodeAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: zipCodeAttributeValue,
                  valueType: 'ZipCode',
                  renderHints: zipCodeRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'ZipCode',
        renderHints: zipCodeRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final birthDayRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const birthDayAttributeValue = BirthDayAttributeValue(value: 24);
    final birthDayRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthDay',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.BirthDay',
                  description: 'i18n://dvo.attribute.description.BirthDay',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthDayAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: birthDayAttributeValue,
                  valueType: 'BirthDay',
                  renderHints: birthDayRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'BirthDay',
        renderHints: birthDayRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final birthMonthRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const birthMonthAttributeValue = BirthMonthAttributeValue(value: 12);
    final birthMonthRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthMonth',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.BirthMonth',
                  description: 'i18n://dvo.attribute.description.BirthMonth',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthMonthAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: birthMonthAttributeValue,
                  valueType: 'BirthMonth',
                  renderHints: birthMonthRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'BirthMonth',
        renderHints: birthMonthRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final birthYearRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const birthYearAttributeValue = BirthYearAttributeValue(value: 1990);
    final birthYearRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthYear',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.BirthYear',
                  description: 'i18n://dvo.attribute.description.BirthYear',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthYearAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: birthYearAttributeValue,
                  valueType: 'BirthYear',
                  renderHints: birthYearRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'BirthYear',
        renderHints: birthYearRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final citizenshipRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const citizenshipAttributeValue = CitizenshipAttributeValue(value: 'Germany');
    final citizenshipRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Citizenship',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.Citizenship',
                  description: 'i18n://dvo.attribute.description.Citizenship',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: citizenshipAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: citizenshipAttributeValue,
                  valueType: 'Citizenship',
                  renderHints: citizenshipRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'Citizenship',
        renderHints: citizenshipRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final communicationLanguageRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const communicationLanguageAttributeValue = CommunicationLanguageAttributeValue(value: 'German');
    final communicationLanguageRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.CommunicationLanguage',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.CommunicationLanguage',
                  description: 'i18n://dvo.attribute.description.CommunicationLanguage',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: communicationLanguageAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: communicationLanguageAttributeValue,
                  valueType: 'CommunicationLanguage',
                  renderHints: communicationLanguageRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'CommunicationLanguage',
        renderHints: communicationLanguageRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final countryRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const countryAttributeValue = CountryAttributeValue(value: 'Füssen');
    final countryRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Country',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.Country',
                  description: 'i18n://dvo.attribute.description.Country',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: countryAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: countryAttributeValue,
                  valueType: 'Country',
                  renderHints: countryRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'Country',
        renderHints: countryRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final eMailAddressRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const eMailAddressAttributeValue = EMailAddressAttributeValue(value: 'max@mustermann.de');
    final eMailAddressRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.EMailAddress',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.EMailAddress',
                  description: 'i18n://dvo.attribute.description.EMailAddress',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: eMailAddressAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: eMailAddressAttributeValue,
                  valueType: 'EMailAddress',
                  renderHints: eMailAddressRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'EMailAddress',
        renderHints: eMailAddressRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final faxNumberRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const faxNumberAttributeValue = FaxNumberAttributeValue(value: '06526486151684');
    final faxNumberRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.FaxNumber',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.FaxNumber',
                  description: 'i18n://dvo.attribute.description.FaxNumber',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: faxNumberAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: faxNumberAttributeValue,
                  valueType: 'FaxNumber',
                  renderHints: faxNumberRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'FaxNumber',
        renderHints: faxNumberRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final nationalityRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const nationalityAttributeValue = NationalityAttributeValue(value: 'Germany');
    final nationalityRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Nationality',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.Nationality',
                  description: 'i18n://dvo.attribute.description.Nationality',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: nationalityAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: nationalityAttributeValue,
                  valueType: 'Nationality',
                  renderHints: nationalityRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'Nationality',
        renderHints: nationalityRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final sexRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const sexAttributeValue = SexAttributeValue(value: 'Male');
    final sexRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Sex',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.Sex',
                  description: 'i18n://dvo.attribute.description.Sex',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: sexAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: sexAttributeValue,
                  valueType: 'Sex',
                  renderHints: sexRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'Sex',
        renderHints: sexRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final websiteRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const websiteAttributeValue = WebsiteAttributeValue(value: 'www.max-mustermann.com');
    final websiteRequestItem = DecidableReadAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableReadAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Website',
        results: isWithResults
            ? [
                RepositoryAttributeDVO(
                  id: 'ATTfXgC9wku9mXrTv9T9',
                  name: 'i18n://dvo.attribute.name.Website',
                  description: 'i18n://dvo.attribute.description.Website',
                  content: const IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: websiteAttributeValue),
                  owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
                  tags: [],
                  value: websiteAttributeValue,
                  valueType: 'Website',
                  renderHints: websiteRenderHints,
                  valueHints: const ValueHints(),
                  isDraft: false,
                  isValid: true,
                  createdAt: '2023-10-16T08:12:59.207Z',
                  sharedWith: [],
                ),
              ]
            : [],
        tags: [],
        valueType: 'Website',
        renderHints: websiteRenderHints,
        valueHints: const ValueHints(),
      ),
    );

    final localRequest = LocalRequestDVO(
      id: 'REQuHfz2PcAAVHlMzzkf',
      name: 'i18n://dvo.localRequest.Message.incoming.ManualDecisionRequired.name',
      description: 'i18n://dvo.localRequest.Message.incoming.ManualDecisionRequired.description',
      type: 'LocalRequestDVO',
      date: '2023-10-13T12:24:27.187Z',
      isOwn: false,
      createdAt: '2023-10-13T12:24:27.187Z',
      content: RequestDVO(
        id: 'REQuHfz2PcAAVHlMzzkf',
        name: 'Request REQuHfz2PcAAVHlMzzkf',
        type: 'RequestDVO',
        items: [
          affiliationRequestItem,
          birthDateRequestItem,
          birthPlaceRequestItem,
          deliveryBoxAddressRequestItem,
          personNameRequestItem,
          postOfficeBoxAddressRequestItem,
          streetAddressRequestItem,
          affiliationOrganizationRequestItem,
          affiliationRoleRequestItem,
          affiliationUnitRequestItem,
          birthCityRequestItem,
          birthNameRequestItem,
          birthStateRequestItem,
          cityRequestItem,
          displayNameRequestItem,
          identityFileReferenceRequestItem,
          givenNameRequestItem,
          honorificPrefixRequestItem,
          honorificSuffixRequestItem,
          houseNumberRequestItem,
          jobTitleRequestItem,
          middleNameRequestItem,
          phoneNumberRequestItem,
          pseudonymRequestItem,
          stateRequestItem,
          streetRequestItem,
          surnameRequestItem,
          zipCodeRequestItem,
          birthDayRequestItem,
          birthMonthRequestItem,
          birthYearRequestItem,
          citizenshipRequestItem,
          communicationLanguageRequestItem,
          countryRequestItem,
          eMailAddressRequestItem,
          faxNumberRequestItem,
          nationalityRequestItem,
          sexRequestItem,
          websiteRequestItem,
        ],
      ),
      status: LocalRequestStatus.ManualDecisionRequired,
      statusText: 'i18n://dvo.localRequest.status.ManualDecisionRequired',
      directionText: 'i18n://dvo.localRequest.direction.incoming',
      sourceTypeText: 'i18n://dvo.localRequest.sourceType.Message',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: true,
      items: [
        affiliationRequestItem,
        birthDateRequestItem,
        birthPlaceRequestItem,
        deliveryBoxAddressRequestItem,
        personNameRequestItem,
        postOfficeBoxAddressRequestItem,
        streetAddressRequestItem,
        affiliationOrganizationRequestItem,
        affiliationRoleRequestItem,
        affiliationUnitRequestItem,
        birthCityRequestItem,
        birthNameRequestItem,
        birthStateRequestItem,
        cityRequestItem,
        displayNameRequestItem,
        identityFileReferenceRequestItem,
        givenNameRequestItem,
        honorificPrefixRequestItem,
        honorificSuffixRequestItem,
        houseNumberRequestItem,
        jobTitleRequestItem,
        middleNameRequestItem,
        phoneNumberRequestItem,
        pseudonymRequestItem,
        stateRequestItem,
        streetRequestItem,
        surnameRequestItem,
        zipCodeRequestItem,
        birthDayRequestItem,
        birthMonthRequestItem,
        birthYearRequestItem,
        citizenshipRequestItem,
        communicationLanguageRequestItem,
        countryRequestItem,
        eMailAddressRequestItem,
        faxNumberRequestItem,
        nationalityRequestItem,
        sexRequestItem,
        websiteRequestItem,
      ],
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Title:', style: TextStyle(fontWeight: FontWeight.bold)),
                TranslatedText(localRequest.name),
                const SizedBox(height: 8),
                if (localRequest.description != null) ...[
                  const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
                  TranslatedText(localRequest.description!),
                  const SizedBox(height: 8),
                ],
                const Text('Request ID:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(localRequest.id),
                const SizedBox(height: 8),
                const Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
                TranslatedText(localRequest.statusText),
                const SizedBox(height: 8),
                const Text('Created by:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(localRequest.createdBy.name),
                const SizedBox(height: 8),
                const Text('Created at:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(DateFormat('yMd', Localizations.localeOf(context).languageCode).format(DateTime.parse(localRequest.createdAt))),
                const Divider(),
                RequestRenderer(request: localRequest),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
