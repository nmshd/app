import 'dart:ui' as ui;

import 'package:identity_recovery_kit/src/qr_error_correction_level.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_flutter/qr_flutter.dart';

Future<pw.MemoryImage> generateQrCode(
  String data, {
  int pixelSize = 10,
  QRErrorCorrectionLevel errorCorrectionLevel = QRErrorCorrectionLevel.L,
  ui.Color backgroundColor = const ui.Color(0xFFFFFFFF),
  ui.Color paintColor = const ui.Color(0xFF000000),
}) async {
  final qrCode = QrCode.fromData(
    data: data,
    errorCorrectLevel: switch (errorCorrectionLevel) {
      QRErrorCorrectionLevel.L => QrErrorCorrectLevel.L,
      QRErrorCorrectionLevel.M => QrErrorCorrectLevel.M,
      QRErrorCorrectionLevel.Q => QrErrorCorrectLevel.Q,
      QRErrorCorrectionLevel.H => QrErrorCorrectLevel.H
    },
  );

  final qrImage = QrImage(qrCode);
  final size = qrImage.moduleCount * pixelSize;

  final pictureRecorder = ui.PictureRecorder();
  final canvas = ui.Canvas(pictureRecorder);

  canvas.drawRect(
    ui.Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
    ui.Paint()..color = backgroundColor,
  );

  for (int x = 0; x < qrImage.moduleCount; x++) {
    for (int y = 0; y < qrImage.moduleCount; y++) {
      if (qrImage.isDark(y, x)) {
        canvas.drawRect(
          ui.Rect.fromLTWH(x * pixelSize.toDouble(), y * pixelSize.toDouble(), pixelSize.toDouble(), pixelSize.toDouble()),
          ui.Paint()..color = paintColor,
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
