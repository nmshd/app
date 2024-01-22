import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/request_item_index.dart';
import '../../widgets/request_renderer_controller.dart';
import '../widgets/draft_attribute_renderer.dart';
import 'checkbox_enabled_extension.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableCreateAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableCreateAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const DecidableCreateAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
  });

  @override
  State<DecidableCreateAttributeRequestItemRenderer> createState() => _DecidableCreateAttributeRequestItemRendererState();
}

class _DecidableCreateAttributeRequestItemRendererState extends State<DecidableCreateAttributeRequestItemRenderer> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked;

    widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
  }

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(
      draftAttribute: widget.item.attribute,
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
