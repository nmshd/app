import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:renderers/src/request/request_item_renderer/decidable/checkbox_enabled_extension.dart';

import '../../../abstract_url_launcher.dart';
import '../../../custom_list_tile.dart';
import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableConsentRequestItemRenderer extends StatefulWidget {
  final DecidableConsentRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const DecidableConsentRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
  });

  @override
  State<DecidableConsentRequestItemRenderer> createState() => _DecidableConsentRequestItemRendererState();
}

class _DecidableConsentRequestItemRendererState extends State<DecidableConsentRequestItemRenderer> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked();

    if (isChecked) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: isChecked, onChanged: widget.item.checkboxEnabled ? onUpdateCheckbox : null),
        Expanded(
          child: CustomListTile(
            title: widget.item.name,
            description: widget.item.description,
            thirdLine: widget.item.consent,
            trailing: widget.item.link != null
                ? SizedBox(
                    width: 50,
                    child: IconButton(
                      icon: const Icon(Icons.open_in_new),
                      onPressed: () async {
                        final url = Uri.parse(widget.item.link!);
                        await GetIt.I.get<AbstractUrlLauncher>().launchSafe(url);
                      },
                    ),
                  )
                : null,
          ),
        ),
      ],
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
