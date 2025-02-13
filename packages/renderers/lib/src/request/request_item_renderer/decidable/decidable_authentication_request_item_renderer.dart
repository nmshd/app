import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../../custom_list_tile.dart';
import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import 'checkbox_enabled_extension.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableAuthenticationRequestItemRenderer extends StatefulWidget {
  final DecidableAuthenticationRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const DecidableAuthenticationRequestItemRenderer({super.key, required this.item, this.controller, required this.itemIndex});

  @override
  State<DecidableAuthenticationRequestItemRenderer> createState() => _DecidableAuthenticationRequestItemRendererState();
}

class _DecidableAuthenticationRequestItemRendererState extends State<DecidableAuthenticationRequestItemRenderer> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked;

    if (isChecked) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: isChecked, onChanged: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
        Expanded(child: CustomListTile(title: 'i18n://dvo.requestItem.DecidableAuthenticationRequestItem.name', thirdLine: widget.item.name)),
      ],
    );
  }

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() {
      isChecked = value;
    });

    handleCheckboxChange(isChecked: isChecked, controller: widget.controller, itemIndex: widget.itemIndex);
  }
}
