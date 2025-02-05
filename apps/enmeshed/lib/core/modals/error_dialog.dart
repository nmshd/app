import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../utils/utils.dart';

class ErrorDialog extends StatelessWidget {
  final String? code;

  const ErrorDialog({required this.code, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.error),
      content: Text(context.l10n.errorDialog_description),
      actions: <Widget>[FilledButton(onPressed: context.pop, child: Text(context.l10n.close))],
    );
  }
}
