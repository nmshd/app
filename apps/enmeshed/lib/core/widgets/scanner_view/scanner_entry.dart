import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core.dart';

enum ScannerAnimationDirection { forward, reverse }

class ScannerEntry extends StatefulWidget {
  final void Function({required String content}) onSubmit;
  final VoidCallback toggleScannerMode;
  final String lineUpQrCodeText;
  final String scanQrOrEnterUrlText;
  final String enterUrlText;

  const ScannerEntry({
    required this.onSubmit,
    required this.toggleScannerMode,
    required this.lineUpQrCodeText,
    required this.scanQrOrEnterUrlText,
    required this.enterUrlText,
    super.key,
  });

  @override
  State<ScannerEntry> createState() => _ScannerEntryState();
}

class _ScannerEntryState extends State<ScannerEntry> with SingleTickerProviderStateMixin {
  final MobileScannerController _cameraController = MobileScannerController(
    autoStart: false,
  );

  late final Animation<double> _animation;
  late final AnimationController _animationController;

  ScannerAnimationDirection animationDirection = ScannerAnimationDirection.forward;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
          animationDirection = ScannerAnimationDirection.reverse;
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
          animationDirection = ScannerAnimationDirection.forward;
        }
      });

    _cameraController.addListener(() => setState(() {}));

    _startScanning();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const scannerWindowSize = 240.0;
    final scanWindowColor = context.customColors.sourceError!;
    final screenSize = MediaQuery.sizeOf(context);
    final scanWindowX = (screenSize.width - scannerWindowSize) / 2;
    final scanWindowY = (screenSize.height - scannerWindowSize) / 2;
    final scanWindow = Rect.fromLTWH(scanWindowX, scanWindowY, scannerWindowSize, scannerWindowSize);

    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: _cameraController,
          onDetect: onDetect,
          scanWindow: scanWindow,
        ),
        CustomPaint(
          painter: StaticScannerOverlay(
            scanWindow: scanWindow,
            scanWindowColor: scanWindowColor,
          ),
        ),
        CustomPaint(
          painter: AnimatedScannerOverlay(
            scanWindow: scanWindow,
            animationValue: _animation.value,
            animateDirection: animationDirection,
            scanWindowColor: scanWindowColor,
          ),
        ),
        Positioned.fill(
          top: -355,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.qr_code_scanner, size: 45, color: Theme.of(context).colorScheme.onPrimary),
              Gaps.w16,
              SizedBox(
                width: 200,
                child: Text(
                  widget.lineUpQrCodeText,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 56,
          left: 8,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Icon(context.adaptiveBackIcon, color: Theme.of(context).colorScheme.onPrimary, size: 18),
            onPressed: () => context.pop(),
          ),
        ),
        Positioned(
          top: 56,
          right: 8,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: _cameraController.toggleTorch,
            child: ValueListenableBuilder(
              valueListenable: _cameraController,
              builder: (context, state, child) {
                return switch (state.torchState) {
                  TorchState.off => Icon(Icons.flashlight_off, color: Theme.of(context).colorScheme.onPrimary, size: 18),
                  TorchState.on => Icon(Icons.flashlight_on, color: context.customColors.decorativeContainer, size: 18),
                  _ => const SizedBox.shrink(),
                };
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Column(
              children: [
                Gaps.h24,
                SizedBox(
                  width: 203,
                  child: Text(
                    widget.scanQrOrEnterUrlText,
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                    textAlign: TextAlign.center,
                  ),
                ),
                Gaps.h16,
                OutlinedButton(
                  onPressed: widget.toggleScannerMode,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text(widget.enterUrlText),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _startScanning() async {
    try {
      await _cameraController.start();
      await _animationController.forward();
    } catch (e) {
      GetIt.I.get<Logger>().e('Failed to start camera: $e');

      if (mounted) {
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(context.l10n.scanner_failedStartingScanner_title),
            content: Text(context.l10n.scanner_failedStartingScanner_description),
            actions: [
              TextButton(
                onPressed: () => context
                  ..pop()
                  ..pop(),
                child: Text(context.l10n.cancel),
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                  widget.toggleScannerMode();
                },
                child: Text(context.l10n.scanner_enterUrl),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> onDetect(BarcodeCapture barcodeCapture) async {
    if (barcodeCapture.barcodes.isEmpty) return;

    final barcode = barcodeCapture.barcodes.first;
    if (barcode.rawValue == null) {
      GetIt.I.get<Logger>().e('Failed to scan Barcode');
      return;
    }

    widget.onSubmit(content: barcode.rawValue!);
  }
}

class StaticScannerOverlay extends CustomPainter {
  final Rect scanWindow;
  final Color scanWindowColor;

  const StaticScannerOverlay({
    required this.scanWindow,
    required this.scanWindowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRRect(RRect.fromRectAndRadius(scanWindow, const Radius.circular(12)));

    final backgroundPaint = Paint()
      ..color = const Color(0xFF33333D).withOpacity(0.65)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(PathOperation.difference, backgroundPath, cutoutPath);
    canvas.drawPath(backgroundWithCutout, backgroundPaint);

    final cornerPaint = Paint()
      ..color = scanWindowColor
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    canvas
      ..save()
      ..translate(scanWindow.left, scanWindow.top);

    for (final _ in List.generate(4, (_) => null)) {
      _drawArc(canvas, cornerPaint);
      canvas
        ..translate(scanWindow.width, 0)
        ..rotate(math.pi / 2);
    }

    canvas.restore();
  }

  void _drawArc(Canvas canvas, Paint cornerPaint) {
    final topLeftArcPath = Path()
      ..moveTo(12, 0)
      ..lineTo(26, 0)
      ..moveTo(0, 12)
      ..lineTo(0, 26)
      ..addArc(
        Rect.fromCircle(center: const Offset(12, 12), radius: 12),
        -math.pi,
        math.pi / 2,
      );

    canvas.drawPath(topLeftArcPath, cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class AnimatedScannerOverlay extends CustomPainter {
  final Rect scanWindow;
  final double animationValue;
  final ScannerAnimationDirection animateDirection;
  final Color scanWindowColor;

  final double shadowOffset;
  final double maxOffsetUp;
  final double maxOffsetDown;

  AnimatedScannerOverlay({
    required this.scanWindow,
    required this.animationValue,
    required this.animateDirection,
    required this.scanWindowColor,
    this.shadowOffset = 6.0,
  })  : maxOffsetUp = scanWindow.top + shadowOffset,
        maxOffsetDown = scanWindow.bottom - shadowOffset;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = scanWindowColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    final lineY = scanWindow.top + (scanWindow.height * animationValue);
    final lineP1 = Offset(scanWindow.left - 7, lineY);
    final lineP2 = Offset(scanWindow.right + 7, lineY);

    canvas.drawLine(lineP1, lineP2, paint);

    final shadowPaint = Paint()
      ..color = scanWindowColor
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final shadowOffset = switch (animateDirection) {
      ScannerAnimationDirection.forward => -this.shadowOffset,
      ScannerAnimationDirection.reverse => this.shadowOffset,
    };

    final shadowY = math.min(math.max(lineP1.dy + shadowOffset, maxOffsetUp), maxOffsetDown);
    canvas.drawLine(Offset(lineP1.dx, shadowY), Offset(lineP2.dx, shadowY), shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
