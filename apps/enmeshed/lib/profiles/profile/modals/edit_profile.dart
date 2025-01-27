import 'dart:io';
import 'dart:math';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../widgets/change_profile_picture.dart';

Future<void> showEditProfileModal({
  required void Function() onEditAccount,
  required LocalAccountDTO localAccount,
  required File? initialProfilePicture,
  required BuildContext context,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (builder) => _EditProfile(
      onAccountEditDone: onEditAccount,
      localAccount: localAccount,
      initialProfilePicture: initialProfilePicture,
    ),
  );
}

class _EditProfile extends StatefulWidget {
  final VoidCallback onAccountEditDone;
  final LocalAccountDTO localAccount;
  final File? initialProfilePicture;

  const _EditProfile({
    required this.onAccountEditDone,
    required this.localAccount,
    required this.initialProfilePicture,
  });

  @override
  State<_EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<_EditProfile> {
  bool _profilePictureLoading = false;
  bool _loading = false;

  final _controller = TextEditingController();

  bool _deleteProfilePicture = false;
  Uint8List? _newProfilePicture;

  @override
  void initState() {
    super.initState();

    _controller
      ..text = widget.localAccount.name
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_loading,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: max(MediaQuery.viewInsetsOf(context).bottom, MediaQuery.viewPaddingOf(context).bottom)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 24, right: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(context.l10n.profile_edit, style: Theme.of(context).textTheme.titleLarge),
                        IconButton(onPressed: _loading ? null : () => context.pop(), icon: const Icon(Icons.close)),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: ChangeProfilePicture(
                                profileName: _controller.text,
                                onProfilePictureDeleted: _onProfilePictureDeleted,
                                onProfilePictureChanged: _onProfilePictureChanged,
                                initialProfilePicture: widget.initialProfilePicture,
                                setProfilePictureLoading: ({required bool loading}) => setState(() => _profilePictureLoading = loading),
                              ),
                            ),
                            Gaps.h32,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: TextField(
                                controller: _controller,
                                maxLength: MaxLength.profileName,
                                textCapitalization: TextCapitalization.sentences,
                                scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                              ),
                            ),
                            Gaps.h24,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => context.pop(),
                          child: Text(context.l10n.cancel),
                        ),
                        FilledButton(
                          onPressed: _confirmEnabled ? _confirm : null,
                          child: Text(context.l10n.save),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_loading) ModalLoadingOverlay(text: context.l10n.profile_edit_inProgress, isDialog: false),
          ],
        ),
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

    setState(() {
      _loading = true;
    });

    await GetIt.I.get<EnmeshedRuntime>().accountServices.renameAccount(localAccountId: widget.localAccount.id, newAccountName: _controller.text);

    if (_deleteProfilePicture) {
      await deleteProfilePictureSetting(accountReference: widget.localAccount.id);
    } else if (_newProfilePicture != null) {
      await saveProfilePicture(byteData: _newProfilePicture!, accountReference: widget.localAccount.id);
    }

    if (mounted) context.pop();
    widget.onAccountEditDone();
  }
}
