import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class OutgoingRequestsFacadeView extends StatelessWidget {
  final EnmeshedRuntime runtime;

  const OutgoingRequestsFacadeView({super.key, required this.runtime});

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
              const Request content = Request(
                items: [
                  ReadAttributeRequestItem(
                    mustBeAccepted: true,
                    query: IdentityAttributeQuery(valueType: 'GivenName'),
                  ),
                ],
              );
              final request = await runtime.currentSession.consumptionServices.outgoingRequests.canCreate(content: content);
              print(request);
            },
            child: const Text('canCreate'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final relationships = await runtime.currentSession.transportServices.relationships.getRelationships();
              if (relationships.value.isEmpty) return;

              final peer = relationships.value.first.peerIdentity.address;

              const content = Request(
                items: [
                  ReadAttributeRequestItem(
                    mustBeAccepted: true,
                    query: IdentityAttributeQuery(valueType: 'GivenName'),
                  ),
                ],
              );
              final request = await runtime.currentSession.consumptionServices.outgoingRequests.create(content: content, peer: peer);
              print(request);
            },
            child: const Text('create'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final requests = await runtime.currentSession.consumptionServices.outgoingRequests.getRequests();
              if (requests.value.isEmpty) {
                print('There are no requests');
                return;
              }

              final request = await runtime.currentSession.consumptionServices.outgoingRequests.getRequest(requestId: requests.value.first.id);
              print(request);
            },
            child: const Text('getRequest'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final requests = await runtime.currentSession.consumptionServices.outgoingRequests.getRequests();
              if (requests.value.isEmpty) {
                print('There are no requests');
                return;
              }
              print(requests);
            },
            child: const Text('getRequests'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final requests = await runtime.currentSession.consumptionServices.outgoingRequests.getRequests(query: {
                'status': LocalRequestStatus.Draft.asQueryValue,
              });

              if (requests.value.isEmpty) {
                print('There are no requests to discard');
                return;
              }

              await runtime.currentSession.consumptionServices.outgoingRequests.discard(requestId: requests.value.first.id);
            },
            child: const Text('discard'),
          ),
        ],
      ),
    );
  }
}
