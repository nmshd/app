import 'package:flutter/material.dart';

import 'scanner_entry.dart';
import 'url_entry.dart';

enum ScannerMode { scan, keyboard }

class ScannerView extends StatefulWidget {
  final void Function({required String content, required VoidCallback pause, required VoidCallback resume, required BuildContext context}) onSubmit;
  final String lineUpQrCodeText;
  final String scanQrOrEnterUrlText;
  final String enterUrlText;
  final String urlTitle;
  final String urlDescription;
  final String urlLabelText;
  final String urlValidationErrorText;
  final String urlButtonText;

  const ScannerView({
    required this.onSubmit,
    required this.lineUpQrCodeText,
    required this.scanQrOrEnterUrlText,
    required this.enterUrlText,
    required this.urlTitle,
    required this.urlDescription,
    required this.urlLabelText,
    required this.urlValidationErrorText,
    required this.urlButtonText,
    super.key,
  });

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  ScannerMode scannerMode = ScannerMode.scan;

  bool _paused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scannerMode == ScannerMode.scan
          ? ScannerEntry(
              onSubmit: _onSubmit,
              toggleScannerMode: _toggleScannerMode,
              lineUpQrCodeText: widget.lineUpQrCodeText,
              scanQrOrEnterUrlText: widget.scanQrOrEnterUrlText,
              enterUrlText: widget.enterUrlText,
            )
          : UrlEntry(
              onSubmit: _onSubmit,
              toggleScannerMode: _toggleScannerMode,
              urlTitle: widget.urlTitle,
              urlDescription: widget.urlDescription,
              urlLabelText: widget.urlLabelText,
              urlValidationErrorText: widget.urlValidationErrorText,
              urlButtonText: widget.urlButtonText,
            ),
    );
  }

  void _onSubmit({required String content}) {
    if (_paused) return;

    widget.onSubmit(
      content: content,
      pause: () => _paused = true,
      resume: () => _paused = false,
      context: context,
    );
  }

  Future<void> _toggleScannerMode() async {
    setState(() => scannerMode = scannerMode == ScannerMode.scan ? ScannerMode.keyboard : ScannerMode.scan);
  }
}
