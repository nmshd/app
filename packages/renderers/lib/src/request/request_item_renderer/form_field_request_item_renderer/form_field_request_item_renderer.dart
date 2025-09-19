import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:renderers/src/request/request_item_renderer/form_field_request_item_renderer/boolean_form_field_settings_renderer.dart';
import 'package:renderers/src/request/request_item_renderer/form_field_request_item_renderer/date_form_field_settings_renderer.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';
import '../widgets/validation_error_box.dart';
import 'number_form_field_settings_renderer.dart';
import 'rating_form_field_settings_renderer.dart';
import 'selection_form_field_settings_renderer.dart';
import 'string_form_field_settings_renderer.dart';

class FormFieldRequestItemRenderer extends StatefulWidget {
  final FormFieldRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  final RequestValidationResultDTO? validationResult;

  const FormFieldRequestItemRenderer({super.key, required this.item, this.controller, required this.itemIndex, this.validationResult});

  @override
  State<FormFieldRequestItemRenderer> createState() => _DecidableFormFieldRequestItemRendererState();
}

class _DecidableFormFieldRequestItemRendererState extends State<FormFieldRequestItemRenderer> {
  VoidCallback? _onTap;

  @override
  Widget build(BuildContext context) {
    final title = widget.item.title;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.isDecidable && widget.item.mustBeAccepted ? '$title*' : title, style: Theme.of(context).textTheme.labelLarge),
            switch (widget.item.settings) {
              final BooleanFormFieldSettings _ => BooleanFormFieldSettingsRenderer(
                item: widget.item,
                controller: widget.controller,
                itemIndex: widget.itemIndex,
              ),
              DateFormFieldSettings() => DateFormFieldSettingsRenderer(
                item: widget.item,
                controller: widget.controller,
                itemIndex: widget.itemIndex,
                setOnTap: _setOnTap,
              ),
              DoubleFormFieldSettings() => NumberFormFieldSettingsRenderer(
                item: widget.item,
                controller: widget.controller,
                itemIndex: widget.itemIndex,
                setOnTap: _setOnTap,
              ),
              IntegerFormFieldSettings() => NumberFormFieldSettingsRenderer(
                item: widget.item,
                controller: widget.controller,
                itemIndex: widget.itemIndex,
                setOnTap: _setOnTap,
              ),
              RatingFormFieldSettings() => RatingFormFieldSettingsRenderer(
                item: widget.item,
                controller: widget.controller,
                itemIndex: widget.itemIndex,
              ),
              final SelectionFormFieldSettings _ => SelectionFormFieldSettingsRenderer(
                item: widget.item,
                controller: widget.controller,
                itemIndex: widget.itemIndex,
              ),
              StringFormFieldSettings() => StringFormFieldSettingsRenderer(
                item: widget.item,
                controller: widget.controller,
                itemIndex: widget.itemIndex,
                setOnTap: _setOnTap,
              ),
            },
            if (widget.item.description != null) Text(widget.item.description!, style: Theme.of(context).textTheme.labelMedium),
            if (!(widget.validationResult?.isSuccess ?? true))
              ValidationErrorBox(validationResult: widget.validationResult!, rendererName: 'formField'),
          ],
        ),
      ),
    );
  }

  void _setOnTap(VoidCallback? onTap) => WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _onTap = onTap));
}
