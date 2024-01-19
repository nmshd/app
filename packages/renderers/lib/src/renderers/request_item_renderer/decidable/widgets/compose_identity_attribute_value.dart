import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:value_renderer/value_renderer.dart';

import '../../../widgets/request_renderer_controller.dart';

IdentityAttribute? composeIdentityAttributeValue({
  String? valueType,
  ValueRendererInputValue? inputValue,
  required bool isComplex,
  required RequestRendererController? controller,
}) {
  if (inputValue != null) {
    if (inputValue is ValueRendererInputValueString && inputValue.value == '') return null;

    if (isComplex && valueType != 'BirthDate') {
      final complexInputValue = inputValue as ValueRendererInputValueMap;

      final attributeValues = complexInputValue.value.map((key, value) {
        final attributeValue = switch (value) {
          final ValueRendererInputValueBool attribute => attribute.value.toString(),
          final ValueRendererInputValueNum attribute => attribute.value.toString(),
          final ValueRendererInputValueString attribute => attribute.value,
          final ValueRendererInputValueDateTime attribute => attribute.value,
          final ValueRendererInputValueMap attribute => attribute.value,
          _ => null
        };

        return MapEntry(key, attributeValue != '' ? attributeValue : null);
      });

      try {
        return IdentityAttribute(
          owner: '',
          value: IdentityAttributeValue.fromJson({'@type': valueType, ...attributeValues}),
        );
      } catch (e) {
        return null;
      }
    } else if (valueType == 'BirthDate') {
      final birthDateInputValue = inputValue as ValueRendererInputValueDateTime;

      return IdentityAttribute(
        owner: '',
        value: IdentityAttributeValue.fromJson({
          '@type': valueType,
          'day': birthDateInputValue.value.day,
          'month': birthDateInputValue.value.month,
          'year': birthDateInputValue.value.year,
        }),
      );
    } else {
      final attributeValue = switch (inputValue) {
        final ValueRendererInputValueBool attribute => attribute.value.toString(),
        final ValueRendererInputValueNum attribute => attribute.value.toString(),
        final ValueRendererInputValueString attribute => attribute.value,
        final ValueRendererInputValueDateTime attribute => attribute.value,
        final ValueRendererInputValueMap attribute => attribute.value,
      };

      return IdentityAttribute(
        owner: '',
        value: IdentityAttributeValue.fromJson({'@type': valueType, 'value': attributeValue}),
      );
    }
  }

  return null;
}
