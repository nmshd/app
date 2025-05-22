import 'package:flutter/services.dart';
import 'package:identity_recovery_kit/src/qr_error_correction_level.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'generate_qr_code.dart';

typedef QRSettings = ({QRErrorCorrectionLevel? errorCorrectionLevel, int? qrPixelSize});
typedef PdfTexts = ({
  String headerTitle,
  String keepSafeText,
  String infoText1,
  String infoText2,
  String addressLabel,
  String address,
  String passwordLabel,
  String qrDescription,
  String needHelpTitle,
  String needHelpText,
});

class PdfGenerator {
  final PdfColor headerTitleColor;
  final PdfColor backgroundColor;
  final PdfColor defaultTextColor;
  final PdfColor borderColor;
  final PdfColor labelColor;
  final PdfColor addressColor;

  final PdfTexts pdfTexts;

  final QRSettings? qrSettings;

  PdfGenerator({
    required String headerTitleHexColor,
    required String backgroundHexColor,
    required String defaultTextHexColor,
    required String borderHexColor,
    required String labelHexColor,
    required String addressHexColor,
    required this.pdfTexts,
    this.qrSettings,
  }) : headerTitleColor = PdfColor.fromHex(headerTitleHexColor),
       backgroundColor = PdfColor.fromHex(backgroundHexColor),
       defaultTextColor = PdfColor.fromHex(defaultTextHexColor),
       borderColor = PdfColor.fromHex(borderHexColor),
       labelColor = PdfColor.fromHex(labelHexColor),
       addressColor = PdfColor.fromHex(addressHexColor);

  Future<Uint8List> generate({required Uint8List logoBytes, required String spacerSvgImage, required String backupURL}) async {
    final pdf = pw.Document();

    final logoImage = pw.MemoryImage(logoBytes);

    final qrImage = await generateQrCode(backupURL, errorCorrectionLevel: qrSettings?.errorCorrectionLevel, pixelSize: qrSettings?.qrPixelSize);

    pdf.addPage(_buildPage(logoImage: logoImage, spacerSvgImage: spacerSvgImage, qrImage: pw.MemoryImage(qrImage.bytes)));

    return pdf.save();
  }

  pw.Page _buildPage({required pw.MemoryImage logoImage, required String spacerSvgImage, required pw.MemoryImage qrImage}) {
    return pw.Page(
      margin: pw.EdgeInsets.all(_getSize(150)),
      build: (context) {
        return pw.Column(
          children: [
            _buildHeader(logoImage),
            pw.SizedBox(height: _getSize(151)),
            pw.SvgImage(svg: spacerSvgImage),
            pw.Expanded(
              child: pw.Stack(
                children: [
                  pw.Container(
                    width: double.infinity,
                    decoration: pw.BoxDecoration(
                      color: backgroundColor,
                      borderRadius: pw.BorderRadius.only(bottomLeft: pw.Radius.circular(_getSize(40)), bottomRight: pw.Radius.circular(_getSize(40))),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(top: _getSize(126), bottom: _getSize(150), left: _getSize(100), right: _getSize(100)),
                    child: pw.Column(
                      children: [
                        _buildInfoText(),
                        pw.SizedBox(height: _getSize(50)),
                        _buildNumberedText(1, pdfTexts.infoText1),
                        pw.SizedBox(height: _getSize(50)),
                        _buildNumberedText(2, pdfTexts.infoText2),
                        pw.SizedBox(height: _getSize(126)),
                        _buildIdContainer(),
                        pw.SizedBox(height: _getSize(50)),
                        _buildPasswordContainer(),
                        pw.SizedBox(height: _getSize(150)),
                        _buildQrRow(qrImage),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  double _getSize(double size) => (841.89 * size) / 2970;
  double _getFontSizeTitle(double size) => size / 4.296875;
  double _getFontSize(double size) => size / 3.692308;
  double _getFontContainer(double size) => size / 3.44;

  pw.Row _buildHeader(pw.MemoryImage logoImage) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.SizedBox(
          width: _getSize(800),
          child: pw.Expanded(
            child: pw.Text(
              pdfTexts.headerTitle,
              style: pw.TextStyle(fontSize: _getFontSizeTitle(72), color: headerTitleColor),
            ),
          ),
        ),
        pw.SizedBox(width: _getSize(100)),
        pw.Align(
          alignment: pw.Alignment.topRight,
          child: pw.Image(logoImage, width: _getSize(764), height: _getSize(173)),
        ),
      ],
    );
  }

  pw.Text _buildInfoText() {
    return pw.Text(
      pdfTexts.keepSafeText,
      style: pw.TextStyle(fontSize: _getFontSize(36), color: defaultTextColor),
    );
  }

  pw.Row _buildNumberedText(int number, String infoText) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          '$number.',
          style: pw.TextStyle(fontSize: _getFontSize(84), color: defaultTextColor),
        ),
        pw.SizedBox(width: _getSize(37)),
        pw.Expanded(
          child: pw.Text(
            infoText,
            style: pw.TextStyle(fontSize: _getFontSize(36), color: defaultTextColor),
          ),
        ),
      ],
    );
  }

  pw.Container _buildIdContainer() {
    return _buildTextContainer(
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Text(
            '${pdfTexts.addressLabel}: ',
            style: pw.TextStyle(fontSize: _getFontContainer(34.375), color: labelColor),
          ),
          pw.Text(
            pdfTexts.address,
            style: pw.TextStyle(fontSize: _getFontContainer(34.375), color: addressColor),
          ),
        ],
      ),
    );
  }

  pw.Container _buildPasswordContainer() {
    return _buildTextContainer(
      child: pw.Text(
        '${pdfTexts.passwordLabel}:',
        style: pw.TextStyle(fontSize: _getFontContainer(34.375), color: labelColor),
      ),
    );
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

  pw.Row _buildQrRow(pw.MemoryImage qrImage) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.SizedBox(
          width: _getSize(485),
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: _getSize(52)),
            child: pw.Text(
              pdfTexts.qrDescription,
              style: pw.TextStyle(fontSize: _getFontSize(36), color: defaultTextColor),
            ),
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
                pdfTexts.needHelpTitle,
                style: pw.TextStyle(fontSize: _getFontSize(36), fontWeight: pw.FontWeight.bold, color: defaultTextColor),
              ),
              pw.SizedBox(height: _getSize(36)),
              pw.Text(
                pdfTexts.needHelpText,
                style: pw.TextStyle(fontSize: _getFontSize(36), color: defaultTextColor),
              ),
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
