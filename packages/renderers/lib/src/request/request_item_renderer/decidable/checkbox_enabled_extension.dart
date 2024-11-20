import 'package:enmeshed_types/enmeshed_types.dart';

extension CheckboxExtension on RequestItemDVODerivation {
  // checkbox only disabled if mustBeAccepted is true
  bool get checkboxEnabled => !mustBeAccepted;
// Check everything initially
  bool get initiallyChecked => true;
}
