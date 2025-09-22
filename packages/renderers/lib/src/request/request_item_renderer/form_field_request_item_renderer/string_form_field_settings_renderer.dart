import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';

class StringFormFieldSettingsRenderer extends StatefulWidget {
  final FormFieldRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final void Function(VoidCallback? onTap) setOnTap;

  const StringFormFieldSettingsRenderer({required this.item, required this.controller, required this.itemIndex, required this.setOnTap, super.key});

  @override
  State<StringFormFieldSettingsRenderer> createState() => _StringFormFieldSettingsRendererState();
}

class _StringFormFieldSettingsRendererState extends State<StringFormFieldSettingsRenderer> {
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

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text((response.response as FormFieldStringResponse).value, style: Theme.of(context).textTheme.bodyLarge),
      );
    }

    // TODO(jkoenig134): handle min, max and allowNewlines

    return TextField(
      focusNode: _focusNode,
      showCursor: _focusNode.hasFocus,
      decoration: InputDecoration(
        hintText: FlutterI18n.translate(context, 'requestRenderer.formField.noValue'),
        border: InputBorder.none,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.outlineVariant),
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        isDense: true,
      ),
      controller: _textController,
      onTap: () => _focusNode.requestFocus(),
      onTapOutside: (_) => _focusNode.unfocus(),
      onChanged: (newValue) => widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: newValue.isEmpty ? RejectRequestItemParameters() : AcceptFormFieldRequestItemParameters(response: FormFieldStringResponse(newValue)),
      ),
    );
  }
}
