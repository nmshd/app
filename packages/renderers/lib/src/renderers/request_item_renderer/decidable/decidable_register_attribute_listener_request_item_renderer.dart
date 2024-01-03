import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_list_tile.dart';
import '../../widgets/request_item_index.dart';
import '../../widgets/request_renderer_controller.dart';
import 'checkbox_enabled_extension.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableRegisterAttributeListenerRequestItemRenderer extends StatefulWidget {
  final DecidableRegisterAttributeListenerRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final LocalRequestStatus? requestStatus;

  const DecidableRegisterAttributeListenerRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.requestStatus,
  });

  @override
  State<DecidableRegisterAttributeListenerRequestItemRenderer> createState() => _DecidableRegisterAttributeListenerRequestItemRendererState();
}

class _DecidableRegisterAttributeListenerRequestItemRendererState extends State<DecidableRegisterAttributeListenerRequestItemRenderer> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked;

    widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: widget.item.query.name,
      checkboxSettings: (isChecked: isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
    );
  }

  void onUpdateCheckbox(bool? value) {
    setState(() {
      isChecked = value!;
    });

    handleCheckboxChange(
      isChecked: isChecked,
      controller: widget.controller,
      itemIndex: widget.itemIndex,
    );
  }
}
