import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/request_item_index.dart';
import '../../widgets/request_renderer_controller.dart';
import '../widgets/draft_attribute_renderer.dart';

class DecidableCreateAttributeRequestItemRenderer extends StatefulWidget {
  final DecidableCreateAttributeRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final LocalRequestStatus? requestStatus;

  const DecidableCreateAttributeRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.requestStatus,
  });

  @override
  State<DecidableCreateAttributeRequestItemRenderer> createState() => _DecidableCreateAttributeRequestItemRendererState();
}

class _DecidableCreateAttributeRequestItemRendererState extends State<DecidableCreateAttributeRequestItemRenderer> {
  bool isChecked = true;
  AbstractAttribute? newAttribute;

  void onUpdateCheckbox(bool? value) {
    setState(() {
      isChecked = value!;
    });

    if (isChecked) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
    } else {
      widget.controller?.writeAtIndex(
        index: widget.itemIndex,
        value: const RejectRequestItemParameters(),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    if (isChecked) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraftAttributeRenderer(draftAttribute: widget.item.attribute);
  }
}
