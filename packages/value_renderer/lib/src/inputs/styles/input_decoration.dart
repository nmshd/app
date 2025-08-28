import 'package:flutter/material.dart';

InputDecoration inputDecoration(BuildContext context) => InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.always,
  border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(8.0))),
  hintMaxLines: 150,
  errorMaxLines: 150,
  helperMaxLines: 150,
);
