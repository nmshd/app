import 'package:flutter/material.dart';

InputDecoration inputDecoration(BuildContext context) => InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.primary),
      ),
      hintMaxLines: 150,
      errorMaxLines: 150,
      helperMaxLines: 150,
    );
