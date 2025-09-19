import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '../../request_item_index.dart';
import '../../request_renderer_controller.dart';

class RatingFormFieldSettingsRenderer extends StatefulWidget {
  final FormFieldRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const RatingFormFieldSettingsRenderer({required this.item, required this.controller, required this.itemIndex, super.key});

  @override
  State<RatingFormFieldSettingsRenderer> createState() => _RatingFormFieldSettingsRendererState();
}

class _RatingFormFieldSettingsRendererState extends State<RatingFormFieldSettingsRenderer> {
  int? _value;

  @override
  void initState() {
    super.initState();

    if (widget.item.response is FormFieldAcceptResponseItemDVO) {
      final response = widget.item.response as FormFieldAcceptResponseItemDVO;
      _value = (response.response as FormFieldNumResponse).value.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxRating = (widget.item.settings as RatingFormFieldSettings).maxRating;

    if (maxRating == 5) {
      return Wrap(
        children: [
          for (var i = 1; i <= 5; i++)
            IconButton(
              icon: i <= (_value ?? 0) ? Icon(Icons.star) : Icon(Icons.star_border),
              onPressed: widget.item.isDecidable ? () => _onChanged(i) : null,
              color: i <= (_value ?? 0) ? Theme.of(context).colorScheme.primary : null,
              tooltip: i.toString(),
            ),
        ],
      );
    }

    return Wrap(
      spacing: 4,
      runSpacing: 8,
      children: [
        for (var i = 1; i <= maxRating; i++)
          InputChip(
            label: Text(i.toString()),
            selected: i == _value,
            showCheckmark: false,
            onSelected: widget.item.isDecidable ? (_) => _onChanged(i) : null,
            shape: i == 10 ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)) : CircleBorder(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
      ],
    );
  }

  void _onChanged(int? newValue) {
    setState(() => _value = (newValue == _value ? null : newValue));

    final params = newValue == null ? RejectRequestItemParameters() : AcceptFormFieldRequestItemParameters(response: FormFieldNumResponse(newValue));
    widget.controller?.writeAtIndex(index: widget.itemIndex, value: params);
  }
}
