import 'package:enmeshed_types/enmeshed_types.dart';

import 'value_renderer_input_value.dart';

class ControllerTypeResolver {
  static ValueRendererInputValue resolveType({required dynamic inputValue, required RenderHintsTechnicalType type}) {
    return switch (type) {
      RenderHintsTechnicalType.Boolean => ValueRendererInputValueBool(inputValue.value),
      RenderHintsTechnicalType.Float => ValueRendererInputValueNum(inputValue.value.toDouble()),
      RenderHintsTechnicalType.Integer => ValueRendererInputValueNum(inputValue.value.toInt()),
      RenderHintsTechnicalType.String => ValueRendererInputValueString(inputValue.value.toString()),
      _ => throw Exception('Cannot resolve type for RenderHintsTechnicalType ${type.name}'),
    };
  }
}
