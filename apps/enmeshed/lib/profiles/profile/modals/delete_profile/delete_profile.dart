import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/core/core.dart';
import 'delete_profile_and_choose_next.dart';
import 'delete_profile_or_identity.dart';
import 'deletion_type.dart';
import 'should_delete_identity.dart';
import 'should_delete_profile.dart';

Future<void> showDeleteProfileOrIdentityModal({required LocalAccountDTO localAccount, required BuildContext context}) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(localAccount.address!);

  final devicesResult = await session.transportServices.devices.getDevices();
  final devices = devicesResult.isSuccess ? devicesResult.value : <DeviceDTO>[];

  final otherActiveDevices = devices.where((element) => element.isOnboarded && element.isOffboarded != true && !element.isCurrentDevice).toList()
    ..sort((a, b) => a.name.compareTo(b.name));

  if (!context.mounted) return;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.9),
      child: _DeleteProfileOrIdentityModal(localAccount: localAccount, otherActiveDevices: otherActiveDevices, devices: devices, session: session),
    ),
  );
}

class _DeleteProfileOrIdentityModal extends StatefulWidget {
  final LocalAccountDTO localAccount;
  final List<DeviceDTO> otherActiveDevices;
  final List<DeviceDTO> devices;
  final Session session;

  const _DeleteProfileOrIdentityModal({required this.localAccount, required this.otherActiveDevices, required this.devices, required this.session});

  @override
  State<_DeleteProfileOrIdentityModal> createState() => _DeleteProfileOrIdentityModalState();
}

class _DeleteProfileOrIdentityModalState extends State<_DeleteProfileOrIdentityModal> {
  set _currentIndex(int index) {
    _lastIndex = _index;
    _index = index;
  }

  int _lastIndex = 0;
  int _index = 0;

  late final DeletionType _deletionType;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: Stack(alignment: Alignment.center, children: <Widget>[...previousChildren, if (currentChild != null) currentChild]),
        );
      },
      duration: const Duration(milliseconds: 200),
      reverseDuration: Duration.zero,
      transitionBuilder: (child, animation) => SlideTransition(
        position: animation.drive(
          Tween(begin: _index > _lastIndex ? const Offset(1, 0) : const Offset(-1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: child,
      ),
      child: switch (_index) {
        0 => DeleteProfileOrIdentity(
          profileName: widget.localAccount.name,
          accountId: widget.localAccount.address!,
          otherActiveDevices: widget.otherActiveDevices,
          deleteProfile: () => setState(() => _currentIndex = 1),
          deleteIdentity: () => setState(() => _currentIndex = 2),
        ),
        1 => ShouldDeleteProfile(
          cancel: () => setState(() => _currentIndex = 0),
          delete: () => setState(() {
            _deletionType = DeletionType.profile;
            _currentIndex = 3;
          }),
          profileName: widget.localAccount.name,
          otherActiveDevices: widget.otherActiveDevices,
        ),
        2 => ShouldDeleteIdentity(
          cancel: () => setState(() => _currentIndex = 0),
          delete: () => setState(() {
            _deletionType = DeletionType.identity;
            _currentIndex = 3;
          }),
          profileName: widget.localAccount.name,
          devices: widget.devices,
        ),
        _ => DeleteProfileAndChooseNext(
          session: widget.session,
          localAccount: widget.localAccount,
          deletionType: _deletionType,
          inProgressText: context.l10n.profile_delete_inProgress,
        ),
      },
    );
  }
}
