import 'dart:async';
import 'dart:math';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '/core/core.dart';

class DeviceOnboarding extends StatefulWidget {
  final TokenDTO token;
  final String deviceId;
  final String accountReference;
  final VoidCallback onDeviceOnboarded;

  const DeviceOnboarding({
    required this.token,
    required this.deviceId,
    required this.accountReference,
    required this.onDeviceOnboarded,
    super.key,
  });

  @override
  State<DeviceOnboarding> createState() => _DeviceOnboardingState();
}

class _DeviceOnboardingState extends State<DeviceOnboarding> with SingleTickerProviderStateMixin {
  late final StreamSubscription<DatawalletSynchronizedEvent> _subscription;
  late final TabController _tabController;
  late TokenDTO _token;
  Timer? _expiryTimer;

  @override
  void initState() {
    super.initState();

    _token = widget.token;

    _setExpiryTimer();

    final runtime = GetIt.I.get<EnmeshedRuntime>();

    _subscription = runtime.eventBus.on<DatawalletSynchronizedEvent>().listen((event) async {
      final session = runtime.getSession(widget.accountReference);
      final deviceResult = await session.transportServices.devices.getDevice(widget.deviceId);

      if (deviceResult.value.isOnboarded) widget.onDeviceOnboarded();
    });

    _tabController = TabController(length: 2, vsync: this)..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _subscription.cancel();
    _tabController.dispose();
    _expiryTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final link = 'nmshd://tr#${_token.truncatedReference}';

    final expiryTime = DateTime.parse(_token.expiresAt).toLocal();
    final isExpired = DateTime.now().isAfter(expiryTime);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom + 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.qr_code),
                      Gaps.w8,
                      Flexible(
                        child: Text(
                          context.l10n.devices_code_useQrCode,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.code),
                      Gaps.w8,
                      Flexible(
                        child: Text(
                          context.l10n.devices_code_useUrl,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 270,
            child: TabBarView(
              controller: _tabController,
              children: [
                _DeviceOnboardingQRCode(link: link, expiryTime: expiryTime, getDeviceToken: _reloadDeviceToken),
                _DeviceOnboardingUrl(link: link, expiryTime: expiryTime, getDeviceToken: _reloadDeviceToken),
              ],
            ),
          ),
          Gaps.h16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: isExpired
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          _tabController.index == 0 ? context.l10n.devices_code_qrExpired : context.l10n.devices_code_urlExpired,
                          maxLines: 3,
                          style: TextStyle(color: Theme.of(context).colorScheme.error),
                        ),
                      ),
                      Icon(Icons.error, size: 32, color: Theme.of(context).colorScheme.error),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(context.l10n.devices_code_expiry, maxLines: 3)),
                      Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
                        child: _CircleTimer(expiryTime: expiryTime),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  void _setExpiryTimer() {
    final now = DateTime.now();
    final expiry = DateTime.parse(_token.expiresAt);

    if (now.isBefore(expiry)) {
      final durationUntilExpiry = expiry.difference(now);
      _expiryTimer = Timer(durationUntilExpiry, () => setState(() {}));
    }
  }

  Future<void> _reloadDeviceToken() async {
    final runtime = GetIt.I.get<EnmeshedRuntime>();
    final session = runtime.getSession(widget.accountReference);

    final account = await runtime.accountServices.getAccount(widget.accountReference);

    final token = await session.transportServices.devices.getDeviceOnboardingToken(widget.deviceId, profileName: account.name);

    setState(() => _token = token.value);

    _setExpiryTimer();
  }
}

class _DeviceOnboardingQRCode extends StatelessWidget {
  final String link;
  final DateTime expiryTime;
  final VoidCallback getDeviceToken;

  const _DeviceOnboardingQRCode({required this.link, required this.expiryTime, required this.getDeviceToken});

  @override
  Widget build(BuildContext context) {
    final isExpired = DateTime.now().isAfter(expiryTime);

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Text(context.l10n.devices_code_qrDescription)),
          Gaps.h16,
          Stack(
            children: [
              Center(
                child: QrImageView(
                  data: link,
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: isExpired ? Theme.of(context).colorScheme.outline : Theme.of(context).colorScheme.scrim,
                  ),
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: isExpired ? Theme.of(context).colorScheme.outline : Theme.of(context).colorScheme.scrim,
                  ),
                  size: 185,
                ),
              ),
              if (isExpired)
                SizedBox(
                  height: 185,
                  child: Center(
                    child: FilledButton.icon(
                      onPressed: getDeviceToken,
                      icon: const Icon(Icons.refresh),
                      label: Text(context.l10n.devices_code_generateQr),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeviceOnboardingUrl extends StatelessWidget {
  final String link;
  final DateTime expiryTime;
  final VoidCallback getDeviceToken;

  const _DeviceOnboardingUrl({required this.link, required this.expiryTime, required this.getDeviceToken});

  @override
  Widget build(BuildContext context) {
    final isExpired = DateTime.now().isAfter(expiryTime);

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Text(context.l10n.devices_code_urlDescription)),
          Gaps.h16,
          Container(
            height: isExpired ? 185 : null,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: isExpired
                  ? Center(
                      child: FilledButton.icon(
                        onPressed: getDeviceToken,
                        icon: const Icon(Icons.refresh),
                        label: Text(context.l10n.devices_code_generateUrl),
                      ),
                    )
                  : Column(
                      children: [
                        Text(link),
                        Gaps.h16,
                        FilledButton.icon(
                          onPressed: () => Clipboard.setData(ClipboardData(text: link)),
                          icon: const Icon(Icons.file_copy),
                          label: Text(context.l10n.devices_code_copy),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleTimer extends StatefulWidget {
  final DateTime expiryTime;

  const _CircleTimer({required this.expiryTime});

  @override
  State<_CircleTimer> createState() => _CircleTimerState();
}

class _CircleTimerState extends State<_CircleTimer> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  static const _maxDuration = Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    final duration = widget.expiryTime.difference(DateTime.now());
    final initialProgress = (_maxDuration.inSeconds - duration.inSeconds) / _maxDuration.inSeconds;
    controller = AnimationController(
      vsync: this,
      duration: _maxDuration,
    )..addListener(() => setState(() {}));

    controller
      ..value = 1 - initialProgress
      ..reverse(from: 1.0 - initialProgress);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.onInverseSurface;
    final color = Theme.of(context).colorScheme.primary;

    return CustomPaint(
      size: const Size(32, 32),
      painter: _TimedCirclePainter(controller.value, color: color, backgroundColor: backgroundColor),
    );
  }
}

class _TimedCirclePainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  _TimedCirclePainter(
    this.progress, {
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas
      ..drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, circlePaint)
      ..drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
        -pi / 2,
        -2 * pi * progress,
        true,
        arcPaint,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
