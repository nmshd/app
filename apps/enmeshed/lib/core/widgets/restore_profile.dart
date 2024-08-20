import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../core.dart';

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
  String? _deletionDate;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _getAccountDeletionDate();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_deletionDate == null) return const Center(child: CircularProgressIndicator());

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoLoadingProfilePicture(
          radius: 20,
          accountId: widget.accountInDeletion.id,
          profileName: widget.accountInDeletion.name,
          circleAvatarColor: context.customColors.decorativeContainer!,
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
                        DateTime.parse(_deletionDate!).toLocal(),
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

  Future<void> _getAccountDeletionDate() async {
    final accountDeletionDate = await getAccountDeletionDate(widget.accountInDeletion);
    if (mounted) setState(() => _deletionDate = accountDeletionDate);
  }

  Future<void> _cancelIdentityDeletionProcess() async {
    if (mounted) setState(() => _isLoading = true);

    await cancelIdentityDeletionProcess(context, widget.accountInDeletion);

    if (mounted) setState(() => _isLoading = false);
  }
}
