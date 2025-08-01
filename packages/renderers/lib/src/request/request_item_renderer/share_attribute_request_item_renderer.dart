import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../attribute/draft_attribute_renderer.dart';
import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'decidable/checkbox_enabled_extension.dart';
import 'decidable/widgets/handle_checkbox_change.dart';
import 'extensions/extensions.dart';

class ShareAttributeRequestItemRenderer extends StatefulWidget {
  final ShareAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final RequestValidationResultDTO? validationResult;
  final Future<FileDVO> Function(String) expandFileReference;
  final void Function(FileDVO) openFileDetails;

  const ShareAttributeRequestItemRenderer({
    super.key,
    required this.item,
    required this.controller,
    required this.itemIndex,
    required this.validationResult,
    required this.expandFileReference,
    required this.openFileDetails,
  });

  @override
  State<ShareAttributeRequestItemRenderer> createState() => _ShareAttributeRequestItemRendererState();
}

class _ShareAttributeRequestItemRendererState extends State<ShareAttributeRequestItemRenderer> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();

    if (widget.item.response != null) {
      _isChecked = widget.item.response is AcceptResponseItemDVO;
    } else {
      _isChecked = widget.item.initiallyChecked;
    }

    if (_isChecked) widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
  }

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(
      draftAttribute: widget.item.attribute,
      checkboxSettings: (isChecked: _isChecked, onUpdateCheckbox: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
      expandFileReference: widget.expandFileReference,
      openFileDetails: widget.openFileDetails,
      titleOverride: widget.item.isDecidable && widget.item.mustBeAccepted ? (title) => '$title*' : null,
    );
  }

  void onUpdateCheckbox(bool? value) {
    if (value == null) return;

    setState(() {
      _isChecked = value;
    });

    handleCheckboxChange(isChecked: _isChecked, controller: widget.controller, itemIndex: widget.itemIndex);
  }
}
