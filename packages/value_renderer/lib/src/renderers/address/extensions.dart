import 'package:enmeshed_types/enmeshed_types.dart';

extension ToValueHintsDefaultValueString on String? {
  ValueHintsDefaultValueString? toValueHintsDefaultValue() => this == null ? null : ValueHintsDefaultValueString(this!);
}
