import 'dart:ui' as ui;

import 'package:pdf/widgets.dart' as pw;
import 'package:qr_flutter/qr_flutter.dart';

Future<pw.MemoryImage> generateQrCode(String data) async {
  final qrCode = QrCode.fromData(
    data: data,
    errorCorrectLevel: QrErrorCorrectLevel.L,
  );

  final qrImage = QrImage(qrCode);
  const pixelSize = 10;
  final size = qrImage.moduleCount * pixelSize;

  final pictureRecorder = ui.PictureRecorder();
  final canvas = ui.Canvas(pictureRecorder);

  final backgroundPaint = ui.Paint()..color = const ui.Color(0xFFFFFFFF);
  canvas.drawRect(ui.Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()), backgroundPaint);

  final paint = ui.Paint()..color = const ui.Color(0xFF000000); // Schwarz

  for (int x = 0; x < qrImage.moduleCount; x++) {
    for (int y = 0; y < qrImage.moduleCount; y++) {
      if (qrImage.isDark(y, x)) {
        canvas.drawRect(
          ui.Rect.fromLTWH(
            x * pixelSize.toDouble(),
            y * pixelSize.toDouble(),
            pixelSize.toDouble(),
            pixelSize.toDouble(),
          ),
          paint,
        );
      }
    }
  }

  final picture = pictureRecorder.endRecording();
  final image = await picture.toImage(size, size);

  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final qrMemoryImage = pw.MemoryImage(byteData!.buffer.asUint8List());
  return qrMemoryImage;
}
