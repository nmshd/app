import 'package:enmeshed_types/enmeshed_types.dart';

extension CheckboxExtension on RequestItemDVODerivation {
  // checkbox only disabled if mustBeAccepted is true
  bool get checkboxEnabled => !mustBeAccepted;
// Check everything initially

  bool initiallyChecked([bool? isEmpty]) => (isEmpty == null) ? true : (isEmpty && mustBeAccepted) || !isEmpty;

}
