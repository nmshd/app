import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '../utils/account_utils.dart';
import '../utils/extensions.dart';
import 'profile_picture.dart';

class RestoreProfile extends StatefulWidget {
  final LocalAccountDTO accountInDeletion;

  const RestoreProfile({
    required this.accountInDeletion,
    super.key,
  });

  @override
  State<RestoreProfile> createState() => _RestoreProfileState();
}

class _RestoreProfileState extends State<RestoreProfile> {
  late final ScrollController _scrollController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    assert(widget.accountInDeletion.deletionDate != null, 'Account deletion date must not be null');

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoLoadingProfilePicture(
          radius: 20,
          accountId: widget.accountInDeletion.id,
          profileName: widget.accountInDeletion.name,
          decorative: true,
        ),
        Gaps.w16,
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.identity_restore_title,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Gaps.h4,
              Expanded(
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Text(
                      context.l10n.identity_reactivate_description(
                        widget.accountInDeletion.name,
                        DateTime.parse(widget.accountInDeletion.deletionDate!).toLocal(),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
              Gaps.h8,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: _cancelIdentityDeletionProcess,
                    child: _isLoading
                        ? SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 4),
                              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          )
                        : Text(context.l10n.identity_restore),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _cancelIdentityDeletionProcess() async {
    if (mounted) setState(() => _isLoading = true);

    await cancelIdentityDeletionProcess(context, widget.accountInDeletion);

    if (mounted) setState(() => _isLoading = false);
  }
}
