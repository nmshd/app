import 'package:flutter/material.dart';

import 'scanner_entry.dart';
import 'url_entry.dart';

enum ScannerMode { scan, keyboard }

class ScannerView extends StatefulWidget {
  final Function({required String content, required VoidCallback pause, required VoidCallback resume, required BuildContext context}) onSubmit;

  const ScannerView({super.key, required this.onSubmit});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  ScannerMode scannerMode = ScannerMode.scan;

  bool _paused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          scannerMode == ScannerMode.scan ? 'scanner_scanQR' : 'scanner_enterManual',
        ),
      ),
      body: scannerMode == ScannerMode.scan
          ? ScannerEntry(onSubmit: _onSubmit, toggleScannerMode: _toggleScannerMode)
          : UrlEntry(onSubmit: _onSubmit, toggleScannerMode: _toggleScannerMode),
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

  void _toggleScannerMode() async {
    setState(() => scannerMode = scannerMode == ScannerMode.scan ? ScannerMode.keyboard : ScannerMode.scan);
  }
}
