import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/custom_list_tile.dart';
import '../../widgets/request_item_index.dart';
import '../../widgets/request_renderer_controller.dart';

class DecidableAuthenticationRequestItemRenderer extends StatefulWidget {
  final DecidableAuthenticationRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final LocalRequestStatus? requestStatus;

  const DecidableAuthenticationRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.requestStatus,
  });

  @override
  State<DecidableAuthenticationRequestItemRenderer> createState() => _DecidableAuthenticationRequestItemRendererState();
}

class _DecidableAuthenticationRequestItemRendererState extends State<DecidableAuthenticationRequestItemRenderer> {
  bool isChecked = true;

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

    widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: 'i18n://dvo.requestItem.DecidableAuthenticationRequestItem.name',
      description: widget.item.name,
      isChecked: isChecked,
      onUpdateCheckbox: onUpdateCheckbox,
      hideCheckbox: widget.requestStatus != LocalRequestStatus.ManualDecisionRequired && widget.item.mustBeAccepted,
    );
  }
}
