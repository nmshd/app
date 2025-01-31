import 'dart:async';
import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'modals/modals.dart';
import 'widgets/profile_widgets.dart';

class ProfilesScreen extends StatefulWidget {
  final String? selectedAccountReference;

  const ProfilesScreen({required this.selectedAccountReference, super.key});

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
        child: Scrollbar(
          thumbVisibility: true,
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
                  Gaps.h8,
                  _MoreProfiles(accounts: _accounts!),
                  if (_accountsInDeletion!.isNotEmpty) ...[
                    Gaps.h8,
                    _ProfilesInDeletion(accountsInDeletion: _accountsInDeletion!, reloadAccounts: _reloadAccounts),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _reloadAccounts() async {
    final runtime = GetIt.I.get<EnmeshedRuntime>();

    final accountsInDeletion = await runtime.accountServices.getAccountsInDeletion();
    final accounts = await runtime.accountServices.getAccountsNotInDeletion();
    accounts.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    final selectedAccount = widget.selectedAccountReference != null
        ? accounts.firstWhere((a) => a.id == widget.selectedAccountReference || a.address == widget.selectedAccountReference)
        : accounts.reduce((value, element) => (value.lastAccessedAt ?? '').compareTo(element.lastAccessedAt ?? '') == 1 ? value : element);

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
    return Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BackgroundPainter(
                  leftTriangleColor: Theme.of(context).colorScheme.surfaceContainerLow,
                  rightTriangleColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                  bottomColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
            ),
            Align(
              child: InkWell(
                borderRadius: BorderRadius.circular(45),
                onTap: editProfile,
                child: ProfilePicture(
                  radius: 60,
                  profileName: selectedAccount.name,
                  image: selectedAccountProfilePicture != null ? FileImage(selectedAccountProfilePicture!) : null,
                  decorative: true,
                ),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.secondaryContainer,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                selectedAccount.name,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              TextButton(
                style: TextButton.styleFrom(padding: const EdgeInsets.all(8), minimumSize: Size.zero),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: selectedAccount.address!));
                  showSuccessSnackbar(context: context, text: context.l10n.profiles_copiedAddressToClipboard, showCloseIcon: true);
                },
                child: Text(
                  selectedAccount.address!,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  semanticsLabel: context.l10n.profiles_copyAddressToClipboardLabel,
                ),
              ),
              Gaps.h8,
              Text(context.l10n.profiles_settings_subtitle),
              Gaps.h16,
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    tooltip: context.l10n.profiles_settings_editProfile,
                    onPressed: editProfile,
                  ),
                  IconButton(
                    icon: const Icon(Icons.devices_outlined),
                    tooltip: context.l10n.profiles_settings_connectedDevices,
                    onPressed: () => context.push('/account/${selectedAccount.id}/devices'),
                  ),
                  if (context.isFeatureEnabled('IDENTITY_RECOVERY_KITS'))
                    IconButton(
                      icon: const Icon(Icons.history_outlined),
                      tooltip: context.l10n.profiles_settings_createIdentityRecoveryKit,
                      onPressed: () => context.push('/account/${selectedAccount.id}/create-identity-recovery-kit'),
                    ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: context.l10n.profiles_settings_deleteProfile,
                    onPressed: () => showDeleteProfileOrIdentityModal(context: context, localAccount: selectedAccount),
                  ),
                ],
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
  final Color bottomColor;

  _BackgroundPainter({
    required this.leftTriangleColor,
    required this.rightTriangleColor,
    required this.bottomColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rightPaint = Paint()
      ..color = rightTriangleColor
      ..style = PaintingStyle.fill;

    final leftPaint = Paint()
      ..color = leftTriangleColor
      ..style = PaintingStyle.fill;

    final bottomPaint = Paint()
      ..color = bottomColor
      ..style = PaintingStyle.fill;

    final leftPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(0, size.height)
      ..close();

    final bottomPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..close();

    final rightPath = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..close();

    canvas
      ..drawPath(leftPath, leftPaint)
      ..drawPath(bottomPath, bottomPaint)
      ..drawPath(rightPath, rightPaint);
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
          padding: const EdgeInsets.only(left: 16, right: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.l10n.profiles_additionalProfiles, style: Theme.of(context).textTheme.titleMedium),
              IconButton(
                onPressed: () => _onCreateProfilePressed(context),
                icon: const Icon(Icons.add),
                tooltip: context.l10n.profiles_add,
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
      showSuccessSnackbar(context: context, text: context.l10n.profiles_switchedToProfile(account.name), showCloseIcon: true);
    }
  }
}

class _ProfilesInDeletion extends StatelessWidget {
  final List<LocalAccountDTO> accountsInDeletion;
  final VoidCallback reloadAccounts;

  const _ProfilesInDeletion({required this.accountsInDeletion, required this.reloadAccounts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(context.l10n.identities_in_deletion, style: Theme.of(context).textTheme.titleMedium),
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
              trailing: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => showRestoreIdentityModal(accountInDeletion: accountsInDeletion[index], context: context),
                tooltip: context.l10n.identity_restore,
              ),
            ),
          ),
        ),
        if (accountsInDeletion.any((e) => e.deletionDate != null)) ...[
          Gaps.h16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: DeleteDataNowCard(onDeleted: reloadAccounts, accountsInDeletion: accountsInDeletion.where((e) => e.deletionDate != null).toList()),
          ),
        ],
      ],
    );
  }
}
