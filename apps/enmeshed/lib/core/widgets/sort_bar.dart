import 'package:flutter/material.dart';

import '../utils/extensions.dart';

typedef SortMenuItem<T extends Enum> = ({T value, String label});

class SortBar<T extends Enum> extends StatefulWidget {
  final T sortingType;
  final bool isSortedAscending;
  final String Function(T) translate;
  final List<SortMenuItem<T>> sortMenuItem;
  final void Function({required T type, required bool isSortedAscending}) onSortingConditionChanged;

  const SortBar({
    required this.sortingType,
    required this.isSortedAscending,
    required this.onSortingConditionChanged,
    required this.sortMenuItem,
    required this.translate,
    super.key,
  });

  @override
  State<SortBar<T>> createState() => SortBarState();
}

class SortBarState<T extends Enum> extends State<SortBar<T>> {
  bool _isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(_isOpened ? '${context.l10n.sortBy} ...' : widget.translate(widget.sortingType)),
          PopupMenuButton(
            icon: const Icon(Icons.sort),
            offset: const Offset(40, 48),
            onOpened: () => setState(() => _isOpened = true),
            onCanceled: () => setState(() => _isOpened = false),
            onSelected: (type) {
              setState(() => _isOpened = false);

              widget.onSortingConditionChanged(type: type, isSortedAscending: widget.isSortedAscending);
            },
            itemBuilder: (context) {
              return widget.sortMenuItem.map((item) {
                return PopupMenuItem(value: item.value, child: Text(item.label));
              }).toList();
            },
          ),
          IconButton(
            onPressed: () => widget.onSortingConditionChanged(type: widget.sortingType, isSortedAscending: !widget.isSortedAscending),
            icon: Icon(widget.isSortedAscending ? Icons.arrow_upward : Icons.arrow_downward),
          ),
        ],
      ),
    );
  }
}
