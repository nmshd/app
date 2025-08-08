import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../custom_list_tile.dart';
import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'extensions/extensions.dart';
import 'utils/utils.dart';

class RegisterAttributeListenerRequestItemRenderer extends StatefulWidget {
  final RegisterAttributeListenerRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const RegisterAttributeListenerRequestItemRenderer({required this.item, this.controller, required this.itemIndex, super.key});

  @override
  State<RegisterAttributeListenerRequestItemRenderer> createState() => _RegisterAttributeListenerRequestItemRendererState();
}

class _RegisterAttributeListenerRequestItemRendererState extends State<RegisterAttributeListenerRequestItemRenderer> {
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
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Checkbox(value: _isChecked, onChanged: widget.item.isDecidable && widget.item.checkboxEnabled ? _onUpdateCheckbox : null),
          Expanded(child: CustomListTile(title: widget.item.query.name)),
        ],
      ),
    );
  }

  void _onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() {
      _isChecked = value;
    });

    handleCheckboxChange(isChecked: _isChecked, controller: widget.controller, itemIndex: widget.itemIndex);
  }
}
