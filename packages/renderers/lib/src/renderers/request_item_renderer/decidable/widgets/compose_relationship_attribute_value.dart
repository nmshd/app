import 'package:enmeshed_types/enmeshed_types.dart';

import '../../../widgets/request_renderer_controller.dart';

RelationshipAttribute? composeRelationshipAttributeValue({
  String? valueType,
  dynamic inputValue,
  required bool isComplex,
  required RequestRendererController? controller,
  ProcessedRelationshipAttributeQueryDVO? query,
}) {
  if (inputValue != null && inputValue != '') {
    if (isComplex) {
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
        final ValueHintsDefaultValueBool attribute => attribute.value.toString(),
        final ValueHintsDefaultValueNum attribute => attribute.value.toString(),
        final ValueHintsDefaultValueString attribute => attribute.value,
        final String attribute => attribute,
        final bool attribute => attribute.toString(),
        _ => inputValue.toString()
      };

      return RelationshipAttribute(
        confidentiality: RelationshipAttributeConfidentiality.values.byName(query?.attributeCreationHints.confidentiality ?? 'public'),
        key: query?.key ?? '',
        owner: query?.owner.id ?? '',
        value: RelationshipAttributeValue.fromJson({
          '@type': valueType,
          'value': attributeValue,
          'title': query?.attributeCreationHints.title ?? '',
        }),
      );
    }
  }

  return null;
}
