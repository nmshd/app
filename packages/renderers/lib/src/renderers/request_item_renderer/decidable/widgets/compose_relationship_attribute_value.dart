import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:value_renderer/value_renderer.dart';

import '../../../widgets/request_renderer_controller.dart';

RelationshipAttribute? composeRelationshipAttributeValue({
  String? valueType,
  ValueRendererInputValue? inputValue,
  required bool isComplex,
  required RequestRendererController? controller,
  ProcessedRelationshipAttributeQueryDVO? query,
}) {
  if (inputValue != null) {
    if (inputValue is ValueRendererInputValueString && inputValue.value == '') return null;

    if (isComplex) {
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
        return RelationshipAttribute(
          confidentiality: RelationshipAttributeConfidentiality.values.byName(query?.attributeCreationHints.confidentiality ?? 'public'),
          key: query?.key ?? '',
          owner: query?.owner.id ?? '',
          value: RelationshipAttributeValue.fromJson({'@type': valueType, ...attributeValues}),
        );
      } catch (e) {
        return null;
      }
    } else {
      final attributeValue = switch (inputValue) {
        final ValueRendererInputValueBool attribute => attribute.value.toString(),
        final ValueRendererInputValueNum attribute => attribute.value.toString(),
        final ValueRendererInputValueString attribute => attribute.value,
        final ValueRendererInputValueDateTime attribute => attribute.value,
        final ValueRendererInputValueMap attribute => attribute.value,
      };

      return RelationshipAttribute(
        confidentiality: RelationshipAttributeConfidentiality.values.byName(query?.attributeCreationHints.confidentiality ?? 'public'),
        key: query?.key ?? '',
        owner: query?.owner.id ?? '',
        value: RelationshipAttributeValue.fromJson({
          '@type': valueType,
          'title': query?.attributeCreationHints.title ?? '',
          'value': attributeValue,
        }),
      );
    }
  }

  return null;
}
