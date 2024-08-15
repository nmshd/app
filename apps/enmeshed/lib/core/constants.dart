import 'package:flutter/material.dart';

class Gaps {
  Gaps._();

  static const SizedBox h4 = SizedBox(height: 4);
  static const SizedBox h8 = SizedBox(height: 8);
  static const SizedBox h12 = SizedBox(height: 12);
  static const SizedBox h16 = SizedBox(height: 16);
  static const SizedBox h24 = SizedBox(height: 24);
  static const SizedBox h32 = SizedBox(height: 32);
  static const SizedBox h40 = SizedBox(height: 40);
  static const SizedBox h44 = SizedBox(height: 44);
  static const SizedBox h48 = SizedBox(height: 48);

  static const SizedBox w4 = SizedBox(width: 4);
  static const SizedBox w8 = SizedBox(width: 8);
  static const SizedBox w16 = SizedBox(width: 16);
  static const SizedBox w24 = SizedBox(width: 24);
  static const SizedBox w32 = SizedBox(width: 32);
  static const SizedBox w40 = SizedBox(width: 40);
}

class CustomRegExp {
  CustomRegExp._();

  static RegExp html = RegExp('<[^>]*>|&[^;]+;');
}

class MaxLength {
  MaxLength._();

  static const int profileName = 40;

  static const int deviceName = 20;
  static const int deviceDescription = 50;

  static const int fileName = 50;
}

const unknownContactName = 'i18n://dvo.identity.unknown';
