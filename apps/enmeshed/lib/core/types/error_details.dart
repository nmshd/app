import 'dart:ui';

typedef ErrorDetails = ({String? errorCode, VoidCallback? onButtonPressed});

ErrorDetails createErrorDetails({String? errorCode, VoidCallback? onButtonPressed}) {
  return (errorCode: errorCode, onButtonPressed: onButtonPressed);
}
