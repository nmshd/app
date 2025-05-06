import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';

class ValidationErrorBox extends StatelessWidget {
  final RequestValidationResultDTO validationResult;

  const ValidationErrorBox({required this.validationResult, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      color: Theme.of(context).colorScheme.error,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 4,
          children: [
            Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
            Expanded(
              child: TranslatedText(
                'i18n://requestRenderer.errors.${validationResult.code!}',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onError),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
