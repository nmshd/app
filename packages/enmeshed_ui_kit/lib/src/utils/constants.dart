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
