import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UrlEntry extends StatefulWidget {
  final Function({required String content}) onSubmit;
  final VoidCallback toggleScannerMode;

  const UrlEntry({super.key, required this.onSubmit, required this.toggleScannerMode});

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
                    TextField(
                      onSubmitted: (value) => widget.onSubmit(content: value),
                      controller: _controller,
                      decoration: const InputDecoration(hintText: 'nmshd://...'),
                    ),
                    const SizedBox(height: 8.0),
                    OutlinedButton(
                      onPressed: () => widget.onSubmit(content: _controller.text),
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
