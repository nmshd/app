import 'package:flutter/material.dart';

const inputDecoration = InputDecoration(
  counterText: '',
  floatingLabelBehavior: FloatingLabelBehavior.auto,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(width: 1, color: Colors.grey),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(width: 1, color: Colors.blue),
  ),
  hintMaxLines: 150,
  errorMaxLines: 150,
  helperMaxLines: 150,
);
