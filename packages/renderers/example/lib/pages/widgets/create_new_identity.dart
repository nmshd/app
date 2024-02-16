import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CreateNewIdentity extends StatefulWidget {
  final Function(LocalAccountDTO) onAccountCreated;
  const CreateNewIdentity({super.key, required this.onAccountCreated});

  @override
  State<CreateNewIdentity> createState() => _CreateNewIdentityState();
}

class _CreateNewIdentityState extends State<CreateNewIdentity> {
  bool _confirmEnabled = false;
  bool _loading = false;

  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    _controller.addListener(() => setState(() => _confirmEnabled = _controller.text.isNotEmpty));
    _focusNode.requestFocus();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: MediaQuery.of(context).viewInsets.bottom + 12),
      child: Wrap(
        children: [
          Column(
            children: [
              const Text(
                'Choose identity',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              TextField(
                enabled: !_loading,
                focusNode: _focusNode,
                controller: _controller,
                onSubmitted: _loading ? null : (_) => _confirmEnabled ? _confirm() : _focusNode.requestFocus(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(130, 36.0)),
                    onPressed: _loading ? null : () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size(130, 36.0)),
                    onPressed: _confirmEnabled && !_loading ? _confirm : null,
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirm() async {
    setState(() {
      _confirmEnabled = false;
      _loading = true;
    });

    final account = await GetIt.I.get<EnmeshedRuntime>().accountServices.createAccount(name: _controller.text);

    if (mounted) Navigator.pop(context);
    widget.onAccountCreated(account);
  }
}
