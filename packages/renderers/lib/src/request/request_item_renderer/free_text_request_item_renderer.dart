import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../custom_list_tile.dart';
import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'extensions/extensions.dart';

class FreeTextRequestItemRenderer extends StatefulWidget {
  final FreeTextRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final LocalRequestStatus? requestStatus;

  const FreeTextRequestItemRenderer({super.key, required this.item, this.controller, required this.itemIndex, this.requestStatus});

  @override
  State<FreeTextRequestItemRenderer> createState() => _FreeTextRequestItemRendererState();
}

class _FreeTextRequestItemRendererState extends State<FreeTextRequestItemRenderer> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();

    _isChecked = widget.item.initiallyChecked;

    if (_isChecked) {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: const AcceptFreeTextRequestItemParameters(freeText: ''),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.item.isDecidable) {
      return CustomListTile(title: widget.item.name, description: widget.item.description, thirdLine: widget.item.freeText);
    }

    final active = widget.item.isDecidable && !widget.item.initiallyChecked;
    return Row(
      children: [
        Checkbox(value: _isChecked, onChanged: active ? onUpdateCheckbox : null),
        Expanded(
          child: CustomListTile(title: widget.item.name, description: widget.item.description, thirdLine: widget.item.freeText),
        ),
      ],
    );
  }

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() {
      _isChecked = value;
    });

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: value ? const AcceptRequestItemParameters() : const RejectRequestItemParameters(),
    );
  }
}
