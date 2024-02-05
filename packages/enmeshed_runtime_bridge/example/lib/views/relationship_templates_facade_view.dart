import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/material.dart';

class RelationshipTemplatesFacadeView extends StatelessWidget {
  final EnmeshedRuntime runtime;

  const RelationshipTemplatesFacadeView({super.key, required this.runtime});

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
              final relationshipTemplate = await runtime.currentSession.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
                expiresAt: DateTime.now().add(const Duration(days: 365)).toIso8601String(),
                content: {},
              );
              print(relationshipTemplate);
            },
            child: const Text('createOwnRelationshipTemplate'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              const relationshipTemplateId = '';
              const secretKey = '';
              final relationshipTemplate =
                  await runtime.currentSession.transportServices.relationshipTemplates.loadPeerRelationshipTemplateByIdAndKey(
                relationshipTemplateId: relationshipTemplateId,
                secretKey: secretKey,
              );
              print(relationshipTemplate);
            },
            child: const Text('loadPeerRelationshipTemplateByIdAndKey'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              const reference = '';
              final relationshipTemplate =
                  await runtime.currentSession.transportServices.relationshipTemplates.loadPeerRelationshipTemplateByReference(reference: reference);
              print(relationshipTemplate);
            },
            child: const Text('loadPeerRelationshipTemplateByReference'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationshipTemplates = await runtime.currentSession.transportServices.relationshipTemplates.getRelationshipTemplates();
              print(relationshipTemplates);
            },
            child: const Text('getRelationshipTemplates'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationshipTemplatesResult = await runtime.currentSession.transportServices.relationshipTemplates.getRelationshipTemplates();
              final relationshipTemplates = relationshipTemplatesResult.value;
              if (relationshipTemplates.isEmpty) return;

              final relationshipTemplate = await runtime.currentSession.transportServices.relationshipTemplates.getRelationshipTemplate(
                relationshipTemplateId: relationshipTemplates.first.id,
              );
              print(relationshipTemplate);
            },
            child: const Text('getRelationshipTemplate'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationshipTemplatesResult = await runtime.currentSession.transportServices.relationshipTemplates.getRelationshipTemplates();
              final relationshipTemplates = relationshipTemplatesResult.value;
              if (relationshipTemplates.isEmpty) return;

              final response = await runtime.currentSession.transportServices.relationshipTemplates.createQRCodeForOwnTemplate(
                templateId: relationshipTemplates.first.id,
              );
              print(response);
            },
            child: const Text('createQRCodeForOwnTemplate'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationshipTemplatesResult = await runtime.currentSession.transportServices.relationshipTemplates.getRelationshipTemplates();
              final relationshipTemplates = relationshipTemplatesResult.value;
              if (relationshipTemplates.isEmpty) return;

              final response = await runtime.currentSession.transportServices.relationshipTemplates.createTokenQRCodeForOwnTemplate(
                templateId: relationshipTemplates.first.id,
              );
              print(response);
            },
            child: const Text('createTokenQRCodeForOwnTemplate'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationshipTemplatesResult = await runtime.currentSession.transportServices.relationshipTemplates.getRelationshipTemplates();
              final relationshipTemplates = relationshipTemplatesResult.value;
              if (relationshipTemplates.isEmpty) return;

              final token = await runtime.currentSession.transportServices.relationshipTemplates.createTokenForOwnTemplate(
                templateId: relationshipTemplates.first.id,
              );
              print(token);
            },
            child: const Text('createTokenForOwnTemplate'),
          ),
        ],
      ),
    );
  }
}
