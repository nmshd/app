import 'package:enmeshed_types/enmeshed_types.dart';

class ControllerTypeResolver {
  static ValueHintsDefaultValue resolveType({required dynamic inputValue, required RenderHintsTechnicalType type}) {
    switch (type) {
      case RenderHintsTechnicalType.Boolean:
        return ValueHintsDefaultValueBool(inputValue.value);
      case RenderHintsTechnicalType.Float:
        return ValueHintsDefaultValueNum(inputValue.value.toDouble());
      case RenderHintsTechnicalType.Integer:
        return ValueHintsDefaultValueNum(inputValue.value.toInt());
      case RenderHintsTechnicalType.String:
        return ValueHintsDefaultValueString(inputValue.value.toString());
      //TODO: Define a proper default value
      default:
        return ValueHintsDefaultValueString(inputValue.value.toString());
    }
  }
}
