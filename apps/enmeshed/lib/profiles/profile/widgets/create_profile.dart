import 'dart:math';
import 'dart:typed_data';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'change_profile_picture.dart';

class CreateProfile extends StatefulWidget {
  final void Function(LocalAccountDTO) onProfileCreated;
  final VoidCallback? onBackPressed;
  final String? description;
  final bool isInDialog;

  const CreateProfile({required this.onProfileCreated, super.key, this.onBackPressed, this.description, this.isInDialog = false});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  bool _profilePictureLoading = false;
  bool _loading = false;

  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  Uint8List? _newProfilePicture;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() => setState(() {}));
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 24,
            right: 24,
            bottom: max(MediaQuery.viewInsetsOf(context).bottom, MediaQuery.viewPaddingOf(context).bottom),
          ),
          child: Wrap(
            spacing: 8,
            children: [
              Align(
                alignment: widget.onBackPressed != null ? Alignment.center : Alignment.centerLeft,
                child: Text(context.l10n.profiles_createNew, style: Theme.of(context).textTheme.titleLarge),
              ),
              Gaps.h8,
              if (widget.description != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(widget.description!),
                ),
                Gaps.h8,
              ],
              ChangeProfilePicture(
                profileName: _controller.text,
                onProfilePictureDeleted: () => _newProfilePicture = null,
                onProfilePictureChanged: (Uint8List byteData) => _newProfilePicture = byteData,
                setProfilePictureLoading: ({required bool loading}) => setState(() => _profilePictureLoading = loading),
              ),
              Gaps.h32,
              TextField(
                focusNode: _focusNode,
                maxLength: MaxLength.profileName,
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: context.l10n.profile_name,
                  suffixIcon: IconButton(
                    onPressed: _controller.clear,
                    icon: const Icon(Icons.cancel_outlined),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onSubmitted: (_) => _confirmEnabled ? _confirm() : _focusNode.requestFocus(),
              ),
              Gaps.h8,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: _confirmEnabled ? _confirm : null,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(100, 36),
                    ),
                    child: Text(context.l10n.profile_create),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(onPressed: _loading && !_confirmEnabled ? null : () => context.pop(), icon: const Icon(Icons.close)),
        ),
        if (widget.onBackPressed != null)
          Positioned(
            top: 8,
            left: 8,
            child: IconButton(icon: Icon(context.adaptiveBackIcon), onPressed: widget.onBackPressed),
          ),
        if (_loading) ModalLoadingOverlay(text: context.l10n.profile_create_inProgress, isDialog: widget.isInDialog),
      ],
    );
  }

  bool get _confirmEnabled => !_profilePictureLoading && _controller.text.isNotEmpty;

  Future<void> _confirm() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _loading = true;
    });

    final account = await GetIt.I.get<EnmeshedRuntime>().accountServices.createAccount(name: _controller.text);

    if (_newProfilePicture != null) {
      await saveProfilePicture(byteData: _newProfilePicture!, accountReference: account.id);
    }

    widget.onProfileCreated(account);
  }
}
