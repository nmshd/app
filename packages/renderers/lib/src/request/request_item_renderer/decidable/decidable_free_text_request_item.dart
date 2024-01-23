import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../custom_list_tile.dart';
import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import 'checkbox_enabled_extension.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableFreeTextRequestItemRenderer extends StatefulWidget {
  final DecidableFreeTextRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final LocalRequestStatus? requestStatus;

  const DecidableFreeTextRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.requestStatus,
  });

  @override
  State<DecidableFreeTextRequestItemRenderer> createState() => _DecidableFreeTextRequestItemRendererState();
}

class _DecidableFreeTextRequestItemRendererState extends State<DecidableFreeTextRequestItemRenderer> {
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
      title: widget.item.name,
      description: widget.item.description,
      thirdLine: widget.item.freeText,
      checkboxSettings: (isChecked: isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
    );
  }

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() {
      isChecked = value;
    });

    handleCheckboxChange(
      isChecked: isChecked,
      controller: widget.controller,
      itemIndex: widget.itemIndex,
    );
  }
}
