import 'dart:math' as math;

import 'package:flutter/material.dart';

class UrlEntryView extends StatefulWidget {
  final Function({required String content, required VoidCallback pause, required VoidCallback resume, required BuildContext context}) onSubmit;

  const UrlEntryView({super.key, required this.onSubmit});

  @override
  State<UrlEntryView> createState() => _UrlEntryViewState();
}

class _UrlEntryViewState extends State<UrlEntryView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  bool _paused = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final smallerSide = math.min(size.height, size.width);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('scanner_enterManual'),
      ),
      body: SizedBox(
        width: smallerSide,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: smallerSide / 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onSubmitted: (value) => _onSubmit(content: value),
                controller: _controller,
                decoration: const InputDecoration(hintText: 'nmshd://...'),
              ),
              const SizedBox(height: 8.0),
              OutlinedButton(
                onPressed: () => _onSubmit(content: _controller.text),
                child: const Text('confirm'),
              ),
            ],
          ),
        ),
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
}
