import 'package:flutter/services.dart';
import 'package:identity_recovery_kit/src/qr_error_correction_level.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'generate_qr_code.dart';

class PdfGenerator {
  final PdfColor headerTitleColor;
  final PdfColor backgroundColor;
  final PdfColor defaultTextColor;
  final PdfColor borderColor;
  final PdfColor labelColor;
  final PdfColor addressColor;

  PdfGenerator({
    required String headerTitleHexColor,
    required String backgroundHexColor,
    required String defaultTextHexColor,
    required String borderHexColor,
    required String labelHexColor,
    required String addressHexColor,
  })  : headerTitleColor = PdfColor.fromHex(headerTitleHexColor),
        backgroundColor = PdfColor.fromHex(backgroundHexColor),
        defaultTextColor = PdfColor.fromHex(defaultTextHexColor),
        borderColor = PdfColor.fromHex(borderHexColor),
        labelColor = PdfColor.fromHex(labelHexColor),
        addressColor = PdfColor.fromHex(addressHexColor);

  Future<Uint8List> generate({
    required Uint8List logoBytes,
    required String spacerSvgImage,
    required String truncatedReference,
    required String headerTitle,
    required String keepSafeText,
    required String infoText1,
    required String infoText2,
    required String addressLabel,
    required String address,
    required String passwordLabel,
    required String qrDescription,
    required String needHelpTitle,
    required String needHelpText,
    QRErrorCorrectionLevel? errorCorrectionLevel,
    int qrPixelSize = 20,
  }) async {
    final pdf = pw.Document();

    final logoImage = pw.MemoryImage(logoBytes);

    final qrImage = await generateQrCode(truncatedReference, errorCorrectionLevel: errorCorrectionLevel, pixelSize: qrPixelSize);

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(_getSize(150)),
        build: (context) {
          return pw.Column(
            children: [
              _buildHeader(headerTitle, logoImage),
              pw.SizedBox(height: _getSize(151)),
              pw.SvgImage(svg: spacerSvgImage),
              pw.Expanded(
                child: pw.Stack(
                  children: [
                    pw.Container(
                      width: double.infinity,
                      decoration: pw.BoxDecoration(
                        color: backgroundColor,
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
                          _buildInfoText(keepSafeText),
                          pw.SizedBox(height: _getSize(50)),
                          _buildNumberedText(1, infoText1),
                          pw.SizedBox(height: _getSize(50)),
                          _buildNumberedText(2, infoText2),
                          pw.SizedBox(height: _getSize(126)),
                          _buildIdContainer(addressLabel, address),
                          pw.SizedBox(height: _getSize(50)),
                          _buildPasswordContainer(passwordLabel),
                          pw.SizedBox(height: _getSize(150)),
                          _buildQrRow(qrImage, qrDescription, needHelpTitle, needHelpText),
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

  double _getSize(double size) => (841.89 * size) / 2970;
  double _getFontSizeTitle(double size) => size / 4.296875;
  double _getFontSize(double size) => size / 3.692308;
  double _getFontContainer(double size) => size / 3.44;

  pw.Row _buildHeader(String headerTitle, pw.MemoryImage logoImage) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.SizedBox(
          width: _getSize(800),
          child: pw.Expanded(
            child: pw.Text(headerTitle, style: pw.TextStyle(fontSize: _getFontSizeTitle(72), color: headerTitleColor)),
          ),
        ),
        pw.SizedBox(width: _getSize(100)),
        pw.Align(alignment: pw.Alignment.topRight, child: pw.Image(logoImage, width: _getSize(764), height: _getSize(173))),
      ],
    );
  }

  pw.Text _buildInfoText(String keepSafeText) {
    return pw.Text(keepSafeText, style: pw.TextStyle(fontSize: _getFontSize(36), color: defaultTextColor));
  }

  pw.Row _buildNumberedText(int number, String infoText) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text('$number.', style: pw.TextStyle(fontSize: _getFontSize(84), color: defaultTextColor)),
        pw.SizedBox(width: _getSize(37)),
        pw.Expanded(child: pw.Text(infoText, style: pw.TextStyle(fontSize: _getFontSize(36), color: defaultTextColor))),
      ],
    );
  }

  pw.Container _buildIdContainer(String addressLabel, String address) {
    return _buildTextContainer(
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Text('$addressLabel: ', style: pw.TextStyle(fontSize: _getFontContainer(34.375), color: labelColor)),
          pw.Text(address, style: pw.TextStyle(fontSize: _getFontContainer(34.375), color: addressColor)),
        ],
      ),
    );
  }

  pw.Container _buildPasswordContainer(String passwordKey) {
    return _buildTextContainer(child: pw.Text('$passwordKey:', style: pw.TextStyle(fontSize: _getFontContainer(34.375), color: labelColor)));
  }

  pw.Container _buildTextContainer({required pw.Widget child}) {
    return pw.Container(
      padding: pw.EdgeInsets.all(_getSize(35)),
      width: double.infinity,
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        borderRadius: pw.BorderRadius.circular(_getSize(10)),
        border: pw.Border.all(color: borderColor, width: _getSize(2)),
      ),
      child: child,
    );
  }

  pw.Row _buildQrRow(
    pw.MemoryImage qrImage,
    String qrDescription,
    String needHelpTitle,
    String needHelpText,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.SizedBox(
          width: _getSize(485),
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: _getSize(52)),
            child: pw.Text(qrDescription, style: pw.TextStyle(fontSize: _getFontSize(36), color: defaultTextColor)),
          ),
        ),
        _buildQr(qrImage),
        pw.SizedBox(
          width: _getSize(485),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.SizedBox(height: _getSize(52)),
              pw.Text(
                needHelpTitle,
                style: pw.TextStyle(fontSize: _getFontSize(36), fontWeight: pw.FontWeight.bold, color: defaultTextColor),
              ),
              pw.SizedBox(height: _getSize(36)),
              pw.Text(needHelpText, style: pw.TextStyle(fontSize: _getFontSize(36), color: defaultTextColor)),
            ],
          ),
        ),
      ],
    );
  }

  pw.Container _buildQr(pw.MemoryImage qrImage) {
    return pw.Container(
      height: _getSize(500),
      width: _getSize(500),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        borderRadius: pw.BorderRadius.circular(_getSize(40)),
        border: pw.Border.all(color: borderColor, width: _getSize(2)),
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
}
