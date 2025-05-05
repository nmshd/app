import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

import '../request_item_index.dart';
import '../request_renderer_controller.dart';
import 'decidable/widgets/validation_error_box.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(children: [TextSpan(text: widget.item.name), if (widget.item.isDecidable && widget.item.mustBeAccepted) TextSpan(text: '*')]),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (widget.item.description != null) Text(widget.item.description!, style: Theme.of(context).textTheme.bodySmall),
          Gaps.h8,
          _AuthenticationBox(item: widget.item, value: _isChecked, onUpdateToggle: _onUpdateToggle, text: 'Annehmen'),
          if (!(widget.validationResult?.isSuccess ?? true)) ...[Gaps.h8, ValidationErrorBox(validationResult: widget.validationResult!)],
        ],
      ),
    );
  }

  void _onUpdateToggle(bool value) {
    setState(() => _isChecked = value);

    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: value ? const AcceptRequestItemParameters() : const RejectRequestItemParameters(),
    );
  }
}

class _AuthenticationBox extends StatelessWidget {
  final AuthenticationRequestItemDVO item;
  final bool value;
  final ValueChanged<bool> onUpdateToggle;
  final String text;

  const _AuthenticationBox({required this.item, required this.value, required this.onUpdateToggle, required this.text});

  @override
  Widget build(BuildContext context) {
    final active = item.isDecidable && !item.initiallyChecked;

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Theme.of(context).colorScheme.surfaceContainerHigh),
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Theme.of(context).colorScheme.surface),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: active ? null : 0.16)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: AnimatedToggleSwitch<bool>.dual(
                  active: active,
                  current: value,
                  first: false,
                  second: true,
                  indicatorSize: const Size.square(50),
                  indicatorTransition: ForegroundIndicatorTransition.fading(),
                  style: ToggleStyle(
                    borderColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    indicatorColor: value ? context.customColors.success : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onChanged: onUpdateToggle,
                  iconBuilder: (checked) {
                    if (checked) return Icon(Icons.check, color: context.customColors.onSuccess);

                    return Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.onPrimary);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
