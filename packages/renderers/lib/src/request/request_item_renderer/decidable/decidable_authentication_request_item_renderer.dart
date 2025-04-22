import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import 'checkbox_enabled_extension.dart';

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

        if (widget.validationResult != null && !widget.validationResult!.isSuccess)
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  child: Container(
                    color: Theme.of(context).colorScheme.error,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(Icons.error, color: Theme.of(context).colorScheme.onError),
                          ),
                          Text('Fehler', style: TextStyle(color: Theme.of(context).colorScheme.onError)),
                        ],
                      ),
                    ),
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

    if (isChecked) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
    } else {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const RejectRequestItemParameters());
    }
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () => widget.onUpdateToggle(!widget.value),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: widget.isDisabled ? Theme.of(context).colorScheme.surface.withAlpha(31) : Theme.of(context).colorScheme.surface,
            border: Border(),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(widget.text, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
              AnimatedAlign(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
                alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: widget.value ? context.customColors.success : Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child:
                        widget.value
                            ? Icon(Icons.check, key: ValueKey('check'), color: Theme.of(context).colorScheme.onPrimary)
                            : Icon(Icons.arrow_forward_ios, key: ValueKey('arrow'), color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
