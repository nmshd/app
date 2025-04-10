import 'dart:math';
import 'dart:typed_data';

import 'package:enmeshed/core/utils/extensions.dart';
import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../utils/profile_picture_utils.dart';
import 'change_profile_picture.dart';
import 'modal_loading_overlay.dart';

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

  Uint8List? _newProfilePicture;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() => setState(() {}));
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
                spacing: 8,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8, left: widget.onBackPressed != null ? 8 : 24, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.onBackPressed != null) IconButton(icon: Icon(context.adaptiveBackIcon), onPressed: widget.onBackPressed),
                        Text(context.l10n.profiles_createNew, style: Theme.of(context).textTheme.titleLarge),
                        IconButton(onPressed: _loading && !_confirmEnabled ? null : () => context.pop(), icon: const Icon(Icons.close)),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.description != null) ...[
                              Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24), child: Text(widget.description!)),
                              Gaps.h20,
                            ],
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: ChangeProfilePicture(
                                profileName: _controller.text,
                                onProfilePictureDeleted: () => _newProfilePicture = null,
                                onProfilePictureChanged: (Uint8List byteData) => _newProfilePicture = byteData,
                                setProfilePictureLoading: ({required bool loading}) => setState(() => _profilePictureLoading = loading),
                              ),
                            ),
                            Gaps.h32,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(context.l10n.mandatoryField, style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Gaps.h24,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: TextField(
                                controller: _controller,
                                maxLength: MaxLength.profileName,
                                textCapitalization: TextCapitalization.sentences,
                                scrollPadding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom + DefaultTextStyle.of(context).style.fontSize! * 3,
                                ),
                                decoration: InputDecoration(
                                  labelText: '${context.l10n.profile_name}*',
                                  suffixIcon: IconButton(onPressed: _controller.clear, icon: const Icon(Icons.cancel_outlined)),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton(
                        onPressed: _confirmEnabled ? _confirm : null,
                        style: OutlinedButton.styleFrom(minimumSize: const Size(100, 36)),
                        child: Text(context.l10n.profile_create),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_loading) ModalLoadingOverlay(text: context.l10n.profile_create_inProgress, isDialog: widget.isInDialog),
          ],
        ),
      ),
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
