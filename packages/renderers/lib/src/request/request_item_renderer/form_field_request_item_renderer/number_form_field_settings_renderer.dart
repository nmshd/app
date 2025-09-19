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
      final unit = widget.item.settings.unit;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          '${NumberFormat().format((response.response as FormFieldNumResponse).value)}${unit ?? ''}',
          style: Theme.of(context).textTheme.bodyLarge,
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
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0, maxWidth: 200),
          prefixIcon: widget.item.settings.unit == null
              ? null
              : Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(4)),
                  child: Text(widget.item.settings.unit!, style: Theme.of(context).textTheme.bodyLarge),
                ),
          counterText: '',
        ),
        keyboardType: widget.item.settings is IntegerFormFieldSettings
            ? TextInputType.number
            : TextInputType.numberWithOptions(decimal: true, signed: false),
        inputFormatters: [
          widget.item.settings is IntegerFormFieldSettings
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.allow(RegExp(r'^\d+[,|.]?\d{0,4}')),
        ],
        maxLength: 16,
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

extension on FormFieldSettings {
  String? get unit => switch (this) {
    final IntegerFormFieldSettings s => s.unit,
    final DoubleFormFieldSettings s => s.unit,
    _ => null,
  };
}
