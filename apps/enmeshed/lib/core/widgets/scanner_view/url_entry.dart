import 'dart:math' as math;

import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class UrlEntry extends StatefulWidget {
  final void Function({required String content}) onSubmit;
  final VoidCallback toggleScannerMode;
  final String urlTitle;
  final String urlDescription;
  final String urlLabelText;
  final String urlValidationErrorText;
  final String urlButtonText;

  const UrlEntry({
    required this.onSubmit,
    required this.toggleScannerMode,
    required this.urlTitle,
    required this.urlDescription,
    required this.urlLabelText,
    required this.urlValidationErrorText,
    required this.urlButtonText,
    super.key,
  });

  @override
  State<UrlEntry> createState() => _UrlEntryState();
}

class _UrlEntryState extends State<UrlEntry> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final smallerSide = math.min(size.height, size.width);

    return Scaffold(
      appBar: AppBar(title: Text(widget.urlTitle), leading: BackButton(onPressed: widget.toggleScannerMode)),
      body: SizedBox(
        width: smallerSide,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: size.height * 0.05625),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.urlDescription),
              SizedBox(height: size.height * 0.05625),
              Form(
                key: _formKey,
                child: TextFormField(
                  onChanged: (value) => setState(() {}),
                  onFieldSubmitted: isUrlValid ? (value) => widget.onSubmit(content: value) : null,
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline)),
                    labelText: widget.urlLabelText,
                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                    errorMaxLines: 3,
                    suffixIcon:
                        _controller.text.isNotEmpty
                            ? _formKey.currentState!.validate()
                                ? IconButton(onPressed: _controller.clear, icon: const Icon(Icons.cancel_outlined))
                                : Icon(Icons.error, color: Theme.of(context).colorScheme.error)
                            : null,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validateUrl,
                ),
              ),
              Gaps.h8,
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: isUrlValid ? () => widget.onSubmit(content: _controller.text) : null,
                  child: Text(widget.urlButtonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get isUrlValid => validateUrl(_controller.text) == null;

  String? validateUrl(String? value) {
    // https://regex101.com/r/ZheaCQ/1
    final urlRegExp = RegExp(r'^https?:\/\/.*\/r\/[a-zA-Z0-9]+#[a-zA-Z0-9-_]+$');

    if (value != null && (!urlRegExp.hasMatch(value) || value.length < 15)) {
      return widget.urlValidationErrorText;
    } else {
      return null;
    }
  }
}
