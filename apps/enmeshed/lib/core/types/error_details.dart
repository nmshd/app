import 'dart:ui';

typedef ErrorDetails = ({String errorCode, VoidCallback? onButtonPressed});

ErrorDetails createErrorDetails({required String errorCode, VoidCallback? onButtonPressed}) {
  return (errorCode: errorCode, onButtonPressed: onButtonPressed);
}
