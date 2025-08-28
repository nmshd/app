import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class OpenId4VcView extends StatefulWidget {
  const OpenId4VcView({required this.accountId, super.key});

  final String accountId;

  @override
  OpenId4VcViewState createState() => OpenId4VcViewState();
}

class OpenId4VcViewState extends State<OpenId4VcView> {
  String credentialOfferUrl = '';
  List<VerifiableCredentialDTO> credentialsAccepted = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OpenID4VC - ${widget.accountId}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'CredentialOffer-URL',
              ),
              onChanged: (value) => credentialOfferUrl = value,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final url = credentialOfferUrl;
                final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
                final result = await session.consumptionServices.openId4Vc.acceptCredentialOffer(url);
                if (result.isError) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${result.error.message}')));
                  }
                } else {
                  if (mounted) {
                    VerifiableCredentialDTO credential = result.value;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Credential accepted: ${credential.data}')));
                  }
                }
              },
              child: const Text('Submit'),
            ),
            // build a list view which shows all accepted credentials
            Expanded(
              child: ListView.builder(
                itemCount: credentialsAccepted.length,
                itemBuilder: (context, index) {
                  final credential = credentialsAccepted[index];
                  return ListTile(
                    title: Text('Credential ${index + 1}'),
                    subtitle: Text(credential.data),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
