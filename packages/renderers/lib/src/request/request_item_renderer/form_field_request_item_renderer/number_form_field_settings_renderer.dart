import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';

class NumberFormFieldSettingsRenderer extends StatefulWidget {
  final FormFieldRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final void Function(VoidCallback? onTap) setOnTap;

  const NumberFormFieldSettingsRenderer({required this.item, required this.controller, required this.itemIndex, required this.setOnTap, super.key});

  @override
  State<NumberFormFieldSettingsRenderer> createState() => _NumberFormFieldSettingsRendererState();
}

class _NumberFormFieldSettingsRendererState extends State<NumberFormFieldSettingsRenderer> {
  late final FocusNode _focusNode;
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode()..addListener(() => setState(() {}));
    _textController = TextEditingController();

    if (widget.item.isDecidable) {
      widget.setOnTap(() => _focusNode.requestFocus());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.response is RejectResponseItemDVO) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          FlutterI18n.translate(context, 'requestRenderer.formField.noValue'),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.outlineVariant),
        ),
      );
    }

    if (widget.item.response is FormFieldAcceptResponseItemDVO) {
      final response = widget.item.response as FormFieldAcceptResponseItemDVO;
      final unit = switch (widget.item.settings) {
        final IntegerFormFieldSettings s => s.unit,
        final DoubleFormFieldSettings s => s.unit,
        _ => null,
      };

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          '${NumberFormat().format((response.response as FormFieldNumResponse).value)}${unit ?? ''}',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.outline),
        ),
      );
    }

    return IntrinsicWidth(
      child: TextField(
        focusNode: _focusNode,
        showCursor: _focusNode.hasFocus,
        decoration: InputDecoration(
          hintText: FlutterI18n.translate(context, 'requestRenderer.formField.noValue'),
          border: InputBorder.none,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.outlineVariant),
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          isDense: true,
          suffixStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          suffix: switch (widget.item.settings) {
            final IntegerFormFieldSettings s =>
              s.unit == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(s.unit!, style: Theme.of(context).textTheme.bodyLarge),
                    ),
            final DoubleFormFieldSettings s =>
              s.unit == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(s.unit!, style: Theme.of(context).textTheme.bodyLarge),
                    ),
            _ => null,
          },
        ),
        keyboardType: widget.item.settings is IntegerFormFieldSettings
            ? TextInputType.number
            : TextInputType.numberWithOptions(decimal: true, signed: false),
        inputFormatters: [
          widget.item.settings is IntegerFormFieldSettings
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.allow(RegExp(r'^\d*[,|.]?\d{0,2}')),
        ],
        controller: _textController,
        onTap: () => _focusNode.requestFocus(),
        onTapOutside: (_) => _focusNode.unfocus(),
        onChanged: (newValue) => widget.controller?.writeAtIndex(
          index: widget.itemIndex,
          value: newValue.isEmpty
              ? RejectRequestItemParameters()
              : AcceptFormFieldRequestItemParameters(
                  response: FormFieldNumResponse(
                    // TODO: this
                    widget.item.settings is IntegerFormFieldSettings ? int.parse(newValue) : double.parse(newValue.replaceAll(',', '.')),
                  ),
                ),
        ),
      ),
    );
  }
}
