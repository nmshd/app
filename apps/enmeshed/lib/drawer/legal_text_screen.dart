import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '/core/core.dart';

class LegalTextScreen extends StatefulWidget {
  final String filePath;
  final String title;

  const LegalTextScreen({required this.filePath, required this.title, super.key});

  @override
  State<LegalTextScreen> createState() => _LegalTextScreenState();
}

class _LegalTextScreenState extends State<LegalTextScreen> {
  String? _legalText;

  @override
  void initState() {
    super.initState();

    _loadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _legalText == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              minimum: const EdgeInsets.only(bottom: 16),
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MarkdownBody(data: _legalText!, onTapLink: (_, href, __) => _onTapLink(href)),
                ),
              ),
            ),
    );
  }

  Future<void> _onTapLink(String? href) async {
    if (href == null) return;

    final uri = Uri.parse(href);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      GetIt.I.get<Logger>().e('Could not launch $uri');
      if (mounted) showErrorSnackbar(context: context, text: context.l10n.error_couldNotOpenLink);
    }
  }

  Future<void> _loadFile() async {
    final loadedData = await rootBundle.loadString(widget.filePath);

    setState(() => _legalText = loadedData);
  }
}
