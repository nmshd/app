import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_flutter/qr_flutter.dart';

class PdfGenerator {
  static Future<Uint8List> generate({
    required Uint8List logoBytes,
    required String spacerSvgImage,
    required String truncatedReference,
    required String headerTitle,
    required String keepSafeText,
    required String infoText1,
    required String infoText2,
    required String idLabel,
    required String id,
    required String passwordLabel,
    required String qrDescription,
    required String needHelpTitle,
    required String needHelpText,
    required String headerTitleHexColor,
    required String backgroundHexColor,
    required String defaultTextHexColor,
    required String borderHexColor,
    required String labelHexColor,
    required String idHexColor,
  }) async {
    final pdf = pw.Document();

    final logoImage = pw.MemoryImage(logoBytes);

    final qrCodeBytes = await _generateQrCode(truncatedReference);
    final qrImage = pw.MemoryImage(qrCodeBytes);

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(_getSize(150)),
        build: (context) {
          return pw.Column(
            children: [
              _buildHeader(headerTitle, headerTitleHexColor, logoImage),
              pw.SizedBox(height: _getSize(151)),
              pw.SvgImage(svg: spacerSvgImage),
              pw.Expanded(
                child: pw.Stack(
                  children: [
                    pw.Container(
                      width: double.infinity,
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromHex(backgroundHexColor),
                        borderRadius: pw.BorderRadius.only(
                          bottomLeft: pw.Radius.circular(_getSize(40)),
                          bottomRight: pw.Radius.circular(_getSize(40)),
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.only(top: _getSize(126), bottom: _getSize(150), left: _getSize(100), right: _getSize(100)),
                      child: pw.Column(
                        children: [
                          _buildInfoText(keepSafeText, defaultTextHexColor),
                          pw.SizedBox(height: _getSize(50)),
                          _buildNumberText1(infoText1, defaultTextHexColor),
                          pw.SizedBox(height: _getSize(50)),
                          _buildNumberText2(infoText2, defaultTextHexColor),
                          pw.SizedBox(height: _getSize(126)),
                          _buildIdContainer(idLabel, id, borderHexColor, labelHexColor, idHexColor),
                          pw.SizedBox(height: _getSize(50)),
                          _buildPasswordContainer(passwordLabel, borderHexColor, labelHexColor),
                          pw.SizedBox(height: _getSize(150)),
                          _buildQrRow(qrImage, qrDescription, needHelpTitle, needHelpText, defaultTextHexColor, borderHexColor),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static double _getSize(double size) => (841.89 * size) / 2970;
  static double _getFontSizeTitle(double size) => size / 4.296875;
  static double _getFontSize(double size) => size / 3.692308;
  static double _getFontContainer(double size) => size / 3.44;

  static pw.Row _buildHeader(String headerTitle, String headerTitleColor, pw.MemoryImage logoImage) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(headerTitle, style: pw.TextStyle(fontSize: _getFontSizeTitle(72), color: PdfColor.fromHex(headerTitleColor))),
        pw.Align(alignment: pw.Alignment.topRight, child: pw.Image(logoImage, width: _getSize(764), height: _getSize(173))),
      ],
    );
  }

  static pw.Text _buildInfoText(String keepSafeText, String defaultTextColor) {
    return pw.Text(keepSafeText, style: pw.TextStyle(fontSize: _getFontSize(36), color: PdfColor.fromHex(defaultTextColor)));
  }

  static pw.Row _buildNumberText1(String infoText1, String defaultTextColor) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('1.', style: pw.TextStyle(fontSize: _getFontSize(84), color: PdfColor.fromHex(defaultTextColor))),
        pw.SizedBox(width: _getSize(37)),
        pw.Expanded(child: pw.Text(infoText1, style: pw.TextStyle(fontSize: _getFontSize(36), color: PdfColor.fromHex(defaultTextColor)))),
      ],
    );
  }

  static pw.Row _buildNumberText2(String infoText2, String defaultTextColor) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('2.', style: pw.TextStyle(fontSize: _getFontSize(84), color: PdfColor.fromHex(defaultTextColor))),
        pw.SizedBox(width: _getSize(37)),
        pw.Expanded(child: pw.Text(infoText2, style: pw.TextStyle(fontSize: _getFontSize(36), color: PdfColor.fromHex(defaultTextColor)))),
      ],
    );
  }

  static pw.Container _buildIdContainer(String idKey, String id, String borderColor, String labelColor, String idColor) {
    return pw.Container(
      padding: pw.EdgeInsets.all(_getSize(35)),
      width: double.infinity,
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        borderRadius: pw.BorderRadius.circular(_getSize(10)),
        border: pw.Border.all(color: PdfColor.fromHex(borderColor), width: _getSize(2)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Text('$idKey: ', style: pw.TextStyle(fontSize: _getFontContainer(34.375), color: PdfColor.fromHex(labelColor))),
          pw.Text(id, style: pw.TextStyle(fontSize: _getFontContainer(34.375), color: PdfColor.fromHex(idColor))),
        ],
      ),
    );
  }

  static pw.Container _buildPasswordContainer(String passwordKey, String borderColor, String labelColor) {
    return pw.Container(
      padding: pw.EdgeInsets.all(_getSize(35)),
      width: double.infinity,
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        borderRadius: pw.BorderRadius.circular(_getSize(10)),
        border: pw.Border.all(color: PdfColor.fromHex(borderColor), width: _getSize(2)),
      ),
      child: pw.Text('$passwordKey:', style: pw.TextStyle(fontSize: _getFontContainer(34.375), color: PdfColor.fromHex(labelColor))),
    );
  }

  static pw.Row _buildQrRow(
    pw.MemoryImage qrImage,
    String qrDescription,
    String needHelpTitle,
    String needHelpText,
    String defaultTextColor,
    String borderColor,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.SizedBox(
          width: _getSize(485),
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: _getSize(52)),
            child: pw.Text(qrDescription, style: pw.TextStyle(fontSize: _getFontSize(36), color: PdfColor.fromHex(defaultTextColor))),
          ),
        ),
        _buildQr(qrImage, borderColor),
        pw.SizedBox(
          width: _getSize(485),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.SizedBox(height: _getSize(52)),
              pw.Text(
                needHelpTitle,
                style: pw.TextStyle(fontSize: _getFontSize(36), fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex(defaultTextColor)),
              ),
              pw.SizedBox(height: _getSize(36)),
              pw.Text(needHelpText, style: pw.TextStyle(fontSize: _getFontSize(36), color: PdfColor.fromHex(defaultTextColor))),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Container _buildQr(pw.MemoryImage qrImage, String borderColor) {
    return pw.Container(
      height: _getSize(500),
      width: _getSize(500),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        borderRadius: pw.BorderRadius.circular(_getSize(40)),
        border: pw.Border.all(color: PdfColor.fromHex(borderColor), width: _getSize(2)),
      ),
      child: pw.Center(
        child: pw.SizedBox(
          height: _getSize(440),
          width: _getSize(440),
          child: pw.Center(child: pw.Image(qrImage)),
        ),
      ),
    );
  }

  static Future<Uint8List> _generateQrCode(String data) async {
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
    return byteData!.buffer.asUint8List();
  }
}
