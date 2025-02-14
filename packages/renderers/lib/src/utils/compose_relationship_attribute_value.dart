import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:value_renderer/value_renderer.dart';

RelationshipAttribute? composeRelationshipAttributeValue({
  String? valueType,
  ValueRendererInputValue? inputValue,
  required bool isComplex,
  required ProcessedRelationshipAttributeQueryDVO query,
  required String currentAddress,
}) {
  if (inputValue == null) return null;
  if (inputValue is ValueRendererInputValueString && inputValue.value == '') return null;

  if (isComplex) {
    final complexInputValue = inputValue as ValueRendererInputValueMap;

    final attributeValues = complexInputValue.value.map((key, value) {
      final attributeValue = switch (value) {
        final ValueRendererInputValueBool attribute => attribute.value,
        final ValueRendererInputValueNum attribute => attribute.value,
        final ValueRendererInputValueString attribute => attribute.value,
        final ValueRendererInputValueMap attribute => attribute.value,
        _ => null,
      };

      return MapEntry(key, attributeValue != '' ? attributeValue : null);
    });

    try {
      return RelationshipAttribute(
        confidentiality: RelationshipAttributeConfidentiality.values.byName(query.attributeCreationHints.confidentiality),
        key: query.key,
        owner: currentAddress,
        value: RelationshipAttributeValue.fromJson({'@type': valueType, ...attributeValues}),
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
    _ => null,
  };

  if (attributeValue == null) return null;

  return RelationshipAttribute(
    confidentiality: RelationshipAttributeConfidentiality.values.byName(query.attributeCreationHints.confidentiality),
    key: query.key,
    owner: currentAddress,
    value: RelationshipAttributeValue.fromJson({'@type': valueType, 'title': query.attributeCreationHints.title, 'value': attributeValue}),
  );
}
