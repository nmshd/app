import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../abstract_url_launcher.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/request_item_index.dart';
import '../../widgets/request_renderer_controller.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableConsentRequestItemRenderer extends StatefulWidget {
  final DecidableConsentRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final LocalRequestStatus? requestStatus;

  const DecidableConsentRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
    this.requestStatus,
  });

  @override
  State<DecidableConsentRequestItemRenderer> createState() => _DecidableConsentRequestItemRendererState();
}

class _DecidableConsentRequestItemRendererState extends State<DecidableConsentRequestItemRenderer> {
  bool isChecked = true;

  @override
  void initState() {
    super.initState();

    widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: widget.item.consent,
      description: widget.item.description,
      onUpdateCheckbox: onUpdateCheckbox,
      isChecked: isChecked,
      hideCheckbox: widget.item.requireManualDecision == true && widget.item.mustBeAccepted,
      trailing: widget.item.link != null
          ? IconButton(
              onPressed: () async {
                final url = Uri.parse(widget.item.link!);
                await GetIt.I.get<AbstractUrlLauncher>().launchSafe(url);
              },
              icon: const Icon(Icons.open_in_new),
            )
          : null,
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
