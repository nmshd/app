import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerEntry extends StatefulWidget {
  final Function({required String content}) onSubmit;
  final VoidCallback toggleScannerMode;

  const ScannerEntry({
    super.key,
    required this.onSubmit,
    required this.toggleScannerMode,
  });

  @override
  State<ScannerEntry> createState() => _ScannerEntryState();
}

class _ScannerEntryState extends State<ScannerEntry> with SingleTickerProviderStateMixin {
  final MobileScannerController _cameraController = MobileScannerController(
    returnImage: false,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  late final Animation<double> _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final directionUpOffset = Offset.fromDirection(3 * math.pi / 2, 100);
    const scannerWindowSize = 225.0;
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(directionUpOffset),
      width: scannerWindowSize,
      height: scannerWindowSize,
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: _cameraController,
          onDetect: onDetect,
          scanWindow: scanWindow,
          onScannerStarted: (_) => _animationController.forward(),
        ),
        CustomPaint(painter: ScannerOverlay(scanWindow, _animation.value)),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: ValueListenableBuilder(
              valueListenable: _cameraController.torchState,
              builder: (context, state, child) {
                return switch (state) {
                  TorchState.off => const Icon(Icons.flashlight_off, color: Colors.grey),
                  TorchState.on => const Icon(Icons.flashlight_on, color: Colors.yellow),
                };
              },
            ),
            iconSize: 32.0,
            onPressed: () => _cameraController.toggleTorch(),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 10,
          left: 10,
          child: Align(child: OutlinedButton(onPressed: widget.toggleScannerMode, child: Text(AppLocalizations.of(context)!.scanner_enterManual))),
        ),
      ],
    );
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

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow, this.animationValue);

  final Rect scanWindow;
  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final p1 = Offset(scanWindow.left, scanWindow.top + (scanWindow.height * animationValue));
    final p2 = Offset(scanWindow.right, scanWindow.top + (scanWindow.height * animationValue));
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
