import 'package:enmeshed_types/enmeshed_types.dart';

extension CheckboxExtension on RequestItemDVODerivation {
  // checkbox only disabled if mustBeAccepted is true
  bool get checkboxEnabled => !mustBeAccepted;

  // always check the checkbox only when requireManualDicision is false
  bool initiallyChecked(bool mustBeAccepted, [bool? requireManualDecision]) {
    return mustBeAccepted ? true : (requireManualDecision == true ? false : true);
  }

  bool get initallyDecided => false;
}
