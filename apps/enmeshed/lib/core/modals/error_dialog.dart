import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../utils/utils.dart';

class ErrorDialog extends StatelessWidget {
  final String? code;

  const ErrorDialog({required this.code, super.key});

  @override
  Widget build(BuildContext context) {
    if (code == 'error.relationshipTemplateProcessedModule.relationshipTemplateNotSupported') {
      return const _UnsupportedRelationshipTemplateErrorDialog();
    }

    if (code == 'error.relationshipTemplateProcessedModule.relationshipTemplateProcessingError') {
      return const _RelationshipTemplateProcessingErrorDialog();
    }

    return AlertDialog(
      title: Text(context.l10n.error),
      content: Text(context.l10n.errorDialog_description),
      actions: <Widget>[FilledButton(onPressed: context.pop, child: Text(context.l10n.close))],
    );
  }
}

class _UnsupportedRelationshipTemplateErrorDialog extends StatelessWidget {
  const _UnsupportedRelationshipTemplateErrorDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ungültiger QR-Code'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          const VectorGraphic(loader: AssetBytesLoader('assets/svg/invalid_qr_code.svg')),
          Text(
            'Der gescannte QR-Code wird von dieser App leider nicht unterstützt.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Text('Falls Ihnen ein alternativer Code zur Verfügung steht, versuchen Sie es mit diesem.'),
          const Text(
            'Stellen Sie zusätzlich sicher, dass Sie die neueste Version der App verwenden. Gehen zum App Store und aktualisieren Sie die App, falls nötig.',
          ),
        ],
      ),
      actions: <Widget>[FilledButton(onPressed: context.pop, child: Text(context.l10n.close))],
    );
  }
}

class _RelationshipTemplateProcessingErrorDialog extends StatelessWidget {
  const _RelationshipTemplateProcessingErrorDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Fehler bei der Verarbeitung des QR-Codes'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          const VectorGraphic(loader: AssetBytesLoader('assets/svg/invalid_qr_code.svg')),
          Text(
            'Der gescannte Code konnte leider nicht verarbeitet werden.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Text('Falls Ihnen ein alternativer Code zur Verfügung steht, versuchen Sie es mit diesem.'),
          const Text(
            'Stellen Sie zusätzlich sicher, dass Sie die neueste Version der App verwenden. Gehen zum App Store und aktualisieren Sie die App, falls nötig.',
          ),
        ],
      ),
      actions: <Widget>[FilledButton(onPressed: context.pop, child: Text(context.l10n.close))],
    );
  }
}
