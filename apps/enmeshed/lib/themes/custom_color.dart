import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const neutral_variant = Color(0xFFDDDDDD);
const decorative = Color(0xFFE4DC93);
const decorative_2 = Color(0xFFEB8CDA);
const error = Color(0xFFFF5354);
const warning = Color(0xFFED9923);
const success = Color(0xFF29822D);

CustomColors lightCustomColors = const CustomColors(
  sourceNeutralvariant: Color(0xFFDDDDDD),
  neutralvariant: Color(0xFF006874),
  onNeutralvariant: Color(0xFFFFFFFF),
  neutralvariantContainer: Color(0xFF97F0FF),
  onNeutralvariantContainer: Color(0xFF001F24),
  sourceDecorative: Color(0xFFE4DC93),
  decorative: Color(0xFF676000),
  onDecorative: Color(0xFFFFFFFF),
  decorativeContainer: Color(0xFFE4DC93),
  onDecorativeContainer: Color(0xFF1F1C00),
  sourceDecorative2: Color(0xFFEB8CDA),
  decorative2: Color(0xFF913E87),
  onDecorative2: Color(0xFFFFFFFF),
  decorative2Container: Color(0xFFFFD7F3),
  onDecorative2Container: Color(0xFF390035),
  sourceError: Color(0xFFFF5354),
  error: Color(0xFFB81D28),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD7),
  onErrorContainer: Color(0xFF410005),
  sourceWarning: Color(0xFFED9923),
  warning: Color(0xFF875200),
  warningIcon: Color(0xFFE89521),
  onWarning: Color(0xFFFFFFFF),
  warningContainer: Color(0xFFFFDDBA),
  onWarningContainer: Color(0xFF2B1700),
  sourceSuccess: Color(0xFF29822D),
  success: Color(0xFF0D6E1B),
  successIcon: Color(0xFF2B9E30),
  onSuccess: Color(0xFFFFFFFF),
  successContainer: Color(0xFF9CF893),
  onSuccessContainer: Color(0xFF002203),
);

CustomColors darkCustomColors = const CustomColors(
  sourceNeutralvariant: Color(0xFFDDDDDD),
  neutralvariant: Color(0xFF4FD8EB),
  onNeutralvariant: Color(0xFF00363D),
  neutralvariantContainer: Color(0xFF004F58),
  onNeutralvariantContainer: Color(0xFF97F0FF),
  sourceDecorative: Color(0xFFE4DC93),
  decorative: Color(0xFFD4CA51),
  onDecorative: Color(0xFF353100),
  decorativeContainer: Color(0xFF4D4800),
  onDecorativeContainer: Color(0xFFF1E66A),
  sourceDecorative2: Color(0xFFEB8CDA),
  decorative2: Color(0xFFFFABEE),
  onDecorative2: Color(0xFF5A0854),
  decorative2Container: Color(0xFF75256D),
  onDecorative2Container: Color(0xFFFFD7F3),
  sourceError: Color(0xFFFF5354),
  error: Color(0xFFFFB3AF),
  onError: Color(0xFF68000D),
  errorContainer: Color(0xFF930016),
  onErrorContainer: Color(0xFFFFDAD7),
  sourceWarning: Color(0xFFED9923),
  warning: Color(0xFFFFB865),
  warningIcon: Color(0xFFE89521),
  onWarning: Color(0xFF482A00),
  warningContainer: Color(0xFF663D00),
  onWarningContainer: Color(0xFFFFDDBA),
  sourceSuccess: Color(0xFF29822D),
  success: Color(0xFF81DB7A),
  successIcon: Color(0xFF2B9E30),
  onSuccess: Color(0xFF003907),
  successContainer: Color(0xFF00530F),
  onSuccessContainer: Color(0xFF9CF893),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceNeutralvariant,
    required this.neutralvariant,
    required this.onNeutralvariant,
    required this.neutralvariantContainer,
    required this.onNeutralvariantContainer,
    required this.sourceDecorative,
    required this.decorative,
    required this.onDecorative,
    required this.decorativeContainer,
    required this.onDecorativeContainer,
    required this.sourceDecorative2,
    required this.decorative2,
    required this.onDecorative2,
    required this.decorative2Container,
    required this.onDecorative2Container,
    required this.sourceError,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.sourceWarning,
    required this.warning,
    required this.warningIcon,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.sourceSuccess,
    required this.success,
    required this.successIcon,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
  });

  final Color? sourceNeutralvariant;
  final Color? neutralvariant;
  final Color? onNeutralvariant;
  final Color? neutralvariantContainer;
  final Color? onNeutralvariantContainer;
  final Color? sourceDecorative;
  final Color? decorative;
  final Color? onDecorative;
  final Color? decorativeContainer;
  final Color? onDecorativeContainer;
  final Color? sourceDecorative2;
  final Color? decorative2;
  final Color? onDecorative2;
  final Color? decorative2Container;
  final Color? onDecorative2Container;
  final Color? sourceError;
  final Color? error;
  final Color? onError;
  final Color? errorContainer;
  final Color? onErrorContainer;
  final Color? sourceWarning;
  final Color? warning;
  final Color? warningIcon;
  final Color? onWarning;
  final Color? warningContainer;
  final Color? onWarningContainer;
  final Color? sourceSuccess;
  final Color? success;
  final Color? successIcon;
  final Color? onSuccess;
  final Color? successContainer;
  final Color? onSuccessContainer;

  @override
  CustomColors copyWith({
    Color? sourceNeutralvariant,
    Color? neutralvariant,
    Color? onNeutralvariant,
    Color? neutralvariantContainer,
    Color? onNeutralvariantContainer,
    Color? sourceDecorative,
    Color? decorative,
    Color? onDecorative,
    Color? decorativeContainer,
    Color? onDecorativeContainer,
    Color? sourceDecorative2,
    Color? decorative2,
    Color? onDecorative2,
    Color? decorative2Container,
    Color? onDecorative2Container,
    Color? sourceError,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? sourceWarning,
    Color? warning,
    Color? warningIcon,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? sourceSuccess,
    Color? success,
    Color? successIcon,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
  }) {
    return CustomColors(
      sourceNeutralvariant: sourceNeutralvariant ?? this.sourceNeutralvariant,
      neutralvariant: neutralvariant ?? this.neutralvariant,
      onNeutralvariant: onNeutralvariant ?? this.onNeutralvariant,
      neutralvariantContainer: neutralvariantContainer ?? this.neutralvariantContainer,
      onNeutralvariantContainer: onNeutralvariantContainer ?? this.onNeutralvariantContainer,
      sourceDecorative: sourceDecorative ?? this.sourceDecorative,
      decorative: decorative ?? this.decorative,
      onDecorative: onDecorative ?? this.onDecorative,
      decorativeContainer: decorativeContainer ?? this.decorativeContainer,
      onDecorativeContainer: onDecorativeContainer ?? this.onDecorativeContainer,
      sourceDecorative2: sourceDecorative2 ?? this.sourceDecorative2,
      decorative2: decorative2 ?? this.decorative2,
      onDecorative2: onDecorative2 ?? this.onDecorative2,
      decorative2Container: decorative2Container ?? this.decorative2Container,
      onDecorative2Container: onDecorative2Container ?? this.onDecorative2Container,
      sourceError: sourceError ?? this.sourceError,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      sourceWarning: sourceWarning ?? this.sourceWarning,
      warning: warning ?? this.warning,
      warningIcon: warningIcon ?? this.warningIcon,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      sourceSuccess: sourceSuccess ?? this.sourceSuccess,
      success: success ?? this.success,
      successIcon: successIcon ?? this.successIcon,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceNeutralvariant: Color.lerp(sourceNeutralvariant, other.sourceNeutralvariant, t),
      neutralvariant: Color.lerp(neutralvariant, other.neutralvariant, t),
      onNeutralvariant: Color.lerp(onNeutralvariant, other.onNeutralvariant, t),
      neutralvariantContainer: Color.lerp(neutralvariantContainer, other.neutralvariantContainer, t),
      onNeutralvariantContainer: Color.lerp(onNeutralvariantContainer, other.onNeutralvariantContainer, t),
      sourceDecorative: Color.lerp(sourceDecorative, other.sourceDecorative, t),
      decorative: Color.lerp(decorative, other.decorative, t),
      onDecorative: Color.lerp(onDecorative, other.onDecorative, t),
      decorativeContainer: Color.lerp(decorativeContainer, other.decorativeContainer, t),
      onDecorativeContainer: Color.lerp(onDecorativeContainer, other.onDecorativeContainer, t),
      sourceDecorative2: Color.lerp(sourceDecorative2, other.sourceDecorative2, t),
      decorative2: Color.lerp(decorative2, other.decorative2, t),
      onDecorative2: Color.lerp(onDecorative2, other.onDecorative2, t),
      decorative2Container: Color.lerp(decorative2Container, other.decorative2Container, t),
      onDecorative2Container: Color.lerp(onDecorative2Container, other.onDecorative2Container, t),
      sourceError: Color.lerp(sourceError, other.sourceError, t),
      error: Color.lerp(error, other.error, t),
      onError: Color.lerp(onError, other.onError, t),
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t),
      onErrorContainer: Color.lerp(onErrorContainer, other.onErrorContainer, t),
      sourceWarning: Color.lerp(sourceWarning, other.sourceWarning, t),
      warning: Color.lerp(warning, other.warning, t),
      warningIcon: Color.lerp(warningIcon, other.warningIcon, t),
      onWarning: Color.lerp(onWarning, other.onWarning, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t),
      sourceSuccess: Color.lerp(sourceSuccess, other.sourceSuccess, t),
      success: Color.lerp(success, other.success, t),
      successIcon: Color.lerp(successIcon, other.successIcon, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t),
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith();
  }
}
