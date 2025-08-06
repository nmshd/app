import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/src/attribute/attribute_renderer.dart';
import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'decidable/widgets/handle_checkbox_change.dart';
import 'extensions/extensions.dart';

class CreateAttributeRequestItemRenderer extends StatefulWidget {
  final CreateAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;
  final RequestValidationResultDTO? validationResult;

  const CreateAttributeRequestItemRenderer({
    super.key,
    required this.item,
    required this.controller,
    required this.itemIndex,
    required this.expandFileReference,
    required this.openFileDetails,
    required this.validationResult,
  });

  @override
  State<CreateAttributeRequestItemRenderer> createState() => _CreateAttributeRequestItemRendererState();
}

class _CreateAttributeRequestItemRendererState extends State<CreateAttributeRequestItemRenderer> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();

    if (widget.item.response != null) {
      _isChecked = widget.item.response is AcceptResponseItemDVO;
    } else {
      _isChecked = widget.item.initiallyChecked;
    }

    if (_isChecked) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Checkbox(value: _isChecked, onChanged: widget.item.isDecidable && !widget.item.initiallyChecked ? _onUpdateCheckbox : null),
          Expanded(
            child: AttributeRenderer(
              attribute: widget.item.attribute.content,
              valueHints: widget.item.attribute.valueHints,
              expandFileReference: widget.expandFileReference,
              openFileDetails: widget.openFileDetails,
            ),
          ),
        ],
      ),
    );
  }

  void _onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() => _isChecked = value);

    handleCheckboxChange(isChecked: _isChecked, controller: widget.controller, itemIndex: widget.itemIndex);
  }
}
