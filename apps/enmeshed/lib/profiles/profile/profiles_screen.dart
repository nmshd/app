import 'dart:async';
import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:feature_flags/feature_flags.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'modals/delete_profile/delete_profile_or_identity_modal.dart';
import 'modals/modals.dart';
import 'widgets/deletion_profile_card.dart';
import 'widgets/profile_widgets.dart';

class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({super.key});

  @override
  State<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  final List<StreamSubscription<void>> _subscriptions = [];
  late LocalAccountDTO _selectedAccount;
  File? _selectedAccountProfilePicture;
  List<LocalAccountDTO>? _accounts;
  List<LocalAccountDTO>? _accountsInDeletion;

  @override
  void initState() {
    super.initState();

    final runtime = GetIt.I.get<EnmeshedRuntime>();
    _subscriptions.add(runtime.eventBus.on<DatawalletSynchronizedEvent>().listen((_) => _reloadAccounts().catchError((_) {})));

    _reloadAccounts();
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: Text(context.l10n.drawer_manageProfiles, style: Theme.of(context).textTheme.titleMedium));

    if (_accounts == null || _accountsInDeletion == null) {
      return Scaffold(
        appBar: appBar,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CurrentProfileHeader(
                  selectedAccount: _selectedAccount,
                  selectedAccountProfilePicture: _selectedAccountProfilePicture,
                  editProfile: _editProfile,
                ),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.53),
                    collapsedBackgroundColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.53),
                    title: Text(context.l10n.profiles_settings_title),
                    subtitle: Text(context.l10n.profiles_settings_subtitle),
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit_outlined),
                        title: Text(context.l10n.profiles_settings_editProfile),
                        onTap: _editProfile,
                      ),
                      ListTile(
                        leading: const Icon(Icons.devices_outlined),
                        title: Text(context.l10n.profiles_settings_connectedDevices),
                        onTap: () => context.push('/account/${_selectedAccount.id}/devices'),
                      ),
                      if (kDebugMode && Features.isFeatureEnabled(context, 'BACKUP_DATA'))
                        ListTile(
                          onTap: () => showNotImplementedDialog(context),
                          leading: const Icon(Icons.save),
                          title: Text(context.l10n.drawer_backupData),
                        ),
                      ListTile(
                        leading: const Icon(Icons.delete_forever_outlined),
                        title: Text(context.l10n.profiles_settings_deleteProfile),
                        onTap: () => showDeleteProfileOrIdentityModal(context: context, localAccount: _selectedAccount),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 2),
                Gaps.h8,
                _MoreProfiles(accounts: _accounts!),
                if (_accountsInDeletion!.isNotEmpty) ...[
                  Gaps.h8,
                  _ProfilesInDeletion(accountsInDeletion: _accountsInDeletion!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _reloadAccounts() async {
    final accountsInDeletion = await getAccountsInDeletion();
    final accounts = await getAccountsNotInDeletion();
    accounts.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    final selectedAccount = accounts.reduce(
      (value, element) => (value.lastAccessedAt ?? '').compareTo(element.lastAccessedAt ?? '') == 1 ? value : element,
    );

    final profilePicture = await loadProfilePicture(accountReference: selectedAccount.id);

    setState(() {
      _selectedAccount = selectedAccount;
      _selectedAccountProfilePicture = profilePicture;
      _accounts = accounts.where((account) => account.id != selectedAccount.id).toList();
      _accountsInDeletion = accountsInDeletion;
    });
  }

  Future<void> _editProfile() async {
    await showEditProfileModal(
      context: context,
      localAccount: _selectedAccount,
      onEditAccount: () {
        _reloadAccounts();
        GetIt.I.get<EnmeshedRuntime>().eventBus.publish(ProfileEditedEvent(eventTargetAddress: _selectedAccount.address!));
      },
      initialProfilePicture: _selectedAccountProfilePicture,
    );
  }
}

class _CurrentProfileHeader extends StatelessWidget {
  final LocalAccountDTO selectedAccount;
  final File? selectedAccountProfilePicture;
  final VoidCallback editProfile;

  const _CurrentProfileHeader({required this.selectedAccount, required this.selectedAccountProfilePicture, required this.editProfile});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _BackgroundPainter(
              leftTriangleColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.36),
              rightTriangleColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.25),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                child: InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: editProfile,
                  child: ProfilePicture(
                    radius: 40,
                    profileName: selectedAccount.name,
                    image: selectedAccountProfilePicture != null ? FileImage(selectedAccountProfilePicture!) : null,
                    circleAvatarColor: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ),
              Gaps.h16,
              Text(
                selectedAccount.name,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Gaps.h16,
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: selectedAccount.address!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      showCloseIcon: true,
                      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                      content: Row(
                        children: [
                          Icon(Icons.check_circle_rounded, color: context.customColors.successIcon),
                          Gaps.w8,
                          Expanded(child: Text(context.l10n.profiles_copiedAddressToClipboard)),
                        ],
                      ),
                    ),
                  );
                },
                child: Text(
                  selectedAccount.address!,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  semanticsLabel: context.l10n.profiles_copyAddressToClipboardLabel,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final Color leftTriangleColor;
  final Color rightTriangleColor;

  _BackgroundPainter({
    required this.leftTriangleColor,
    required this.rightTriangleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = leftTriangleColor
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = rightTriangleColor
      ..style = PaintingStyle.fill;

    final path1 = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height * 0.9)
      ..lineTo(0, size.height * 0.5)
      ..close();

    final path2 = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height * 0.9)
      ..lineTo(size.width, size.height * 0.5)
      ..close();

    canvas
      ..drawPath(path1, paint1)
      ..drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _MoreProfiles extends StatelessWidget {
  final List<LocalAccountDTO> accounts;

  const _MoreProfiles({required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.l10n.profiles_additionalProfiles, style: const TextStyle(fontWeight: FontWeight.bold)),
              TextButton.icon(
                onPressed: () => _onCreateProfilePressed(context),
                icon: const Icon(Icons.add),
                label: Text(context.l10n.profiles_add),
              ),
            ],
          ),
        ),
        if (accounts.isEmpty)
          EmptyListIndicator(icon: Icons.group_outlined, text: context.l10n.profiles_noAdditionalProfiles)
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Gaps.h16,
            itemCount: accounts.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ProfileCard(
                account: accounts[index],
                onAccountSelected: (account) => _onAccountSelected(account, context),
              ),
            ),
          ),
      ],
    );
  }

  void _onCreateProfilePressed(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => CreateProfile(onProfileCreated: (account) => _onAccountSelected(account, context)),
    );
  }

  Future<void> _onAccountSelected(LocalAccountDTO account, BuildContext context) async {
    await GetIt.I.get<EnmeshedRuntime>().selectAccount(account.id);

    if (context.mounted) {
      context.go('/account/${account.id}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
          content: Row(
            children: [
              Icon(Icons.check_circle_rounded, color: context.customColors.successIcon),
              Gaps.w8,
              Expanded(child: Text(context.l10n.profiles_switchedToProfile(account.name))),
            ],
          ),
        ),
      );
    }
  }
}

class _ProfilesInDeletion extends StatelessWidget {
  final List<LocalAccountDTO> accountsInDeletion;

  const _ProfilesInDeletion({required this.accountsInDeletion});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.l10n.identities_in_deletion, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Gaps.h16,
          itemCount: accountsInDeletion.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DeletionProfileCard(
              accountInDeletion: accountsInDeletion[index],
            ),
          ),
        ),
      ],
    );
  }
}
