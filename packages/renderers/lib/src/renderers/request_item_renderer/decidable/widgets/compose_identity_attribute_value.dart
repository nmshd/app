import 'package:enmeshed_types/enmeshed_types.dart';

import '../../../widgets/request_renderer_controller.dart';

IdentityAttribute? composeIdentityAttributeValue({
  String? valueType,
  dynamic inputValue,
  required bool isComplex,
  required RequestRendererController? controller,
}) {
  if (inputValue != null && inputValue != '') {
    if (isComplex && valueType != 'BirthDate') {
      final attributeValues = inputValue.map((key, value) {
        final attributeValue = switch (value) {
          final ValueHintsDefaultValueBool attribute => attribute.value.toString(),
          final ValueHintsDefaultValueNum attribute => attribute.value.toString(),
          final ValueHintsDefaultValueString attribute => attribute.value,
          final String attribute => attribute,
          final bool attribute => attribute.toString(),
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
      return IdentityAttribute(
        owner: '',
        value: IdentityAttributeValue.fromJson({
          '@type': valueType,
          'day': inputValue.day,
          'month': inputValue.month,
          'year': inputValue.year,
        }),
      );
    } else {
      final attributeValue = switch (inputValue) {
        final ValueHintsDefaultValueBool attribute => attribute.value.toString(),
        final ValueHintsDefaultValueNum attribute => attribute.value.toString(),
        final ValueHintsDefaultValueString attribute => attribute.value,
        final String attribute => attribute,
        final bool attribute => attribute.toString(),
        _ => inputValue.toString()
      };

      return IdentityAttribute(
        owner: '',
        value: IdentityAttributeValue.fromJson({'@type': valueType, 'value': attributeValue}),
      );
    }
  }

  return null;
}
