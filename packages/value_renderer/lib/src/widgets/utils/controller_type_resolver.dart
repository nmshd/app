import 'package:enmeshed_types/enmeshed_types.dart';

class ControllerTypeResolver {
  static ValueHintsDefaultValue resolveType({required dynamic inputValue, required RenderHintsTechnicalType type}) {
    return switch (type) {
      RenderHintsTechnicalType.Boolean => ValueHintsDefaultValueBool(inputValue.value),
      RenderHintsTechnicalType.Float => ValueHintsDefaultValueNum(inputValue.value.toDouble()),
      RenderHintsTechnicalType.Integer => ValueHintsDefaultValueNum(inputValue.value.toInt()),
      RenderHintsTechnicalType.String => ValueHintsDefaultValueString(inputValue.value.toString()),
      _ => throw Exception('Cannot resolve type for RenderHintsTechnicalType ${type.name}'),
    };
  }
}
