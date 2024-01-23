import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:value_renderer/value_renderer.dart';

IdentityAttribute? composeIdentityAttributeValue({
  String? valueType,
  ValueRendererInputValue? inputValue,
  required bool isComplex,
  required String currentAddress,
}) {
  if (inputValue == null) return null;
  if (inputValue is ValueRendererInputValueString && inputValue.value == '') return null;

  if (isComplex && valueType == 'BirthDate') {
    final birthDateInputValue = inputValue as ValueRendererInputValueDateTime;

    return IdentityAttribute(
      owner: currentAddress,
      value: IdentityAttributeValue.fromJson({
        '@type': valueType,
        'day': birthDateInputValue.value.day,
        'month': birthDateInputValue.value.month,
        'year': birthDateInputValue.value.year,
      }),
    );
  }

  if (isComplex) {
    final complexInputValue = inputValue as ValueRendererInputValueMap;

    final attributeValues = complexInputValue.value.map((key, value) {
      final attributeValue = switch (value) {
        final ValueRendererInputValueBool attribute => attribute.value,
        final ValueRendererInputValueNum attribute => attribute.value,
        final ValueRendererInputValueString attribute => attribute.value,
        final ValueRendererInputValueDateTime attribute => attribute.value,
        final ValueRendererInputValueMap attribute => attribute.value,
        _ => null
      };

      return MapEntry(key, attributeValue != '' ? attributeValue : null);
    });

    try {
      return IdentityAttribute(
        owner: currentAddress,
        value: IdentityAttributeValue.fromJson({'@type': valueType, ...attributeValues}),
      );
    } catch (e) {
      return null;
    }
  }

  final attributeValue = switch (inputValue) {
    final ValueRendererInputValueBool attribute => attribute.value,
    final ValueRendererInputValueNum attribute => attribute.value,
    final ValueRendererInputValueString attribute => attribute.value,
    final ValueRendererInputValueMap attribute => attribute.value,
    _ => null
  };

  if (attributeValue == null) return null;

  return IdentityAttribute(
    owner: currentAddress,
    value: IdentityAttributeValue.fromJson({'@type': valueType, 'value': attributeValue}),
  );
}
