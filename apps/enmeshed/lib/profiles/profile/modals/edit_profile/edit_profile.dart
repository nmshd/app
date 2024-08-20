import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../../widgets/change_profile_picture.dart';

class EditProfile extends StatefulWidget {
  final VoidCallback setLoading;
  final VoidCallback onAccountEditDone;
  final LocalAccountDTO localAccount;
  final File? initialProfilePicture;

  const EditProfile({
    required this.setLoading,
    required this.onAccountEditDone,
    required this.localAccount,
    required this.initialProfilePicture,
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _profilePictureLoading = false;

  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  bool _deleteProfilePicture = false;
  Uint8List? _newProfilePicture;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() => setState(() {}));
    _focusNode.requestFocus();
    _controller.text = widget.localAccount.name;
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.viewInsetsOf(context).bottom + 24),
      child: Column(
        children: [
          ChangeProfilePicture(
            profileName: _controller.text,
            onProfilePictureDeleted: _onProfilePictureDeleted,
            onProfilePictureChanged: _onProfilePictureChanged,
            initialProfilePicture: widget.initialProfilePicture,
            setProfilePictureLoading: ({required bool loading}) => setState(() => _profilePictureLoading = loading),
          ),
          Gaps.h32,
          TextField(
            focusNode: _focusNode,
            controller: _controller,
            maxLength: MaxLength.profileName,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: _controller.clear,
                icon: const Icon(Icons.cancel_outlined),
              ),
              labelText: context.l10n.profile_name,
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            onSubmitted: (_) => _confirmEnabled ? _confirm() : _focusNode.requestFocus(),
          ),
          Gaps.h24,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () => context.pop(),
                child: Text(context.l10n.cancel),
              ),
              Gaps.w8,
              FilledButton(
                onPressed: _confirmEnabled ? _confirm : null,
                child: Text(context.l10n.save),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool get _confirmEnabled => !_profilePictureLoading && _controller.text.isNotEmpty;

  void _onProfilePictureDeleted() {
    _deleteProfilePicture = true;
    _newProfilePicture = null;
  }

  void _onProfilePictureChanged(Uint8List byteData) {
    _newProfilePicture = byteData;
    _deleteProfilePicture = false;
  }

  Future<void> _confirm() async {
    FocusScope.of(context).unfocus();

    widget.setLoading();

    await GetIt.I.get<EnmeshedRuntime>().accountServices.renameAccount(localAccountId: widget.localAccount.id, newAccountName: _controller.text);

    if (_deleteProfilePicture) {
      await deleteProfilePictureSetting(accountReference: widget.localAccount.id);
    } else if (_newProfilePicture != null) {
      await saveProfilePicture(byteData: _newProfilePicture!, accountReference: widget.localAccount.id);
    }

    widget.onAccountEditDone();
  }
}
