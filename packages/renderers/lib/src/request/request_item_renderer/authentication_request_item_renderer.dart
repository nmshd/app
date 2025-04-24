import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';
import 'package:renderers/src/request/request_item_renderer/decidable/checkbox_enabled_extension.dart';

import '../request_item_index.dart';
import '../request_renderer_controller.dart';

class AuthenticationRequestItemRenderer extends StatefulWidget {
  final AuthenticationRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final RequestValidationResultDTO? validationResult;

  const AuthenticationRequestItemRenderer({super.key, required this.item, this.controller, required this.itemIndex, this.validationResult});

  @override
  State<AuthenticationRequestItemRenderer> createState() => _AuthenticationRequestItemRendererState();
}

class _AuthenticationRequestItemRendererState extends State<AuthenticationRequestItemRenderer> {
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
    final title = widget.item.mustBeAccepted && widget.item.response == null ? '${widget.item.name}*' : widget.item.name;

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
                        child: _CustomAnimatedToggleSwitch(
                          value: _isChecked,
                          onUpdateToggle: _onUpdateToggle,
                          text: 'Annehmen',
                          isDecidable: widget.item.isDecidable,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        if (widget.item.isDecidable && widget.validationResult != null && !widget.validationResult!.isSuccess)
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
                          TranslatedText(
                            'i18n://requestRenderer.errors.${widget.validationResult!.code!}',
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onError),
                          ),
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

    setState(() => _isChecked = value);

    if (_isChecked) {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const AcceptRequestItemParameters());
    } else {
      widget.controller?.writeAtIndex(index: widget.itemIndex, value: const RejectRequestItemParameters());
    }
  }
}

class _CustomAnimatedToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onUpdateToggle;
  final String text;
  final bool isDecidable;

  const _CustomAnimatedToggleSwitch({required this.value, required this.onUpdateToggle, required this.text, required this.isDecidable});

  @override
  State<_CustomAnimatedToggleSwitch> createState() => _CustomAnimatedToggleSwitchState();
}

class _CustomAnimatedToggleSwitchState extends State<_CustomAnimatedToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    final circleColor = widget.value ? context.customColors.success : Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 64,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Theme.of(context).colorScheme.surface, border: Border()),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              widget.text,
              style:
                  widget.isDecidable
                      ? Theme.of(context).textTheme.headlineSmall
                      : Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onSurface.withAlpha(96)),
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                Expanded(
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: widget.value,
                    first: false,
                    second: true,
                    spacing: 0,
                    height: 55,
                    indicatorSize: const Size(50, 50),
                    indicatorTransition: ForegroundIndicatorTransition.fading(),
                    style: ToggleStyle(
                      borderColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      indicatorColor: widget.isDecidable ? circleColor : circleColor.withAlpha(41),
                      indicatorBorderRadius: BorderRadius.circular(50),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onChanged: widget.isDecidable ? (value) => widget.onUpdateToggle(!widget.value) : null,
                    iconBuilder:
                        (value) =>
                            value
                                ? Icon(Icons.check, color: context.customColors.onSuccess)
                                : Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
