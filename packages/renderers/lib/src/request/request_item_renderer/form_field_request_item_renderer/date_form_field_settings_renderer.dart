import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';
import 'package:intl/intl.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';

class DateFormFieldSettingsRenderer extends StatefulWidget {
  final FormFieldRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;
  final void Function(VoidCallback? onTap) setOnTap;

  const DateFormFieldSettingsRenderer({required this.item, required this.controller, required this.itemIndex, required this.setOnTap, super.key});

  @override
  State<DateFormFieldSettingsRenderer> createState() => _DateFormFieldSettingsRendererState();
}

class _DateFormFieldSettingsRendererState extends State<DateFormFieldSettingsRenderer> {
  DateTime? _value;

  @override
  void initState() {
    super.initState();

    widget.setOnTap(() => _onTap());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.response is RejectResponseItemDVO) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          FlutterI18n.translate(context, 'requestRenderer.formField.noValue'),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.outlineVariant),
        ),
      );
    }

    if (widget.item.response is FormFieldAcceptResponseItemDVO) {
      final response = widget.item.response as FormFieldAcceptResponseItemDVO;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          DateFormat.yMd(Localizations.localeOf(context).languageCode).format(DateTime.parse((response.response as FormFieldStringResponse).value)),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        _value == null
            ? FlutterI18n.translate(context, 'requestRenderer.formField.noValue')
            : DateFormat.yMd(Localizations.localeOf(context).languageCode).format(_value!),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: _value == null ? Theme.of(context).colorScheme.outlineVariant : null),
      ),
    );
  }

  void _onTap() async {
    if (_value != null) {
      final result = await showDialog<String>(context: context, builder: (BuildContext context) => const _AdjustDateDialog());
      if (result == null) return;

      if (result == 'remove') {
        setState(() => _value = null);
        widget.controller?.writeAtIndex(index: widget.itemIndex, value: RejectRequestItemParameters());
        return;
      }
    }

    if (!mounted) return;

    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(0),
      lastDate: DateTime.now().add(const Duration(days: 365 * 1000)),
      initialDate: _value ?? DateTime.now(),
    );

    if (date == null) return;

    setState(() => _value = date);
    widget.controller?.writeAtIndex(
      index: widget.itemIndex,
      value: AcceptFormFieldRequestItemParameters(response: FormFieldStringResponse(_value!.toIso8601String())),
    );
  }
}

class _AdjustDateDialog extends StatelessWidget {
  const _AdjustDateDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: const TranslatedText('i18n://requestRenderer.formField.datePicker.adjustDateDialog.title')),
          IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
        ],
      ),
      titlePadding: EdgeInsets.only(top: 8, right: 8, left: 24),
      content: const TranslatedText('i18n://requestRenderer.formField.datePicker.adjustDateDialog.description'),
      actions: <Widget>[
        TextButton(
          onPressed: () => context.pop('remove'),
          child: const TranslatedText('i18n://requestRenderer.formField.datePicker.adjustDateDialog.remove'),
        ),
        TextButton(
          onPressed: () => context.pop('change'),
          child: const TranslatedText('i18n://requestRenderer.formField.datePicker.adjustDateDialog.change'),
        ),
      ],
    );
  }
}
