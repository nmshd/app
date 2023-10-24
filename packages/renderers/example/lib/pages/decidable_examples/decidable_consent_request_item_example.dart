import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

class DecidableConsentRequestItemExample extends StatelessWidget {
  const DecidableConsentRequestItemExample({super.key});

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

    const decidableConsentRequestItem = DecidableConsentRequestItemDVO(
      id: '1',
      name: 'Read 1',
      mustBeAccepted: true,
      consent: 'Consent Text',
      link: 'http://example.com',
    );

    const localRequest = LocalRequestDVO(
      id: 'a id',
      name: 'a name',
      type: 'LocalRequestDVO',
      isOwn: false,
      createdAt: '2023-09-27T11:41:36.933Z',
      content: RequestDVO(
        id: 'REQyB8AzanfTmT3afh8e',
        name: 'Request REQyB8AzanfTmT3afh8e',
        type: 'RequestDVO',
        items: [decidableConsentRequestItem],
      ),
      status: LocalRequestStatus.ManualDecisionRequired,
      statusText: 'a statusText',
      directionText: 'a directionText',
      sourceTypeText: 'a sourceTypeText',
      createdBy: identityDvo,
      peer: identityDvo,
      decider: identityDvo,
      isDecidable: false,
      items: [decidableConsentRequestItem],
    );

    return const Padding(
      padding: EdgeInsets.all(16),
      // child: RequestRenderer(request: localRequest),
    );
  }
}
