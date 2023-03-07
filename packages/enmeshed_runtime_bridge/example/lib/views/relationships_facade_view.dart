import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';

class RelationshipsFacadeView extends StatelessWidget {
  final EnmeshedRuntime runtime;

  const RelationshipsFacadeView({super.key, required this.runtime});

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
              final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();
              print(relationships.length);
              print(relationships);
            },
            child: const Text('getRelationships'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();
              final relationshipId = relationships.first.id;
              final relationship = await runtime.currentSession.transportServices.relationships.getRelationship(relationshipId: relationshipId);
              print(relationship);
            },
            child: const Text('getRelationship'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();
              final address = relationships.first.peerIdentity.address;
              final relationship = await runtime.currentSession.transportServices.relationships.getRelationshipByAddress(address: address);
              print(relationship);
            },
            child: const Text('getRelationshipByAddress'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              const templateId = '';
              final relationship = await runtime.currentSession.transportServices.relationships.createRelationship(
                templateId: templateId,
                content: {},
              );
              print(relationship);
            },
            child: const Text('createRelationship'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              const relationshipId = '';
              const changeId = '';
              final relationship = await runtime.currentSession.transportServices.relationships.acceptRelationshipChange(
                relationshipId: relationshipId,
                changeId: changeId,
                content: {},
              );
              print(relationship);
            },
            child: const Text('acceptRelationshipChange'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              const relationshipId = '';
              const changeId = '';
              final content = <String, dynamic>{};
              final relationship = await runtime.currentSession.transportServices.relationships.rejectRelationshipChange(
                relationshipId: relationshipId,
                changeId: changeId,
                content: content,
              );
              print(relationship);
            },
            child: const Text('rejectRelationshipChange'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              const relationshipId = '';
              const changeId = '';
              final content = <String, dynamic>{};
              final relationship = await runtime.currentSession.transportServices.relationships.revokeRelationshipChange(
                relationshipId: relationshipId,
                changeId: changeId,
                content: content,
              );
              print(relationship);
            },
            child: const Text('revokeRelationshipChange'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();
              if (relationships.isEmpty) return;

              final attributes = await runtime.currentSession.transportServices.relationships.getAttributesForRelationship(
                relationshipId: relationships.first.id,
              );
              print(attributes);
            },
            child: const Text('getAttributesForRelationship'),
          ),
        ],
      ),
    );
  }
}
