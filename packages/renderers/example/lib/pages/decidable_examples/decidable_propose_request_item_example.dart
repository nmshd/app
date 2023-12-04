import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renderers/renderers.dart';
import 'package:translated_text/translated_text.dart';

class DecidableProposeRequestItemExample extends StatelessWidget {
  const DecidableProposeRequestItemExample({super.key});

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
    const affiliationIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: affiliationAttributeValue);
    final affiliationRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Affiliation',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.Affiliation',
            description: 'i18n://dvo.attribute.description.Affiliation',
            content: affiliationIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'Affiliation',
        renderHints: affiliationRenderHints,
        valueHints: affiliationValueHints,
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Affiliation',
        type: 'DraftIdentityAttributeDVO',
        content: affiliationIdentityAttribute,
        owner: identityDvo,
        renderHints: affiliationRenderHints,
        valueHints: affiliationValueHints,
        valueType: 'Affiliation',
        isOwn: true,
        isDraft: true,
        value: affiliationAttributeValue,
        tags: [],
      ),
    );

    final birthDateRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex);
    const birthDateAttributeValue = BirthDateAttributeValue(day: 1, month: 12, year: 1980);
    const birthDateIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthDateAttributeValue);
    final birthDateRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthDate',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.BirthDate',
            description: 'i18n://dvo.attribute.description.BirthDate',
            content: birthDateIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'BirthDate',
        renderHints: birthDateRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthDate',
        type: 'DraftIdentityAttributeDVO',
        content: birthDateIdentityAttribute,
        owner: identityDvo,
        renderHints: birthDateRenderHints,
        valueHints: const ValueHints(),
        valueType: 'BirthDate',
        isOwn: true,
        isDraft: true,
        value: birthDateAttributeValue,
        tags: [],
      ),
    );

    final birthPlaceRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex, propertyHints: {
      'city': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'country': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'state': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
    });
    const birthPlaceValueHints = ValueHints(propertyHints: {
      'city': ValueHints(max: 100, propertyHints: {}),
      'country': ValueHints(max: 100, propertyHints: {}),
      'state': ValueHints(max: 100, propertyHints: {}),
    });
    const birthPlaceAttributeValue = BirthPlaceAttributeValue(city: 'Füssen', country: 'Germany', state: 'Bayern');
    const birthPlaceIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthPlaceAttributeValue);
    final birthPlaceRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthPlace',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.BirthPlace',
            description: 'i18n://dvo.attribute.description.BirthPlace',
            content: birthPlaceIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'BirthPlace',
        renderHints: birthPlaceRenderHints,
        valueHints: birthPlaceValueHints,
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthPlace',
        type: 'DraftIdentityAttributeDVO',
        content: birthPlaceIdentityAttribute,
        owner: identityDvo,
        renderHints: birthPlaceRenderHints,
        valueHints: const ValueHints(),
        valueType: 'BirthPlace',
        isOwn: true,
        isDraft: true,
        value: birthPlaceAttributeValue,
        tags: [],
      ),
    );

    final deliveryBoxAddressRenderHints =
        RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex, propertyHints: {
      'recipient': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'deliveryBoxId': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'userId': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'zipCode': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'city': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'country': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
    });
    const deliveryBoxAddressValueHints = ValueHints(propertyHints: {
      'recipient': ValueHints(max: 100, propertyHints: {}),
      'deliveryBoxId': ValueHints(max: 100, propertyHints: {}),
      'userId': ValueHints(max: 100, propertyHints: {}),
      'zipCode': ValueHints(max: 100, propertyHints: {}),
      'city': ValueHints(max: 100, propertyHints: {}),
      'country': ValueHints(max: 100, propertyHints: {}),
    });
    const deliveryBoxAddressAttributeValue = DeliveryBoxAddressAttributeValue(
      recipient: 'Max Mustermann',
      deliveryBoxId: '1',
      userId: '2',
      zipCode: '87629',
      city: 'Füssen',
      country: 'Germany',
    );
    const deliveryBoxAddressIdentityAttribute = IdentityAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: deliveryBoxAddressAttributeValue,
    );

    final deliveryBoxAddressRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.DeliveryBoxAddress',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.DeliveryBoxAddress',
            description: 'i18n://dvo.attribute.description.DeliveryBoxAddress',
            content: deliveryBoxAddressIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'DeliveryBoxAddress',
        renderHints: deliveryBoxAddressRenderHints,
        valueHints: deliveryBoxAddressValueHints,
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.DeliveryBoxAddress',
        type: 'DraftIdentityAttributeDVO',
        content: deliveryBoxAddressIdentityAttribute,
        owner: identityDvo,
        renderHints: deliveryBoxAddressRenderHints,
        valueHints: const ValueHints(),
        valueType: 'DeliveryBoxAddress',
        isOwn: true,
        isDraft: true,
        value: deliveryBoxAddressAttributeValue,
        tags: [],
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
    const personNameIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: personNameAttributeValue);
    final personNameRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.PersonName',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.PersonName',
            description: 'i18n://dvo.attribute.description.PersonName',
            content: personNameIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'PersonName',
        renderHints: personNameRenderHints,
        valueHints: personNameValueHints,
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.PersonName',
        type: 'DraftIdentityAttributeDVO',
        content: personNameIdentityAttribute,
        owner: identityDvo,
        renderHints: personNameRenderHints,
        valueHints: const ValueHints(),
        valueType: 'PersonName',
        isOwn: true,
        isDraft: true,
        value: personNameAttributeValue,
        tags: [],
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
    const postOfficeBoxAddressIdentityAttribute = IdentityAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: postOfficeBoxAddressAttributeValue,
    );
    final postOfficeBoxAddressRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.PostOfficeBoxAddress',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.PostOfficeBoxAddress',
            description: 'i18n://dvo.attribute.description.PostOfficeBoxAddress',
            content: postOfficeBoxAddressIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'PostOfficeBoxAddress',
        renderHints: postOfficeBoxAddressRenderHints,
        valueHints: postOfficeBoxAddressValueHints,
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.PostOfficeBoxAddress',
        type: 'DraftIdentityAttributeDVO',
        content: postOfficeBoxAddressIdentityAttribute,
        owner: identityDvo,
        renderHints: postOfficeBoxAddressRenderHints,
        valueHints: const ValueHints(),
        valueType: 'PostOfficeBoxAddress',
        isOwn: true,
        isDraft: true,
        value: postOfficeBoxAddressAttributeValue,
        tags: [],
      ),
    );

    final streetAddressRenderHints =
        RenderHints(technicalType: RenderHintsTechnicalType.Object, editType: RenderHintsEditType.Complex, propertyHints: {
      'recipient': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'street': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'houseNumber': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'zipCode': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'city': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
      'country': RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike),
    });
    const streetAddressValueHints = ValueHints(propertyHints: {
      'recipient': ValueHints(max: 100, propertyHints: {}),
      'street': ValueHints(max: 100, propertyHints: {}),
      'houseNumber': ValueHints(max: 100, propertyHints: {}),
      'zipCode': ValueHints(max: 100, propertyHints: {}),
      'city': ValueHints(max: 100, propertyHints: {}),
      'country': ValueHints(max: 100, propertyHints: {}),
    });
    const streetAddressAttributeValue = StreetAddressAttributeValue(
      recipient: 'Max Mustermann',
      street: 'Musterstraße',
      houseNumber: '1',
      zipCode: '87629',
      city: 'Füssen',
      country: 'Germany',
    );
    const streetAddressIdentityAttribute = IdentityAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: streetAddressAttributeValue,
    );
    final streetAddressRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.StreetAddress',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.StreetAddress',
            description: 'i18n://dvo.attribute.description.StreetAddress',
            content: streetAddressIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'StreetAddress',
        renderHints: streetAddressRenderHints,
        valueHints: streetAddressValueHints,
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.StreetAddress',
        type: 'DraftIdentityAttributeDVO',
        content: streetAddressIdentityAttribute,
        owner: identityDvo,
        renderHints: streetAddressRenderHints,
        valueHints: const ValueHints(),
        valueType: 'StreetAddress',
        isOwn: true,
        isDraft: true,
        value: streetAddressAttributeValue,
        tags: [],
      ),
    );

    final affiliationOrganizationRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const affiliationOrganizationAttributeValue = AffiliationOrganizationAttributeValue(value: 'an AffiliationOrganization');
    const affiliationOrganizationIdentityAttribute = IdentityAttribute(
      owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd',
      value: affiliationOrganizationAttributeValue,
    );
    final affiliationOrganizationRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.AffiliationOrganization',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.AffiliationOrganization',
            description: 'i18n://dvo.attribute.description.AffiliationOrganization',
            content: affiliationOrganizationIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'AffiliationOrganization',
        renderHints: affiliationOrganizationRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.AffiliationOrganization',
        type: 'DraftIdentityAttributeDVO',
        content: affiliationOrganizationIdentityAttribute,
        owner: identityDvo,
        renderHints: affiliationOrganizationRenderHints,
        valueHints: const ValueHints(),
        valueType: 'AffiliationOrganization',
        isOwn: true,
        isDraft: true,
        value: affiliationOrganizationAttributeValue,
        tags: [],
      ),
    );

    final affiliationRoleRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const affiliationRoleAttributeValue = AffiliationRoleAttributeValue(value: 'an AffiliationRole');
    const affiliationRoleIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: affiliationRoleAttributeValue);
    final affiliationRoleRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.AffiliationRole',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.AffiliationRole',
            description: 'i18n://dvo.attribute.description.AffiliationRole',
            content: affiliationRoleIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'AffiliationRole',
        renderHints: affiliationRoleRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.AffiliationRole',
        type: 'DraftIdentityAttributeDVO',
        content: affiliationRoleIdentityAttribute,
        owner: identityDvo,
        renderHints: affiliationRoleRenderHints,
        valueHints: const ValueHints(),
        valueType: 'AffiliationRole',
        isOwn: true,
        isDraft: true,
        value: affiliationRoleAttributeValue,
        tags: [],
      ),
    );

    final affiliationUnitRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const affiliationUnitAttributeValue = AffiliationUnitAttributeValue(value: 'an AffiliationUnit');
    const affiliationUnitIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: affiliationUnitAttributeValue);
    final affiliationUnitRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.AffiliationUnit',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.AffiliationUnit',
            description: 'i18n://dvo.attribute.description.AffiliationUnit',
            content: affiliationUnitIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'AffiliationUnit',
        renderHints: affiliationUnitRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.AffiliationUnit',
        type: 'DraftIdentityAttributeDVO',
        content: affiliationUnitIdentityAttribute,
        owner: identityDvo,
        renderHints: affiliationUnitRenderHints,
        valueHints: const ValueHints(),
        valueType: 'AffiliationUnit',
        isOwn: true,
        isDraft: true,
        value: affiliationUnitAttributeValue,
        tags: [],
      ),
    );

    final birthCityRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const birthCityAttributeValue = BirthCityAttributeValue(value: 'Füssen');
    const birthCityIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthCityAttributeValue);
    final birthCityRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthCity',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.BirthCity',
            description: 'i18n://dvo.attribute.description.BirthCity',
            content: birthCityIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'BirthCity',
        renderHints: birthCityRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthCity',
        type: 'DraftIdentityAttributeDVO',
        content: birthCityIdentityAttribute,
        owner: identityDvo,
        renderHints: birthCityRenderHints,
        valueHints: const ValueHints(),
        valueType: 'BirthCity',
        isOwn: true,
        isDraft: true,
        value: birthCityAttributeValue,
        tags: [],
      ),
    );

    final birthNameRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const birthNameAttributeValue = BirthNameAttributeValue(value: 'Musterfrau');
    const birthNameIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthNameAttributeValue);
    final birthNameRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthName',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.BirthName',
            description: 'i18n://dvo.attribute.description.BirthName',
            content: birthNameIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'BirthName',
        renderHints: birthNameRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthName',
        type: 'DraftIdentityAttributeDVO',
        content: birthNameIdentityAttribute,
        owner: identityDvo,
        renderHints: birthNameRenderHints,
        valueHints: const ValueHints(),
        valueType: 'BirthName',
        isOwn: true,
        isDraft: true,
        value: birthNameAttributeValue,
        tags: [],
      ),
    );

    final birthStateRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const birthStateAttributeValue = BirthStateAttributeValue(value: 'Bayern');
    const birthStateIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthStateAttributeValue);
    final birthStateRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthState',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.BirthState',
            description: 'i18n://dvo.attribute.description.BirthState',
            content: birthStateIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'BirthState',
        renderHints: birthStateRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthState',
        type: 'DraftIdentityAttributeDVO',
        content: birthStateIdentityAttribute,
        owner: identityDvo,
        renderHints: birthStateRenderHints,
        valueHints: const ValueHints(),
        valueType: 'BirthState',
        isOwn: true,
        isDraft: true,
        value: birthStateAttributeValue,
        tags: [],
      ),
    );

    final cityRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const cityAttributeValue = CityAttributeValue(value: 'Füssen');
    const cityIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: cityAttributeValue);
    final cityRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.City',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.City',
            description: 'i18n://dvo.attribute.description.City',
            content: cityIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'City',
        renderHints: cityRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.City',
        type: 'DraftIdentityAttributeDVO',
        content: cityIdentityAttribute,
        owner: identityDvo,
        renderHints: cityRenderHints,
        valueHints: const ValueHints(),
        valueType: 'City',
        isOwn: true,
        isDraft: true,
        value: cityAttributeValue,
        tags: [],
      ),
    );

    final displayNameRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const displayNameAttributeValue = DisplayNameAttributeValue(value: 'Maxi');
    const displayNameIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: displayNameAttributeValue);
    final displayNameRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.DisplayName',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.DisplayName',
            description: 'i18n://dvo.attribute.description.DisplayName',
            content: displayNameIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'DisplayName',
        renderHints: displayNameRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.DisplayName',
        type: 'DraftIdentityAttributeDVO',
        content: displayNameIdentityAttribute,
        owner: identityDvo,
        renderHints: displayNameRenderHints,
        valueHints: const ValueHints(),
        valueType: 'DisplayName',
        isOwn: true,
        isDraft: true,
        value: displayNameAttributeValue,
        tags: [],
      ),
    );

    final identityFileReferenceRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const identityFileReferenceAttributeValue = IdentityFileReferenceAttributeValue(value: 'RkIMQ3KÖLJDSOLJFMNLDKSAJFKLMKLCASDJ');
    const identityFileReferenceIdentityAttribute =
        IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: identityFileReferenceAttributeValue);
    final identityFileReferenceRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.IdentityFileReference',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.IdentityFileReference',
            description: 'i18n://dvo.attribute.description.IdentityFileReference',
            content: identityFileReferenceIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'IdentityFileReference',
        renderHints: identityFileReferenceRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.IdentityFileReference',
        type: 'DraftIdentityAttributeDVO',
        content: identityFileReferenceIdentityAttribute,
        owner: identityDvo,
        renderHints: identityFileReferenceRenderHints,
        valueHints: const ValueHints(),
        valueType: 'IdentityFileReference',
        isOwn: true,
        isDraft: true,
        value: identityFileReferenceAttributeValue,
        tags: [],
      ),
    );

    final givenNameRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const givenNameAttributeValue = GivenNameAttributeValue(value: 'Max');
    const givenNameIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: givenNameAttributeValue);
    final givenNameRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.GivenName',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.GivenName',
            description: 'i18n://dvo.attribute.description.GivenName',
            content: givenNameIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'GivenName',
        renderHints: givenNameRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.GivenName',
        type: 'DraftIdentityAttributeDVO',
        content: givenNameIdentityAttribute,
        owner: identityDvo,
        renderHints: givenNameRenderHints,
        valueHints: const ValueHints(),
        valueType: 'GivenName',
        isOwn: true,
        isDraft: true,
        value: givenNameAttributeValue,
        tags: [],
      ),
    );

    final honorificPrefixRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const honorificPrefixAttributeValue = HonorificPrefixAttributeValue(value: 'a HonorificPrefix');
    const honorificPrefixIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: honorificPrefixAttributeValue);
    final honorificPrefixRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.HonorificPrefix',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.HonorificPrefix',
            description: 'i18n://dvo.attribute.description.HonorificPrefix',
            content: honorificPrefixIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'HonorificPrefix',
        renderHints: honorificPrefixRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.HonorificPrefix',
        type: 'DraftIdentityAttributeDVO',
        content: honorificPrefixIdentityAttribute,
        owner: identityDvo,
        renderHints: honorificPrefixRenderHints,
        valueHints: const ValueHints(),
        valueType: 'HonorificPrefix',
        isOwn: true,
        isDraft: true,
        value: honorificPrefixAttributeValue,
        tags: [],
      ),
    );

    final honorificSuffixRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const honorificSuffixAttributeValue = HonorificSuffixAttributeValue(value: 'a HonorificSuffix');
    const honorificSuffixIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: honorificSuffixAttributeValue);
    final honorificSuffixRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.HonorificSuffix',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.HonorificSuffix',
            description: 'i18n://dvo.attribute.description.HonorificSuffix',
            content: honorificSuffixIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'HonorificSuffix',
        renderHints: honorificSuffixRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.HonorificSuffix',
        type: 'DraftIdentityAttributeDVO',
        content: honorificSuffixIdentityAttribute,
        owner: identityDvo,
        renderHints: honorificSuffixRenderHints,
        valueHints: const ValueHints(),
        valueType: 'HonorificSuffix',
        isOwn: true,
        isDraft: true,
        value: honorificSuffixAttributeValue,
        tags: [],
      ),
    );

    final houseNumberRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const houseNumberAttributeValue = HouseNumberAttributeValue(value: '42');
    const houseNumberIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: houseNumberAttributeValue);
    final houseNumberRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.HouseNumber',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.HouseNumber',
            description: 'i18n://dvo.attribute.description.HouseNumber',
            content: houseNumberIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'HouseNumber',
        renderHints: houseNumberRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.HouseNumber',
        type: 'DraftIdentityAttributeDVO',
        content: houseNumberIdentityAttribute,
        owner: identityDvo,
        renderHints: houseNumberRenderHints,
        valueHints: const ValueHints(),
        valueType: 'HouseNumber',
        isOwn: true,
        isDraft: true,
        value: houseNumberAttributeValue,
        tags: [],
      ),
    );

    final jobTitleRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const jobTitleAttributeValue = JobTitleAttributeValue(value: 'Software Engineer');
    const jobTitleIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: jobTitleAttributeValue);
    final jobTitleRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.JobTitle',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.JobTitle',
            description: 'i18n://dvo.attribute.description.JobTitle',
            content: jobTitleIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'JobTitle',
        renderHints: jobTitleRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.JobTitle',
        type: 'DraftIdentityAttributeDVO',
        content: jobTitleIdentityAttribute,
        owner: identityDvo,
        renderHints: jobTitleRenderHints,
        valueHints: const ValueHints(),
        valueType: 'JobTitle',
        isOwn: true,
        isDraft: true,
        value: jobTitleAttributeValue,
        tags: [],
      ),
    );

    final middleNameRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const middleNameAttributeValue = MiddleNameAttributeValue(value: 'Maxi');
    const middleNameIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: middleNameAttributeValue);
    final middleNameRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.MiddleName',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.MiddleName',
            description: 'i18n://dvo.attribute.description.MiddleName',
            content: middleNameIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'MiddleName',
        renderHints: middleNameRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.MiddleName',
        type: 'DraftIdentityAttributeDVO',
        content: middleNameIdentityAttribute,
        owner: identityDvo,
        renderHints: middleNameRenderHints,
        valueHints: const ValueHints(),
        valueType: 'MiddleName',
        isOwn: true,
        isDraft: true,
        value: middleNameAttributeValue,
        tags: [],
      ),
    );

    final phoneNumberRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const phoneNumberAttributeValue = PhoneNumberAttributeValue(value: '+49 675 5654125');
    const phoneNumberIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: phoneNumberAttributeValue);
    final phoneNumberRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.PhoneNumber',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.PhoneNumber',
            description: 'i18n://dvo.attribute.description.PhoneNumber',
            content: phoneNumberIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'PhoneNumber',
        renderHints: phoneNumberRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.PhoneNumber',
        type: 'DraftIdentityAttributeDVO',
        content: phoneNumberIdentityAttribute,
        owner: identityDvo,
        renderHints: phoneNumberRenderHints,
        valueHints: const ValueHints(),
        valueType: 'PhoneNumber',
        isOwn: true,
        isDraft: true,
        value: phoneNumberAttributeValue,
        tags: [],
      ),
    );

    final pseudonymRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const pseudonymAttributeValue = PseudonymAttributeValue(value: 'a Pseudonym');
    const pseudonymIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: pseudonymAttributeValue);
    final pseudonymRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Pseudonym',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.Pseudonym',
            description: 'i18n://dvo.attribute.description.Pseudonym',
            content: pseudonymIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'Pseudonym',
        renderHints: pseudonymRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Pseudonym',
        type: 'DraftIdentityAttributeDVO',
        content: pseudonymIdentityAttribute,
        owner: identityDvo,
        renderHints: pseudonymRenderHints,
        valueHints: const ValueHints(),
        valueType: 'Pseudonym',
        isOwn: true,
        isDraft: true,
        value: pseudonymAttributeValue,
        tags: [],
      ),
    );

    final stateRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const stateAttributeValue = StateAttributeValue(value: 'Bayern');
    const stateIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: stateAttributeValue);
    final stateRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.State',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.State',
            description: 'i18n://dvo.attribute.description.State',
            content: stateIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'State',
        renderHints: stateRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.State',
        type: 'DraftIdentityAttributeDVO',
        content: stateIdentityAttribute,
        owner: identityDvo,
        renderHints: stateRenderHints,
        valueHints: const ValueHints(),
        valueType: 'State',
        isOwn: true,
        isDraft: true,
        value: stateAttributeValue,
        tags: [],
      ),
    );

    final streetRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const streetAttributeValue = StreetAttributeValue(value: 'Musterstraße');
    const streetIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: streetAttributeValue);
    final streetRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Street',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.Street',
            description: 'i18n://dvo.attribute.description.Street',
            content: streetIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'Street',
        renderHints: streetRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Street',
        type: 'DraftIdentityAttributeDVO',
        content: streetIdentityAttribute,
        owner: identityDvo,
        renderHints: streetRenderHints,
        valueHints: const ValueHints(),
        valueType: 'Street',
        isOwn: true,
        isDraft: true,
        value: streetAttributeValue,
        tags: [],
      ),
    );

    final surnameRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const surnameAttributeValue = SurnameAttributeValue(value: 'Mustermann');
    const surnameIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: surnameAttributeValue);
    final surnameRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Surname',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.Surname',
            description: 'i18n://dvo.attribute.description.Surname',
            content: surnameIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'Surname',
        renderHints: surnameRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Surname',
        type: 'DraftIdentityAttributeDVO',
        content: surnameIdentityAttribute,
        owner: identityDvo,
        renderHints: surnameRenderHints,
        valueHints: const ValueHints(),
        valueType: 'Surname',
        isOwn: true,
        isDraft: true,
        value: surnameAttributeValue,
        tags: [],
      ),
    );

    final zipCodeRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const zipCodeAttributeValue = ZipCodeAttributeValue(value: 'Mustermann');
    const zipCodeIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: zipCodeAttributeValue);
    final zipCodeRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.ZipCode',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.ZipCode',
            description: 'i18n://dvo.attribute.description.ZipCode',
            content: zipCodeIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'ZipCode',
        renderHints: zipCodeRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.ZipCode',
        type: 'DraftIdentityAttributeDVO',
        content: zipCodeIdentityAttribute,
        owner: identityDvo,
        renderHints: zipCodeRenderHints,
        valueHints: const ValueHints(),
        valueType: 'ZipCode',
        isOwn: true,
        isDraft: true,
        value: zipCodeAttributeValue,
        tags: [],
      ),
    );

    final birthDayRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const birthDayAttributeValue = BirthDayAttributeValue(value: 24);
    const birthDayIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthDayAttributeValue);
    final birthDayRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthDay',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.BirthDay',
            description: 'i18n://dvo.attribute.description.BirthDay',
            content: birthDayIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'BirthDay',
        renderHints: birthDayRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthDay',
        type: 'DraftIdentityAttributeDVO',
        content: birthDayIdentityAttribute,
        owner: identityDvo,
        renderHints: birthDayRenderHints,
        valueHints: const ValueHints(),
        valueType: 'BirthDay',
        isOwn: true,
        isDraft: true,
        value: birthDayAttributeValue,
        tags: [],
      ),
    );

    final birthMonthRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const birthMonthAttributeValue = BirthMonthAttributeValue(value: 12);
    const birthMonthIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthMonthAttributeValue);
    final birthMonthRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthMonth',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.BirthMonth',
            description: 'i18n://dvo.attribute.description.BirthMonth',
            content: birthMonthIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'BirthMonth',
        renderHints: birthMonthRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthMonth',
        type: 'DraftIdentityAttributeDVO',
        content: birthMonthIdentityAttribute,
        owner: identityDvo,
        renderHints: birthMonthRenderHints,
        valueHints: const ValueHints(),
        valueType: 'BirthMonth',
        isOwn: true,
        isDraft: true,
        value: birthMonthAttributeValue,
        tags: [],
      ),
    );

    final birthYearRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const birthYearAttributeValue = BirthYearAttributeValue(value: 1990);
    const birthYearIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: birthYearAttributeValue);
    final birthYearRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthYear',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.BirthYear',
            description: 'i18n://dvo.attribute.description.BirthYear',
            content: birthYearIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'BirthYear',
        renderHints: birthYearRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.BirthYear',
        type: 'DraftIdentityAttributeDVO',
        content: birthYearIdentityAttribute,
        owner: identityDvo,
        renderHints: birthYearRenderHints,
        valueHints: const ValueHints(),
        valueType: 'BirthYear',
        isOwn: true,
        isDraft: true,
        value: birthYearAttributeValue,
        tags: [],
      ),
    );

    final citizenshipRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const citizenshipAttributeValue = CitizenshipAttributeValue(value: 'Germany');
    const citizenshipIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: citizenshipAttributeValue);
    final citizenshipRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Citizenship',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.Citizenship',
            description: 'i18n://dvo.attribute.description.Citizenship',
            content: citizenshipIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'Citizenship',
        renderHints: citizenshipRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Citizenship',
        type: 'DraftIdentityAttributeDVO',
        content: citizenshipIdentityAttribute,
        owner: identityDvo,
        renderHints: citizenshipRenderHints,
        valueHints: const ValueHints(),
        valueType: 'Citizenship',
        isOwn: true,
        isDraft: true,
        value: citizenshipAttributeValue,
        tags: [],
      ),
    );

    final communicationLanguageRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const communicationLanguageAttributeValue = CommunicationLanguageAttributeValue(value: 'German');
    const communicationLanguageIdentityAttribute =
        IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: communicationLanguageAttributeValue);
    final communicationLanguageRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.CommunicationLanguage',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.CommunicationLanguage',
            description: 'i18n://dvo.attribute.description.CommunicationLanguage',
            content: communicationLanguageIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'CommunicationLanguage',
        renderHints: communicationLanguageRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.CommunicationLanguage',
        type: 'DraftIdentityAttributeDVO',
        content: communicationLanguageIdentityAttribute,
        owner: identityDvo,
        renderHints: communicationLanguageRenderHints,
        valueHints: const ValueHints(),
        valueType: 'CommunicationLanguage',
        isOwn: true,
        isDraft: true,
        value: communicationLanguageAttributeValue,
        tags: [],
      ),
    );

    final countryRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const countryAttributeValue = CountryAttributeValue(value: 'Füssen');
    const countryIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: countryAttributeValue);
    final countryRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Country',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.Country',
            description: 'i18n://dvo.attribute.description.Country',
            content: countryIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'Country',
        renderHints: countryRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Country',
        type: 'DraftIdentityAttributeDVO',
        content: countryIdentityAttribute,
        owner: identityDvo,
        renderHints: countryRenderHints,
        valueHints: const ValueHints(),
        valueType: 'Country',
        isOwn: true,
        isDraft: true,
        value: countryAttributeValue,
        tags: [],
      ),
    );

    final eMailAddressRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const eMailAddressAttributeValue = EMailAddressAttributeValue(value: 'max@mustermann.de');
    const eMailAddressIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: eMailAddressAttributeValue);
    final eMailAddressRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.EMailAddress',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.EMailAddress',
            description: 'i18n://dvo.attribute.description.EMailAddress',
            content: eMailAddressIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'EMailAddress',
        renderHints: eMailAddressRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.EMailAddress',
        type: 'DraftIdentityAttributeDVO',
        content: eMailAddressIdentityAttribute,
        owner: identityDvo,
        renderHints: eMailAddressRenderHints,
        valueHints: const ValueHints(),
        valueType: 'EMailAddress',
        isOwn: true,
        isDraft: true,
        value: eMailAddressAttributeValue,
        tags: [],
      ),
    );

    final faxNumberRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const faxNumberAttributeValue = FaxNumberAttributeValue(value: '06526486151684');
    const faxNumberIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: faxNumberAttributeValue);
    final faxNumberRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.FaxNumber',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.FaxNumber',
            description: 'i18n://dvo.attribute.description.FaxNumber',
            content: faxNumberIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'FaxNumber',
        renderHints: faxNumberRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.FaxNumber',
        type: 'DraftIdentityAttributeDVO',
        content: faxNumberIdentityAttribute,
        owner: identityDvo,
        renderHints: faxNumberRenderHints,
        valueHints: const ValueHints(),
        valueType: 'FaxNumber',
        isOwn: true,
        isDraft: true,
        value: faxNumberAttributeValue,
        tags: [],
      ),
    );

    final nationalityRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const nationalityAttributeValue = NationalityAttributeValue(value: 'Germany');
    const nationalityIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: nationalityAttributeValue);
    final nationalityRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Nationality',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.Nationality',
            description: 'i18n://dvo.attribute.description.Nationality',
            content: nationalityIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'Nationality',
        renderHints: nationalityRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Nationality',
        type: 'DraftIdentityAttributeDVO',
        content: nationalityIdentityAttribute,
        owner: identityDvo,
        renderHints: nationalityRenderHints,
        valueHints: const ValueHints(),
        valueType: 'Nationality',
        isOwn: true,
        isDraft: true,
        value: nationalityAttributeValue,
        tags: [],
      ),
    );

    final sexRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const sexAttributeValue = SexAttributeValue(value: 'Male');
    const sexIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: sexAttributeValue);
    final sexRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Sex',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.Sex',
            description: 'i18n://dvo.attribute.description.Sex',
            content: sexIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'Sex',
        renderHints: sexRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Sex',
        type: 'DraftIdentityAttributeDVO',
        content: sexIdentityAttribute,
        owner: identityDvo,
        renderHints: sexRenderHints,
        valueHints: const ValueHints(),
        valueType: 'Sex',
        isOwn: true,
        isDraft: true,
        value: sexAttributeValue,
        tags: [],
      ),
    );

    final websiteRenderHints = RenderHints(technicalType: RenderHintsTechnicalType.String, editType: RenderHintsEditType.InputLike);
    const websiteAttributeValue = WebsiteAttributeValue(value: 'www.max-mustermann.com');
    const websiteIdentityAttribute = IdentityAttribute(owner: 'id13ggHCcrFrWYk92br5qhy6NQGDz1W2fRAd', value: websiteAttributeValue);
    final websiteRequestItem = DecidableProposeAttributeRequestItemDVO(
      id: '',
      name: 'i18n://dvo.requestItem.DecidableProposeAttributeRequestItem.name',
      mustBeAccepted: true,
      query: ProcessedIdentityAttributeQueryDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Website',
        results: [
          RepositoryAttributeDVO(
            id: 'ATTfXgC9wku9mXrTv9T9',
            name: 'i18n://dvo.attribute.name.Website',
            description: 'i18n://dvo.attribute.description.Website',
            content: websiteIdentityAttribute,
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
        ],
        tags: [],
        valueType: 'Website',
        renderHints: websiteRenderHints,
        valueHints: const ValueHints(),
      ),
      attribute: DraftIdentityAttributeDVO(
        id: '',
        name: 'i18n://dvo.attribute.name.Website',
        type: 'DraftIdentityAttributeDVO',
        content: websiteIdentityAttribute,
        owner: identityDvo,
        renderHints: websiteRenderHints,
        valueHints: const ValueHints(),
        valueType: 'Website',
        isOwn: true,
        isDraft: true,
        value: websiteAttributeValue,
        tags: [],
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
      child: Padding(
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
    );
  }
}
