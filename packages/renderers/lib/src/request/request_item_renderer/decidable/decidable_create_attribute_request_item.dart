import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '/src/attribute/draft_attribute_renderer.dart';
import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import 'checkbox_enabled_extension.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableCreateAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableCreateAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;

  const DecidableCreateAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    required this.expandFileReference,
    required this.openFileDetails,
  });

  @override
  State<DecidableCreateAttributeRequestItemRenderer> createState() => _DecidableCreateAttributeRequestItemRendererState();
}

class _DecidableCreateAttributeRequestItemRendererState extends State<DecidableCreateAttributeRequestItemRenderer> {
  late bool _isChecked;
  late bool _isManualDecisionAccepted;

  @override
  void initState() {
    super.initState();

    _isChecked = widget.item.initiallyChecked(widget.item.mustBeAccepted);
    _isManualDecisionAccepted = widget.item.initallyDecided;

    if (_isChecked) widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: DraftAttributeRenderer(
        draftAttribute: widget.item.attribute,
        checkboxSettings: (
          isChecked: _isChecked,
          onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null,
          isManualDecided: _isManualDecisionAccepted,
          onUpdateManualDecision: null,
        ),
        expandFileReference: widget.expandFileReference,
        openFileDetails: widget.openFileDetails,
      ),
    );
  }

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() => _isChecked = value);

    handleCheckboxChange(isChecked: _isChecked, controller: widget.controller, itemIndex: widget.itemIndex);
  }
}
