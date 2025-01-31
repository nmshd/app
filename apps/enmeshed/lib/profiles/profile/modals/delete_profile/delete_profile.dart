import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'delete_profile_and_choose_next.dart';
import 'delete_profile_or_identity.dart';
import 'should_delete_identity.dart';
import 'should_delete_profile.dart';

Future<void> showDeleteProfileOrIdentityModal({
  required LocalAccountDTO localAccount,
  required BuildContext context,
}) async {
  final session = GetIt.I.get<EnmeshedRuntime>().getSession(localAccount.address!);

  final devicesResult = await session.transportServices.devices.getDevices();
  final devices = devicesResult.isSuccess ? devicesResult.value : <DeviceDTO>[];

  final onboardedDevices = devices
      .where(
        (element) => element.isOnboarded && element.isOffboarded != true && !element.isCurrentDevice,
      )
      .toList()
    ..sort((a, b) => a.name.compareTo(b.name));

  if (!context.mounted) return;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.75),
      child: _DeleteProfileOrIdentityModal(
        localAccount: localAccount,
        onboardedDevices: onboardedDevices,
        devices: devices,
        session: session,
      ),
    ),
  );
}

class _DeleteProfileOrIdentityModal extends StatefulWidget {
  final LocalAccountDTO localAccount;
  final List<DeviceDTO> onboardedDevices;
  final List<DeviceDTO> devices;
  final Session session;

  const _DeleteProfileOrIdentityModal({
    required this.localAccount,
    required this.onboardedDevices,
    required this.devices,
    required this.session,
  });

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

  final _deleteFuture = ValueNotifier<Future<Result<dynamic>>?>(null);
  final _retryFunction = ValueNotifier<Future<Result<dynamic>> Function()?>(null);

  @override
  void dispose() {
    _deleteFuture.dispose();
    _retryFunction.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          ),
        );
      },
      duration: const Duration(milliseconds: 200),
      reverseDuration: Duration.zero,
      transitionBuilder: (child, animation) => SlideTransition(
        position: animation.drive(
          Tween(
            begin: _index > _lastIndex ? const Offset(1, 0) : const Offset(-1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: child,
      ),
      child: switch (_index) {
        0 => DeleteProfileOrIdentity(
            cancel: () => context.pop,
            profileName: widget.localAccount.name,
            accountId: widget.localAccount.address!,
            onboardedDevices: widget.onboardedDevices,
            deleteProfile: () => setState(() => _currentIndex = 1),
            deleteIdentity: () => setState(() => _currentIndex = 2),
          ),
        1 => ShouldDeleteProfile(
            cancel: () => setState(() => _currentIndex = 0),
            delete: () {
              _retryFunction.value = () async {
                try {
                  await GetIt.I.get<EnmeshedRuntime>().accountServices.offboardAccount(widget.localAccount.id);
                  return Result.success(null);
                } catch (e) {
                  return Result.failure(
                    RuntimeError(
                      message: e.toString(),
                      code: 'identity.deletion.failed',
                    ),
                  );
                }
              };

              _deleteFuture.value = _retryFunction.value!();
              setState(() {
                _currentIndex = 3;
              });
            },
            profileName: widget.localAccount.name,
            onboardedDevices: widget.onboardedDevices,
          ),
        2 => ShouldDeleteIdentity(
            cancel: () => setState(() => _currentIndex = 0),
            delete: () {
              _deleteFuture.value = widget.session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess();
              _retryFunction.value = widget.session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess;
              setState(() {
                _currentIndex = 3;
              });
            },
            deleteNow: () {
              const minutesInDays = 0.25 / 1440;

              _deleteFuture.value = widget.session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess(
                lengthOfGracePeriodInDays: minutesInDays,
              );
              _retryFunction.value = () => widget.session.transportServices.identityDeletionProcesses.initiateIdentityDeletionProcess(
                    lengthOfGracePeriodInDays: minutesInDays,
                  );
              setState(() {
                _currentIndex = 3;
              });
            },
            profileName: widget.localAccount.name,
            devices: widget.devices,
          ),
        _ => GestureDetector(
            onVerticalDragStart: (_) {},
            child: DeleteProfileAndChooseNext(
              localAccount: widget.localAccount,
              deleteFuture: _deleteFuture,
              retryFunction: _retryFunction,
              inProgressText: context.l10n.profile_delete_inProgress,
              successDescription: context.l10n.profile_delete_success,
            ),
          )
      },
    );
  }
}
