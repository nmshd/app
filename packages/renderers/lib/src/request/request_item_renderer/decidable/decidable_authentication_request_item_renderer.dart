import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import 'checkbox_enabled_extension.dart';
import 'widgets/handle_checkbox_change.dart';

class DecidableAuthenticationRequestItemRenderer extends StatefulWidget {
  final DecidableAuthenticationRequestItemDVO item;
  final RequestItemIndex itemIndex;
  final RequestRendererController? controller;
  final RequestValidationResultDTO? validationResult;

  const DecidableAuthenticationRequestItemRenderer({super.key, required this.item, required this.itemIndex, this.controller, this.validationResult});

  @override
  State<DecidableAuthenticationRequestItemRenderer> createState() => _DecidableAuthenticationRequestItemRendererState();
}

class _DecidableAuthenticationRequestItemRendererState extends State<DecidableAuthenticationRequestItemRenderer> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();

    isChecked = widget.item.initiallyChecked;

    if (isChecked) widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.item.mustBeAccepted ? '${widget.item.name}*' : widget.item.name;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16)),
                    Gaps.h4,
                    if (widget.item.description != null) Text(widget.item.description!, style: Theme.of(context).textTheme.bodySmall),
                    Container(
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _CustomToggle(value: isChecked, onUpdateToggle: _onUpdateToggle, text: 'Annehmen'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onUpdateToggle(bool? value) {
    if (value == null) return;

    setState(() => isChecked = value);

    handleCheckboxChange(isChecked: isChecked, controller: widget.controller, itemIndex: widget.itemIndex);
  }
}

class _CustomToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onUpdateToggle;
  final String text;

  const _CustomToggle({required this.value, required this.onUpdateToggle, required this.text});

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
