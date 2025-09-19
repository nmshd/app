import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';

class BooleanFormFieldSettingsRenderer extends StatefulWidget {
  final FormFieldRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const BooleanFormFieldSettingsRenderer({required this.item, required this.controller, required this.itemIndex, super.key});

  @override
  State<BooleanFormFieldSettingsRenderer> createState() => _BooleanFormFieldSettingsRendererState();
}

class _BooleanFormFieldSettingsRendererState extends State<BooleanFormFieldSettingsRenderer> {
  bool? _value;

  @override
  void initState() {
    super.initState();

    if (widget.item.response is FormFieldAcceptResponseItemDVO) {
      final response = widget.item.response as FormFieldAcceptResponseItemDVO;
      _value = (response.response as FormFieldBoolResponse).value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 208),
      child: SegmentedButton<bool>(
        segments: [
          ButtonSegment<bool>(value: true, label: Text(FlutterI18n.translate(context, 'common.yes'), textAlign: TextAlign.center)),
          ButtonSegment<bool>(value: false, label: Text(FlutterI18n.translate(context, 'common.no'), textAlign: TextAlign.center)),
        ],
        selected: {?_value},
        emptySelectionAllowed: true,
        multiSelectionEnabled: false,
        showSelectedIcon: true,
        onSelectionChanged: widget.item.isDecidable ? (selection) => _onChanged(selection.firstOrNull) : null,
      ),
    );
  }

  void _onChanged(bool? newValue) {
    setState(() => _value = newValue);

    final params = newValue == null ? RejectRequestItemParameters() : AcceptFormFieldRequestItemParameters(response: FormFieldBoolResponse(newValue));
    widget.controller?.writeAtIndex(index: widget.itemIndex, value: params);
  }
}
