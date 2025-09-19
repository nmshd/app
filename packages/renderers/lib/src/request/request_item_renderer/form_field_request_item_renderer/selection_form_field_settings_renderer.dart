import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';

class SelectionFormFieldSettingsRenderer extends StatefulWidget {
  final FormFieldRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const SelectionFormFieldSettingsRenderer({required this.item, required this.controller, required this.itemIndex, super.key});

  @override
  State<SelectionFormFieldSettingsRenderer> createState() => _SelectionFormFieldSettingsRendererState();
}

class _SelectionFormFieldSettingsRendererState extends State<SelectionFormFieldSettingsRenderer> {
  late Set<String> _values;

  @override
  void initState() {
    super.initState();

    if (widget.item.response is FormFieldAcceptResponseItemDVO) {
      final response = widget.item.response as FormFieldAcceptResponseItemDVO;
      _values = switch (response.response) {
        final FormFieldStringListResponse r => r.value.toSet(),
        final FormFieldStringResponse r => {r.value},
        _ => throw Exception('Unexpected response type for selection form field: ${response.response.runtimeType}'),
      };
    } else {
      _values = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.item.settings as SelectionFormFieldSettings;

    return Wrap(
      spacing: 8,
      children: settings.options
          .map(
            (e) => InputChip(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              showCheckmark: false,
              label: Text(e),
              selected: _values.contains(e),
              onSelected: widget.item.isDecidable ? (_) => _onChipSelected(e) : null,
            ),
          )
          .toList(),
    );
  }

  void _onChipSelected(String value) {
    final settings = widget.item.settings as SelectionFormFieldSettings;

    setState(() => _values.toggle(value, settings.allowMultipleSelection ?? false));

    if (_values.isEmpty) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: RejectRequestItemParameters());
    } else {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: settings.allowMultipleSelection == true
            ? AcceptFormFieldRequestItemParameters(response: FormFieldStringListResponse(_values.toList()))
            : AcceptFormFieldRequestItemParameters(response: FormFieldStringResponse(_values.first)),
      );
    }
  }
}

extension on Set<String> {
  void toggle(String value, bool multiSelection) {
    if (contains(value)) {
      remove(value);
      return;
    }

    if (multiSelection) {
      add(value);
      return;
    }

    clear();
    add(value);
  }
}
