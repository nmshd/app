import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

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
  bool _value = false;

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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(widget.item.name, style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 4),
                if (widget.item.description != null) Text(widget.item.description!, style: Theme.of(context).textTheme.bodySmall),
                Container(
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _CustomToggle(value: _value, onChanged: (newValue) => setState(() => _value = newValue), text: 'Annehmen'),
                  ),
                ),
              ],
            ),
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

    handleCheckboxChange(isChecked: isChecked, controller: widget.controller, itemIndex: widget.itemIndex);
  }
}

class _CustomToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String text;

  const _CustomToggle({required this.value, required this.onChanged, required this.text});

  @override
  State<_CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<_CustomToggle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Theme.of(context).colorScheme.surface, border: Border()),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: widget.value ? Colors.green : Colors.blue, shape: BoxShape.circle),
                child: Icon(Icons.arrow_back_ios_new_outlined),
              ),
            ),
            Text(widget.text, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
