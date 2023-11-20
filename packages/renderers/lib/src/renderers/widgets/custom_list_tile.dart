import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

class CustomListTile extends StatefulWidget {
  final String title;
  final String? description;
  final Widget? trailing;
  final bool? isChecked;
  final bool? hideCheckbox;
  final String? selectedAttribute;
  final Function(bool?)? onUpdateCheckbox;

  const CustomListTile({
    super.key,
    required this.title,
    this.description,
    this.trailing,
    this.isChecked,
    this.hideCheckbox,
    this.selectedAttribute,
    this.onUpdateCheckbox,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.hideCheckbox != null && !widget.hideCheckbox!) Checkbox(value: widget.isChecked, onChanged: widget.onUpdateCheckbox),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TranslatedText(widget.title, style: const TextStyle(fontSize: 12, color: Color(0xFF42474E))),
                if (widget.description != null) ...[
                  const SizedBox(height: 2),
                  Text(widget.selectedAttribute ?? widget.description!, style: const TextStyle(fontSize: 16)),
                ]
              ],
            ),
          ),
        ),
        if (widget.trailing != null) SizedBox(width: 96, child: widget.trailing)
      ],
    );
  }
}
