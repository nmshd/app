import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';

class EditDevice extends StatefulWidget {
  final String accountId;
  final DeviceDTO device;
  final VoidCallback onDevicesChanged;

  const EditDevice({
    required this.accountId,
    required this.device,
    required this.onDevicesChanged,
    super.key,
  });

  @override
  State<EditDevice> createState() => _EditDeviceState();
}

class _EditDeviceState extends State<EditDevice> {
  bool _loading = false;
  bool get _confirmEnabled =>
      _nameController.text.isNotEmpty && (_nameController.text != widget.device.name || _descriptionController.text != widget.device.description);

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));

    _nameController.text = widget.device.name;
    _descriptionController.text = widget.device.description ?? '';

    _nameFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, left: 24, right: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
      child: Wrap(
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.l10n.devices_edit, style: Theme.of(context).textTheme.titleLarge),
              IconButton(
                onPressed: _loading ? null : () => context.pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Gaps.h16,
          TextField(
            enabled: !_loading,
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
            enabled: !_loading,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: _loading ? null : () => context.pop(), child: Text(context.l10n.cancel)),
              Gaps.w8,
              FilledButton(
                onPressed: _confirmEnabled && !_loading ? _save : null,
                child: Text(context.l10n.save),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _loading = true);

    final name = _nameController.text;
    final description = _descriptionController.text;

    await GetIt.I.get<EnmeshedRuntime>().getSession(widget.accountId).transportServices.devices.updateDevice(
          widget.device.id,
          name: name,
          description: description,
        );

    widget.onDevicesChanged();
    if (mounted) context.pop();
  }
}
