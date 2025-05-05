import 'package:enmeshed_types/enmeshed_types.dart';

extension CheckboxExtension on RequestItemDVODerivation {
  bool get checkboxEnabled => switch ((requireManualDecision, mustBeAccepted)) {
    (true, _) => true,
    (_, true) => false,
    _ => true,
  };
}
