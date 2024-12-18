import 'dart:io';
import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../constants.dart';
import '../../utils/utils.dart';

class SaveOrPrintRecoveryKit extends StatefulWidget {
  final Uint8List recoveryKit;
  final VoidCallback onBackPressed;

  const SaveOrPrintRecoveryKit({required this.recoveryKit, required this.onBackPressed, super.key});

  @override
  State<SaveOrPrintRecoveryKit> createState() => _SaveOrPrintRecoveryKitState();
}

class _SaveOrPrintRecoveryKitState extends State<SaveOrPrintRecoveryKit> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(onPressed: widget.onBackPressed),
              Text(context.l10n.identityRecovery_saveKit, style: Theme.of(context).textTheme.titleMedium),
              IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: math.max(MediaQuery.paddingOf(context).bottom, 16) + 16),
          child: Column(
            children: [
              Text(context.l10n.identityRecovery_saveKitDescription),
              Gaps.h32,
              _RecoveryCard(
                title: context.l10n.identityRecovery_download,
                description: context.l10n.identityRecovery_downloadDescription,
                icon: Icons.file_download_outlined,
                onTap: _downloadFile,
              ),
              Gaps.h24,
              _RecoveryCard(
                title: context.l10n.identityRecovery_print,
                description: context.l10n.identityRecovery_printDescription,
                icon: Icons.print_outlined,
                onTap: _printFile,
              ),
              Gaps.h32,
              Text(context.l10n.identityRecovery_information),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _downloadFile() async {
    final selectedFile = await FilePicker.platform.saveFile(
      fileName: 'identity_recovery_kit.pdf',
      allowedExtensions: ['pdf'],
      bytes: widget.recoveryKit,
    );

    if (selectedFile == null) return;

    if (!Platform.isIOS || !Platform.isAndroid) {
      await File(selectedFile).writeAsBytes(widget.recoveryKit);
    }

    if (!mounted) return;

    context
      ..pop()
      ..pop();

    showSuccessSnackbar(context: context, text: context.l10n.identityRecovery_saveKitSuccess);
  }

  Future<void> _printFile() async {
    final success = await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => widget.recoveryKit.buffer.asUint8List(),
    );

    if (!success) return;

    if (mounted) {
      context
        ..pop()
        ..pop();

      showSuccessSnackbar(context: context, text: context.l10n.identityRecovery_printKitSuccess);
    }
  }
}

class _RecoveryCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _RecoveryCard({required this.title, required this.description, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Theme.of(context).colorScheme.primaryContainer,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Center(child: Icon(icon, color: Theme.of(context).colorScheme.primary)),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(description, style: Theme.of(context).textTheme.bodySmall),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
    );
  }
}