import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerView extends StatefulWidget {
  final Function(String) onDetected;

  const ScannerView({super.key, required this.onDetected});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> with SingleTickerProviderStateMixin {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: _cameraController.torchState,
              builder: (context, state, child) => state == TorchState.off
                  ? const Icon(Icons.flashlight_off, color: Colors.grey)
                  : const Icon(Icons.flashlight_on, color: Colors.yellow),
            ),
            iconSize: 32.0,
            onPressed: () => _cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: _cameraController.cameraFacingState,
              builder: (context, state, child) => Icon(state == CameraFacing.front ? Icons.camera_front : Icons.camera_rear),
            ),
            iconSize: 32.0,
            onPressed: () => _cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _cameraController,
            onDetect: onDetect,
            scanWindow: scanWindow,
            onScannerStarted: (_) => _animationController.forward(),
          ),
          CustomPaint(painter: ScannerOverlay(scanWindow, _animation.value)),
        ],
      ),
    );
  }

  Future<void> onDetect(BarcodeCapture barcodeCapture) async {
    if (barcodeCapture.barcodes.isEmpty) return;
    _cameraController.stop();

    final barcode = barcodeCapture.barcodes.first;
    if (barcode.rawValue == null) {
      print('Failed to scan Barcode');
      return;
    }

    final code = barcode.rawValue!;
    if (!code.startsWith('nmshd://qr#')) return;

    final truncatedReference = code.replaceAll('nmshd://qr#', '');
    widget.onDetected(truncatedReference);
    Navigator.of(context).pop();
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
