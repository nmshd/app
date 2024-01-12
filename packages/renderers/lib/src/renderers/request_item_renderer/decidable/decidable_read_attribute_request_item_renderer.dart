import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/request_item_index.dart';
import '../../widgets/request_renderer_controller.dart';
import '../widgets/processed_query_renderer.dart';
import 'checkbox_enabled_extension.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableReadAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableReadAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<AbstractAttribute> Function({required String valueType})? selectAttribute;
  final LocalRequestStatus? requestStatus;

  const DecidableReadAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.selectAttribute,
    this.requestStatus,
  });

  @override
  State<DecidableReadAttributeRequestItemRenderer> createState() => _DecidableReadAttributeRequestItemRendererState();
}

class _DecidableReadAttributeRequestItemRendererState extends State<DecidableReadAttributeRequestItemRenderer> {
  late bool isChecked;
  AbstractAttribute? newAttribute;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked;

    final attribute = attributeContent(widget.item.query);
    if (attribute == null) return;

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: attribute),
    );
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => ProcessedIdentityAttributeQueryRenderer(
          query: query,
          checkboxSettings: (isChecked: isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
          onUpdateAttribute: onUpdateAttribute,
          onUpdateInput: onUpdateInput,
          selectedAttribute: newAttribute,
        ),
      final ProcessedRelationshipAttributeQueryDVO query => ProcessedRelationshipAttributeQueryRenderer(
          query: query,
          checkboxSettings: (isChecked: isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
          onUpdateAttribute: onUpdateAttribute,
          onUpdateInput: onUpdateInput,
          selectedAttribute: newAttribute,
        ),
      //final ThirdPartyRelationshipAttributeQueryDVO query => ThirdPartyAttributeQueryRenderer(query: query),
      _ => throw Exception("Invalid type '${widget.item.query.type}'"),
    };
  }

  AbstractAttribute? attributeContent(ProcessedAttributeQueryDVO attribute) {
    return switch (widget.item.query) {
      final ProcessedIdentityAttributeQueryDVO query => query.results.firstOrNull?.content,
      final ProcessedRelationshipAttributeQueryDVO query => query.results.firstOrNull?.content,
      final ProcessedThirdPartyRelationshipAttributeQueryDVO query => query.thirdParty.first.relationship?.items.firstOrNull?.content,
      final ProcessedIQLQueryDVO query => query.results.firstOrNull?.content,
    };
  }

  void onUpdateCheckbox(bool? value) {
    setState(() {
      isChecked = value!;
    });

    final attribute = attributeContent(widget.item.query);
    if (attribute == null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: const RejectRequestItemParameters(),
      );

      return;
    }

    handleCheckboxChange(
      isChecked: isChecked,
      controller: widget.controller,
      itemIndex: widget.itemIndex,
      acceptRequestItemParameter: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: newAttribute ?? attribute),
    );
  }

  void onUpdateInput({String? valueType, dynamic inputValue, required bool isComplex}) {
    if (inputValue != null && inputValue != '') {
      if (isComplex && valueType != 'BirthDate') {
        final attributeValues = inputValue.map((String key, value) {
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
          final identityAttributeValue = IdentityAttributeValue.fromJson({'@type': valueType, ...attributeValues});

          newAttribute = IdentityAttribute(
            owner: '',
            value: identityAttributeValue,
          );
        } catch (e) {
          widget.controller?.writeAtIndex(
            index: widget.itemIndex,
            value: const RejectRequestItemParameters(),
          );

          return;
        }
      } else if (valueType == 'BirthDate') {
        newAttribute = IdentityAttribute(
          owner: '',
          value: IdentityAttributeValue.fromJson({
            '@type': valueType,
            'day': DateTime.parse(inputValue).day,
            'month': DateTime.parse(inputValue).month,
            'year': DateTime.parse(inputValue).year,
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

        setState(() {
          newAttribute = IdentityAttribute(
            owner: '',
            value: IdentityAttributeValue.fromJson({'@type': valueType, 'value': attributeValue}),
          );
        });
      }

      updateSelectedAttribute();
    } else {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: const RejectRequestItemParameters(),
      );
    }
  }

  Future<void> onUpdateAttribute(String valueType) async {
    final selectedAttribute = await widget.selectAttribute?.call(valueType: valueType);

    if (selectedAttribute != null) {
      setState(() {
        newAttribute = selectedAttribute;
      });

      updateSelectedAttribute();
    }
  }

  void updateSelectedAttribute() {
    if (newAttribute != null) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: newAttribute!),
      );
    } else {
      final attribute = attributeContent(widget.item.query);
      if (attribute == null) return;

      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: AcceptReadAttributeRequestItemParametersWithNewAttribute(newAttribute: attribute),
      );
    }
  }
}
