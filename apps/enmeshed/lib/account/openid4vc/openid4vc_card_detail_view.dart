import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class OpenId4VcCardDetailView extends StatefulWidget {
  const OpenId4VcCardDetailView({required this.accountId, required this.credentialId, required this.displayInformation, super.key});
  final String credentialId;
  final String accountId;
  final Map<String, dynamic>? displayInformation;

  @override
  State<OpenId4VcCardDetailView> createState() => _OpenId4VcCardDetailViewState();
}

class _OpenId4VcCardDetailViewState extends State<OpenId4VcCardDetailView> {
  late VerifiableCredentialDTO? _enmeshedStoredClaim;
  late bool _isError = false;

  @override
  void initState() {
    super.initState();
    _loadStoredClaims();
  }

  Future<void> _loadStoredClaims() async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId);
    await session.transportServices.account.syncEverything();
    if (!mounted) return;
    final result = await session.consumptionServices.openId4Vc.getStoredClaimWithId(widget.credentialId);
    if (result.isError) {
      _isError = true;
      setState(() {});
      return;
    }
    _enmeshedStoredClaim = result.value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail View')),
      body: _isError
          ? const Center(
              child: Text(
                'An error occurred while loading the credential.',
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _enmeshedStoredClaim != null ? _enmeshedStoredClaim!.data : ' ',
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ),
            ),
    );
  }
}
