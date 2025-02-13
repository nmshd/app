import 'package:flutter/material.dart';

class HighlightText extends StatefulWidget {
  final String text;
  final String? query;
  final TextStyle? textStyle;
  final int? maxLines;

  const HighlightText({required this.text, super.key, this.query, this.textStyle, this.maxLines});

  @override
  State<HighlightText> createState() => _HighlightTextState();
}

class _HighlightTextState extends State<HighlightText> {
  @override
  Widget build(BuildContext context) {
    if (widget.query == null) return Text(widget.text, style: widget.textStyle, maxLines: widget.maxLines, overflow: TextOverflow.ellipsis);

    final textSpans = <TextSpan>[];
    final matches = RegExp(RegExp.escape(widget.query!), caseSensitive: false).allMatches(widget.text);
    var index = 0;

    for (final match in matches) {
      if (widget.text.substring(index, match.start).isNotEmpty) {
        textSpans.add(TextSpan(text: widget.text.substring(index, match.start), style: widget.textStyle));
      }

      textSpans.add(
        TextSpan(
          text: widget.text.substring(match.start, match.end),
          style:
              widget.textStyle != null
                  ? widget.textStyle?.copyWith(backgroundColor: Theme.of(context).colorScheme.primaryContainer)
                  : TextStyle(backgroundColor: Theme.of(context).colorScheme.primaryContainer),
        ),
      );

      index = match.end;
    }

    if (index < widget.text.length) {
      final remainingText = widget.text.substring(index);
      textSpans.add(TextSpan(text: remainingText, style: widget.textStyle));
    }

    return Text.rich(TextSpan(children: textSpans), maxLines: widget.maxLines, overflow: TextOverflow.ellipsis);
  }
}
