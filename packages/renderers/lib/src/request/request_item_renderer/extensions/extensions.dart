import 'package:enmeshed_types/enmeshed_types.dart';

extension InitiallyCheckedExtension on RequestItemDVODerivation {
  bool get initiallyChecked => mustBeAccepted && requireManualDecision != true;
}
