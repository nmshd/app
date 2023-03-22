import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class AttributesFacadeView extends StatelessWidget {
  final EnmeshedRuntime runtime;

  const AttributesFacadeView({super.key, required this.runtime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              final identityInfo = await runtime.currentSession.transportServices.accounts.getIdentityInfo();

              final attribute = await runtime.currentSession.consumptionServices.attributes.createAttribute(
                content: {
                  '@type': 'IdentityAttribute',
                  'value': {
                    '@type': 'DisplayName',
                    'value': 'ADisplayName',
                  },
                  'owner': identityInfo.address,
                },
              );
              print(attribute);
            },
            child: const Text('createAttribute'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final identityInfo = await runtime.currentSession.transportServices.accounts.getIdentityInfo();

              final phAttribute = await runtime.currentSession.consumptionServices.attributes.createAttribute(
                content: {
                  '@type': 'IdentityAttribute',
                  'value': {
                    '@type': 'DisplayName',
                    'value': 'ADisplayName',
                  },
                  'owner': identityInfo.address,
                },
              );
              final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();

              final attributeId = phAttribute.id;
              final peer = relationships.first.peer;
              const requestReference = 'REQIDXXXXXXXXXXXXXXX';
              final attribute = await runtime.currentSession.consumptionServices.attributes.createSharedAttributeCopy(
                attributeId: attributeId,
                peer: peer,
                requestReference: requestReference,
              );
              print(attribute);
            },
            child: const Text('createSharedAttributeCopy'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final attributes = await runtime.currentSession.consumptionServices.attributes.getAttributes();
              if (attributes.isEmpty) {
                final identityInfo = await runtime.currentSession.transportServices.accounts.getIdentityInfo();

                final attribute = await runtime.currentSession.consumptionServices.attributes.createAttribute(
                  content: {
                    '@type': 'IdentityAttribute',
                    'value': {
                      '@type': 'DisplayName',
                      'value': 'ADisplayName',
                    },
                    'owner': identityInfo.address,
                  },
                );
                attributes.add(attribute);
              }

              print('attributes length before delete: ${attributes.length}');
              final attributeId = attributes.first.id;
              await runtime.currentSession.consumptionServices.attributes.deleteAttribute(
                attributeId: attributeId,
              );

              final attributesAfterDelete = await runtime.currentSession.consumptionServices.attributes.getAttributes();

              print('attributes length after delete: ${attributesAfterDelete.length}');
            },
            child: const Text('deleteAttribute'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();

              final peer = relationships.first.peer;
              final attributes = await runtime.currentSession.consumptionServices.attributes.getPeerAttributes(
                peer: peer,
              );
              print(attributes);
            },
            child: const Text('getPeerAttributes'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();

              final peer = relationships.first.peer;
              final attributes = await runtime.currentSession.consumptionServices.attributes.getSharedToPeerAttributes(
                peer: peer,
              );
              print(attributes);
            },
            child: const Text('getSharedToPeerAttributes'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final attributes = await runtime.currentSession.consumptionServices.attributes.getAttributes();
              if (attributes.isEmpty) {
                print('There are no attributes to get!');
                return;
              }
              final attributeId = attributes.first.id;
              final attribute = await runtime.currentSession.consumptionServices.attributes.getAttribute(
                attributeId: attributeId,
              );
              print(attribute);
            },
            child: const Text('getAttribute'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final attributes = await runtime.currentSession.consumptionServices.attributes.getAttributes();
              print(attributes);
            },
            child: const Text('getAttributes'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final identityInfo = await runtime.currentSession.transportServices.accounts.getIdentityInfo();

              await runtime.currentSession.consumptionServices.attributes.createAttribute(
                content: {
                  '@type': 'IdentityAttribute',
                  'value': {
                    '@type': 'PhoneNumber',
                    'value': '012345678910',
                  },
                  'owner': identityInfo.address,
                },
              );

              const query = IdentityAttributeQuery(valueType: 'PhoneNumber');
              final attributes = await runtime.currentSession.consumptionServices.attributes.executeIdentityAttributeQuery(
                query: query,
              );
              print(attributes);
            },
            child: const Text('executeIdentityAttributeQuery'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final identityInfo = await runtime.currentSession.transportServices.accounts.getIdentityInfo();

              await runtime.currentSession.consumptionServices.attributes.createAttribute(
                content: {
                  '@type': 'RelationshipAttribute',
                  'value': {
                    '@type': 'ProprietaryString',
                    'title': 'aTitle',
                    'value': 'aProprietaryStringValue',
                  },
                  'key': 'website',
                  'confidentiality': 'protected',
                  'owner': identityInfo.address,
                },
              );
              final owner = identityInfo.address;
              const attributeCreationHints = RelationshipAttributeCreationHints(
                title: 'AnAttributeHint',
                valueType: 'ProprietaryString',
                confidentiality: 'protected',
              );
              final query = RelationshipAttributeQuery(
                key: 'website',
                owner: owner,
                attributeCreationHints: attributeCreationHints,
              );
              final attribute = await runtime.currentSession.consumptionServices.attributes.executeRelationshipAttributeQuery(
                query: query,
              );
              print(attribute);
            },
            child: const Text('executeRelationshipAttributeQuery'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              const query = ThirdPartyRelationshipAttributeQuery(key: '', owner: '', thirdParty: ['']);
              final attributes = await runtime.currentSession.consumptionServices.attributes.executeThirdPartyRelationshipAttributeQuery(
                query: query,
              );
              print(attributes);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.withOpacity(0.3),
            ),
            child: const Text('executeThirdPartyRelationshipAttributeQuery'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final identityInfo = await runtime.currentSession.transportServices.accounts.getIdentityInfo();

              final displayNameParams = {
                '@type': 'IdentityAttribute',
                'value': {'@type': 'DisplayName', 'value': 'ADisplayName'},
                'owner': identityInfo.address,
              };

              final successorDate = DateTime.now().toUtc();

              final attribute = await runtime.currentSession.consumptionServices.attributes.createAttribute(
                content: displayNameParams,
              );
              print(attribute);
              final attributeId = attribute.id;

              final successorContent = {
                '@type': 'IdentityAttribute',
                'value': {'@type': 'DisplayName', 'value': 'ANewDisplayName'},
                'owner': identityInfo.address,
                'validFrom': successorDate.toString(),
              };
              final succeeds = attributeId;
              final successor = await runtime.currentSession.consumptionServices.attributes.succeedAttribute(
                successorContent: successorContent,
                succeeds: succeeds,
              );
              print(successor);
            },
            child: const Text('succeedAttribute'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final identityInfo = await runtime.currentSession.transportServices.accounts.getIdentityInfo();

              final createdAttribute = await runtime.currentSession.consumptionServices.attributes.createAttribute(
                content: {
                  '@type': 'IdentityAttribute',
                  'value': {
                    '@type': 'StreetAddress',
                    'recipient': 'ARecipient',
                    'street': 'AStreet',
                    'houseNo': 'AHouseNo',
                    'zipCode': 'AZipCode',
                    'city': 'ACity',
                    'country': 'DE',
                  },
                  'validTo': DateTime.now().toUtc().toString(),
                  'owner': identityInfo.address,
                },
              );
              final updatedAttribute = {
                '@type': 'IdentityAttribute',
                'value': {
                  '@type': 'StreetAddress',
                  'recipient': 'ANewRecipient',
                  'street': 'ANewStreet',
                  'houseNo': 'ANewHouseNo',
                  'zipCode': 'ANewZipCode',
                  'city': 'ANewCity',
                  'country': 'DE',
                },
                'validTo': DateTime.now().toUtc().toString(),
                'owner': identityInfo.address,
              };

              final attributeId = createdAttribute.id;
              final content = updatedAttribute;

              final attributeBU = await runtime.currentSession.consumptionServices.attributes.getAttribute(
                attributeId: attributeId,
              );

              final attribute = await runtime.currentSession.consumptionServices.attributes.updateAttribute(
                attributeId: attributeId,
                content: content,
              );

              final attributeAU = await runtime.currentSession.consumptionServices.attributes.getAttribute(
                attributeId: attributeId,
              );
              print(attribute);
              print('attributeBU');
              print(attributeBU);
              print('attributeAU');
              print(attributeAU);
            },
            child: const Text('updateAttribute'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final identityInfo = await runtime.currentSession.transportServices.accounts.getIdentityInfo();

              final createdAttribute = await runtime.currentSession.consumptionServices.attributes.createAttribute(
                content: {
                  '@type': 'IdentityAttribute',
                  'value': {'@type': 'PhoneNumber', 'value': '012345678910'},
                  'owner': identityInfo.address,
                },
              );

              final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();

              final attributeId = createdAttribute.id;
              final peer = relationships.last.peer;
              final request = await runtime.currentSession.consumptionServices.attributes.shareAttribute(
                attributeId: attributeId,
                peer: peer,
              );
              print(request);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.withOpacity(0.3),
            ),
            child: const Text('shareAttribute'),
          ),
        ],
      ),
    );
  }
}
