import 'package:flutter/material.dart';

// TODO (jkoenig134): use proper colors as soon as we have the right colors for the light theme
CustomColors lightCustomColors = const CustomColors(
  success: Color(0xFF428C17),
  onSuccess: Color(0xFFFFFFFF),
  successContainer: Color(0xFFC6EEAA),
  onSuccessContainer: Color(0xFF082100),
  warning: Color(0xFF8C6117),
  onWarning: Color(0xFFFFFFFF),
  warningContainer: Color(0xFFFADEBC),
  onWarningContainer: Color(0xFF271904),
  decorative: Color(0xFF61178C),
  onDecorative: Color(0xFFFFFFFF),
  decorativeContainer: Color(0xFFF4D9FF),
  onDecorativeContainer: Color(0xFF261431),
  decorative2: Color(0xFF8EB0E9),
  onDecorative2: Color(0xFFFFFFFF),
  decorative2Container: Color(0xFFD5E3FF),
  onDecorative2Container: Color(0xFF001B3C),
);

// TODO (jkoenig134): use proper colors as soon as we have a dark theme
CustomColors darkCustomColors = const CustomColors(
  success: Colors.white,
  onSuccess: Colors.white,
  successContainer: Colors.white,
  onSuccessContainer: Colors.white,
  warning: Colors.white,
  onWarning: Colors.white,
  warningContainer: Colors.white,
  onWarningContainer: Colors.white,
  decorative: Colors.white,
  onDecorative: Colors.white,
  decorativeContainer: Colors.white,
  onDecorativeContainer: Colors.white,
  decorative2: Colors.white,
  onDecorative2: Colors.white,
  decorative2Container: Colors.white,
  onDecorative2Container: Colors.white,
);

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.decorative,
    required this.onDecorative,
    required this.decorativeContainer,
    required this.onDecorativeContainer,
    required this.decorative2,
    required this.onDecorative2,
    required this.decorative2Container,
    required this.onDecorative2Container,
  });

  final Color success;
  final Color onSuccess;

  final Color successContainer;
  final Color onSuccessContainer;

  final Color warning;
  final Color onWarning;

  final Color warningContainer;
  final Color onWarningContainer;

  final Color decorative;
  final Color onDecorative;

  final Color decorativeContainer;
  final Color onDecorativeContainer;

  final Color decorative2;
  final Color onDecorative2;

  final Color decorative2Container;
  final Color onDecorative2Container;

  @override
  CustomColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? decorative,
    Color? onDecorative,
    Color? decorativeContainer,
    Color? onDecorativeContainer,
    Color? decorative2,
    Color? onDecorative2,
    Color? decorative2Container,
    Color? onDecorative2Container,
  }) {
    return CustomColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      decorative: decorative ?? this.decorative,
      onDecorative: onDecorative ?? this.onDecorative,
      decorativeContainer: decorativeContainer ?? this.decorativeContainer,
      onDecorativeContainer: onDecorativeContainer ?? this.onDecorativeContainer,
      decorative2: decorative2 ?? this.decorative2,
      onDecorative2: onDecorative2 ?? this.onDecorative2,
      decorative2Container: decorative2Container ?? this.decorative2Container,
      onDecorative2Container: onDecorative2Container ?? this.onDecorative2Container,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }

    return CustomColors(
      success: Color.lerp(success, other.success, t) ?? success,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t) ?? onSuccess,
      successContainer: Color.lerp(successContainer, other.successContainer, t) ?? successContainer,
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t) ?? onSuccessContainer,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      onWarning: Color.lerp(onWarning, other.onWarning, t) ?? onWarning,
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t) ?? warningContainer,
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t) ?? onWarningContainer,
      decorative: Color.lerp(decorative, other.decorative, t) ?? decorative,
      onDecorative: Color.lerp(onDecorative, other.onDecorative, t) ?? onDecorative,
      decorativeContainer: Color.lerp(decorativeContainer, other.decorativeContainer, t) ?? decorativeContainer,
      onDecorativeContainer: Color.lerp(onDecorativeContainer, other.onDecorativeContainer, t) ?? onDecorativeContainer,
      decorative2: Color.lerp(decorative2, other.decorative2, t) ?? decorative2,
      onDecorative2: Color.lerp(onDecorative2, other.onDecorative2, t) ?? onDecorative2,
      decorative2Container: Color.lerp(decorative2Container, other.decorative2Container, t) ?? decorative2Container,
      onDecorative2Container: Color.lerp(onDecorative2Container, other.onDecorative2Container, t) ?? onDecorative2Container,
    );
  }
}
