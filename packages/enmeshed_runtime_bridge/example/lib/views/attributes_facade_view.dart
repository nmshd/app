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
              final attribute = await runtime.currentSession.consumptionServices.attributes.createIdentityAttribute(
                value: const DisplayNameAttributeValue(value: 'ADisplayName'),
              );
              print(attribute);
            },
            child: const Text('createAttribute'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();

              final peer = relationships.value.first.peer;
              final attributes = await runtime.currentSession.consumptionServices.attributes.getPeerSharedAttributes(
                peer: peer,
              );
              print(attributes);
            },
            child: const Text('getPeerSharedAttributes'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();

              final peer = relationships.value.first.peer;
              final attributes = await runtime.currentSession.consumptionServices.attributes.getOwnSharedAttributes(
                peer: peer,
              );
              print(attributes);
            },
            child: const Text('getOwnSharedAttributes'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final attributes = await runtime.currentSession.consumptionServices.attributes.getAttributes();
              if (attributes.value.isEmpty) {
                print('There are no attributes to get!');
                return;
              }
              final attributeId = attributes.value.first.id;
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
              await runtime.currentSession.consumptionServices.attributes.createIdentityAttribute(
                value: const PhoneNumberAttributeValue(value: '012345678910'),
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
              final createdAttribute = await runtime.currentSession.consumptionServices.attributes.createIdentityAttribute(
                value: const PhoneNumberAttributeValue(value: '012345678910'),
              );

              final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();

              final attributeId = createdAttribute.value.id;
              final peer = relationships.value.last.peer;
              final request = await runtime.currentSession.consumptionServices.attributes.shareIdentityAttribute(
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
