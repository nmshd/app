import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/core.dart';

class CreateDevice extends StatefulWidget {
  final String accountId;
  final VoidCallback setLoading;
  final void Function(DeviceDTO device, TokenDTO token) setDeviceAndToken;

  const CreateDevice({
    required this.accountId,
    required this.setLoading,
    required this.setDeviceAndToken,
    super.key,
  });

  @override
  State<CreateDevice> createState() => _CreateDeviceState();
}

class _CreateDeviceState extends State<CreateDevice> {
  bool get _confirmEnabled => _nameController.text.isNotEmpty;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() => setState(() {}));

    _nameFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();

    _nameFocusNode.dispose();
    _descriptionFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, left: 24, right: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            focusNode: _nameFocusNode,
            controller: _nameController,
            maxLength: MaxLength.deviceName,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: '${context.l10n.name}*',
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            onSubmitted: (value) => value.isEmpty ? _nameFocusNode.requestFocus() : _descriptionFocusNode.requestFocus(),
          ),
          Gaps.h8,
          TextField(
            focusNode: _descriptionFocusNode,
            controller: _descriptionController,
            maxLength: MaxLength.deviceDescription,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: context.l10n.devices_edit_description,
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            onSubmitted: (value) => _confirmEnabled ? _save() : _nameFocusNode.requestFocus(),
          ),
          Gaps.h8,
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: _confirmEnabled ? _save : null,
              child: Text(context.l10n.next),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();

    widget.setLoading();

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    final session = runtime.getSession(widget.accountId);

    final device = await session.transportServices.devices.createDevice(
      name: _nameController.text,
      description: _descriptionController.text,
      isAdmin: true,
    );

    final account = await runtime.accountServices.getAccount(widget.accountId);

    final token = await session.transportServices.devices.getDeviceOnboardingToken(device.value.id, profileName: account.name);

    widget.setDeviceAndToken(device.value, token.value);
  }
}
