import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

enum ScannerMode { scan, keyboard }

class ScannerView extends StatefulWidget {
  final Function({required String content, required VoidCallback pause, required VoidCallback resume, required BuildContext context}) onDetected;

  const ScannerView({super.key, required this.onDetected});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> with SingleTickerProviderStateMixin {
  final MobileScannerController _cameraController = MobileScannerController(
    returnImage: false,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  ScannerMode scannerMode = ScannerMode.scan;

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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          scannerMode == ScannerMode.scan ? AppLocalizations.of(context)!.scanner_scanQR : AppLocalizations.of(context)!.scanner_enterManual,
        ),
      ),
      body: scannerMode == ScannerMode.scan
          ? Stack(
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
                        switch (state) {
                          case TorchState.off:
                            return const Icon(Icons.flashlight_off, color: Colors.grey);
                          case TorchState.on:
                            return const Icon(Icons.flashlight_on, color: Colors.yellow);
                        }
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
                  child: Align(child: OutlinedButton(onPressed: _toggleScannerMode, child: Text(AppLocalizations.of(context)!.scanner_enterManual))),
                ),
              ],
            )
          : UrlEntry(
              onDetected: widget.onDetected,
              toggleScannerMode: _toggleScannerMode,
            ),
    );
  }

  Future<void> onDetect(BarcodeCapture barcodeCapture) async {
    if (barcodeCapture.barcodes.isEmpty) return;
    _cameraController.stop();

    final barcode = barcodeCapture.barcodes.first;
    if (barcode.rawValue == null) {
      GetIt.I.get<Logger>().e('Failed to scan Barcode');
      return;
    }

    widget.onDetected(content: barcode.rawValue!, pause: () {}, resume: () {}, context: context);
  }

  void _toggleScannerMode() async {
    setState(() {
      scannerMode = scannerMode == ScannerMode.scan ? ScannerMode.keyboard : ScannerMode.scan;
    });

    switch (scannerMode) {
      case ScannerMode.scan:
        try {
          await _cameraController.start();
          _animationController.forward();
        } catch (e) {
          GetIt.I.get<Logger>().e(e);
        }

        break;
      case ScannerMode.keyboard:
        _animationController.stop();

        try {
          await _cameraController.stop();
        } catch (e) {
          GetIt.I.get<Logger>().e(e);
        }

        break;
    }
  }
}

class UrlEntry extends StatefulWidget {
  final Function({required String content, required VoidCallback pause, required VoidCallback resume, required BuildContext context}) onDetected;
  final VoidCallback toggleScannerMode;

  const UrlEntry({super.key, required this.onDetected, required this.toggleScannerMode});

  @override
  State<UrlEntry> createState() => _UrlEntryState();
}

class _UrlEntryState extends State<UrlEntry> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallerSide = math.min(size.height, size.width);

    return SizedBox(
      width: smallerSide,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: smallerSide / 8),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: _controller, decoration: const InputDecoration(hintText: 'nmshd://...')),
                    const SizedBox(height: 8.0),
                    OutlinedButton(
                      onPressed: () => widget.onDetected(content: _controller.text, pause: () {}, resume: () {}, context: context),
                      child: Text(AppLocalizations.of(context)!.confirm),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 10,
              left: 10,
              child: Align(child: OutlinedButton(onPressed: widget.toggleScannerMode, child: Text(AppLocalizations.of(context)!.scanner_scanQR))),
            ),
          ],
        ),
      ),
    );
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
